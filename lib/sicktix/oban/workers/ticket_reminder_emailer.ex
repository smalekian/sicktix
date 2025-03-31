defmodule Sicktix.Oban.Workers.TicketReminderEmailer do
  use Oban.Worker, queue: :emailers

  alias Sicktix.Email.Interface, as: EmailInterface

  @impl Oban.Worker
  def perform(%Oban.Job{
        args: %{"event_id" => _event_id, "owner" => %{"user" => _user_id}} = args
      }) do
    EmailInterface.send(:ticket_reminder, args)

    :ok
  end
end
