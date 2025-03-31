defmodule Sicktix.Schemas.Events.Interface do
  require Logger

  # import Ecto.Query

  alias Phoenix.PubSub
  alias Ecto.Changeset
  alias Sicktix.Repo
  alias Sicktix.Schemas.Events

  def get_events() do
    {
      :ok,
      Repo.all(Events)
    }
  end

  def get_event(id) when is_integer(id) do
    {
      :ok,
      Repo.get(Events, id)
    }
  end

  def get_event(id) when is_binary(id) do
    try do
      id = String.to_integer(id)

      {
        :ok,
        Repo.get(Events, id)
      }
    rescue
      ArgumentError ->
        {:error, "id_must_be_int"}

      error ->
        Logger.error(
          "[Sicktix.Schemas.Events.Interface] unhandled error fetching event #{inspect(error)}"
        )

        {:error, error}
    end
  end

  def create_event(%{} = attrs, seeding_opts \\ nil) do
    Logger.info("[Sicktix.Schemas.Events.Interface] creating event with attrs #{inspect(attrs)}")

    with %Changeset{errors: []} = event_cs <- Events.changeset(%Events{}, attrs),
         {:ok, %Events{} = event} = resp <- Repo.insert(event_cs),
         nil <- seeding_opts[:seeding],
         :ok <- PubSub.broadcast(:sicktix_pubsub, "event", {"created.success", event}) do
      Logger.info("[Sicktix.Schemas.Events.Interface] event created #{inspect(event)}")
      resp
    else
      true ->
        {:ok, :seeded}

      error ->
        Logger.error(
          "[Sicktix.Schemas.Events.Interface] error occurred creating event #{inspect(error)}"
        )

        {:error, error}
    end

    # try do
    #   %Changeset{errors: []} = event_cs = Events.changeset(%Events{}, attrs)
    #   Repo.insert(event_cs)
    # rescue
    #   error ->
    #     Logger.error("[Sicktix.Schemas.Events.Interface] error occurred creating event #{inspect error}")
    #     {:error, error}
    # end
  end
end
