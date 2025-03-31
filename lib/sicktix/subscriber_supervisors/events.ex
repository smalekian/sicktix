defmodule Sicktix.SubscriberSupervisors.Events do
  use Supervisor

  alias Sicktix.Subsribers.Events.TicketCreator

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      TicketCreator
      # TicketUpdater,
      # TicketDeleter,
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
