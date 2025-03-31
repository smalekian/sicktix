defmodule Sicktix.Schemas.Tickets.Interface do
  require Logger

  import Ecto.Query

  alias Ecto.Changeset
  alias Phoenix.PubSub
  alias Sicktix.{EtsManager, Repo}
  alias Sicktix.Schemas.{Events, Tickets, VenueSeating}
  alias Sicktix.Email.Interface, as: EmailInterface

  def create_all_tickets_for_event(
        %Events{
          id: event_id,
          event_type_id: event_type_id,
          venue_id: venue_id
        } = event
      ) do
    # query VenueSeating for event_type_id and venue_id
    # based on seating_chart, generate list of seat_ids, and use that to create the tickets
    Logger.info(
      "[Sicktix.Schemas.Tickets.Interface create_all_tickets_for_event/1] creating tickets for event #{inspect(event)}"
    )

    try do
      venue_seating_query =
        from(vs in VenueSeating,
          where: vs.venue_id == ^venue_id and vs.event_type == ^event_type_id
        )

      %VenueSeating{seating_chart: seating_chart} = Repo.one(venue_seating_query)

      # seating_chart structured like:
      # %{"mezzanine" => [
      #   %{"row" => "G", "seat" => "1", "section" => "250"},
      #   %{"row" => "G", "seat" => "2", "section" => "250"}
      # ],
      # "balcony" => [
      #   %{"row" => "G", "seat" => "1", "section" => "250"},
      #   %{"row" => "G", "seat" => "2", "section" => "250"}
      # ]}
      #
      # map through each individual seat to generate seat_id create the tickets
      # seat_id is compound key of venue, event_type, level, section, row, and seat
      Enum.each(
        seating_chart,
        fn {level, seats} ->
          Enum.each(
            seats,
            fn %{"section" => section, "row" => row, "seat" => seat} ->
              seat_id = "#{venue_id}.#{event_type_id}.#{level}.#{section}.#{row}.#{seat}"

              ticket_attrs = %{
                event_id: "#{event_id}",
                seat_id: seat_id,
                taken?: false,
                status: "active"
              }

              create_ticket(ticket_attrs)
            end
          )
        end
      )

      # PubSub.broadcast(:sicktix_pubsub, "event", {"created.success", event})
      Logger.info(
        "[Sicktix.Schemas.Tickets.Interface create_all_tickets_for_event/1] ticket created for event #{inspect(event)}"
      )

      {:ok, :tickets_created}
    rescue
      error ->
        Logger.error(
          "[Sicktix.Schemas.Tickets.Interface create_all_tickets_for_event/1] error occurred creating tickets for event #{inspect(error)}"
        )

        # PubSub.broadcast(:sicktix_pubsub, "event", {"created.failure", event})
        {:error, error}
    end
  end

  def create_ticket(%{} = attrs) do
    try do
      %Changeset{errors: []} = ticket_cs = Tickets.changeset(%Tickets{}, attrs)
      Repo.insert(ticket_cs)
    rescue
      error ->
        Logger.error(
          "[Sicktix.Schemas.Tickets.Interface] error occurred creating ticket: #{inspect(error)}"
        )

        {:error, error}

        # error ->
        #   Logger.error(
        #     "[Sicktix.Schemas.Tickets.Interface] error occurred creating ticket: #{inspect(error)}"
        #   )

        #   {:error, error}
    end
  end

  def get_ticket(id) when is_integer(id) do
    {
      :ok,
      Repo.get(Tickets, id)
    }
  end

  def get_ticket(id) when is_binary(id) do
    try do
      id = String.to_integer(id)

      {
        :ok,
        Repo.get(Tickets, id)
      }
    rescue
      ArgumentError ->
        {:error, "id_must_be_int"}

      error ->
        Logger.error(
          "[Sicktix.Schemas.Tickets.Interface] unhandled error fetching ticket #{inspect(error)}"
        )

        {:error, error}
    end
  end

  def claim_ticket(%{"id" => id, "owner" => %{"user" => _user_id} = owner}) do
    # TODO: currently only supports claiming one ticket at a time, extend to support claiming multiple for same event
    updated_data = %{
      owner: owner,
      taken?: true
    }

    opts = [returning: true]

    with {:ok, :inserted} <- GenServer.call(EtsManager, {:insert, :locked_tickets, id}),
         {:ok, %Tickets{event_id: event_id, taken?: false} = current_ticket} <- get_ticket(id),
         cs <- Tickets.changeset(current_ticket, updated_data),
         {:ok, claimed_ticket} <- Repo.update(cs, opts),
         :ok <-
           PubSub.broadcast(:sicktix_pubsub, "ticket", {"claimed.success", claimed_ticket}),
         {:ok, _} <-
           EmailInterface.send(:ticket_confirm, claimed_ticket),
         {:ok, %Events{start_datetime: start_iso}} <- Events.Interface.get_event(event_id),
         email_reminder_datetime <- generate_ticket_reminder_email_datetime(start_iso),
         claimed_ticket = Sicktix.Util.convert_ecto(claimed_ticket),
         {:ok, %Oban.Job{}} <-
           EmailInterface.queue_at(:ticket_reminder, claimed_ticket, email_reminder_datetime) do
      {:ok, claimed_ticket}
    else
      {:error, :collision} ->
        log_taken_ticket()

      %Tickets{taken?: true} ->
        log_taken_ticket()

      error ->
        Logger.error(
          "[Sicktix.Schemas.Tickets.Interface] unhandled error claiming ticket #{inspect(error)}"
        )

        {:error, error}
    end
  end

  defp log_taken_ticket() do
    Logger.error("[Sicktix.Schemas.Tickets.Interface] ticket already claimed")
    {:error, "ticket already claimed"}
  end

  defp generate_ticket_reminder_email_datetime(start_iso) do
    {:ok, start_dt, 0} = DateTime.from_iso8601(start_iso)
    DateTime.add(start_dt, -1, :day)
  end
end
