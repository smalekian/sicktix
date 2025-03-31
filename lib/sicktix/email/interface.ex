defmodule Sicktix.Email.Interface do
  require Logger

  alias Sicktix.Email.{
    TicketConfirm,
    TicketReminder
  }

  alias Sicktix.Oban.Workers.{
    TicketReminderEmailer
  }

  @type_builder_mapping %{
    ticket_confirm: TicketConfirm,
    ticket_reminder: TicketReminder
  }

  @type_email_queue_mapping %{
    ticket_reminder: TicketReminderEmailer
  }

  def send(%Swoosh.Email{} = email), do: Sicktix.Mailer.deliver(email)

  def send(type, payload) do
    try do
      email_module = @type_builder_mapping[type]

      if apply(email_module, :payload_valid?, [payload]) do
        email_module
        |> apply(:build, [payload])
        |> send()
      else
        raise ArgumentError, "invalid payload for email type #{inspect(type)}"
      end
    rescue
      error ->
        Logger.error(
          "[Sicktix.Email.Interface] error sending email of type #{inspect(type)} and payload #{inspect(payload)} with error: #{inspect(error)}"
        )

        {:error, error}
    end
  end

  def queue_at(type, payload, scheduled_at_ts) do
    try do
      if apply(@type_builder_mapping[type], :payload_valid?, [payload]) do
        payload
        |> @type_email_queue_mapping[type].new(scheduled_at: scheduled_at_ts)
        |> Oban.insert()
      else
        raise ArgumentError, "invalid payload for email type #{inspect(type)}"
      end
    rescue
      error ->
        Logger.error(
          "[Sicktix.Email.Interface] error queueing email of type #{inspect(type)} and payload #{inspect(payload)} with error: #{inspect(error)}"
        )

        {:error, error}
    end
  end
end
