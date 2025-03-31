defmodule Sicktix.Email.TicketReminder do
  import Swoosh.Email

  require Logger

  alias Sicktix.Schemas.Users.Interface, as: UserInterface
  alias Sicktix.Schemas.Events.Interface, as: EventInterface

  @email_type :ticket_confirm

  def build(%{"event_id" => event_id, "owner" => %{"user" => user_id}}) do
    with {:ok, %{name: event_name}} <- EventInterface.get_event(event_id),
         {:ok, %{email: user_email, data: %{"first_name" => user_fn, "last_name" => user_ln}}} <-
           UserInterface.get_user(user_id),
         from_email when is_binary(from_email) <-
           Application.get_env(:sicktix, :from_emails)[@email_type] do
      user_full = user_fn <> " " <> user_ln

      new()
      |> to({user_full, user_email})
      |> from({"SickTix", from_email})
      |> subject("Your event is coming up!")
      |> html_body("""
      <h1>Hello #{user_fn}</h1>
      <h2>REMINDER</h2>
      <p>You have tickets for the upcoming event: #{event_name}!</p>
      """)
    else
      error ->
        Logger.error(
          "[Sicktix.Email.Confirm] error building confirmation email for event #{event_id} and user #{user_id}"
        )

        {:error, error}
    end
  end

  def payload_valid?(%{"event_id" => event_id, "owner" => %{"user" => user_id}})
      when is_binary(event_id) and is_binary(user_id),
      do: true

  def payload_valid?(_), do: false
end
