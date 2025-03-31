defmodule Sicktix.Subsribers.Events.TicketCreator do
  use GenServer
  require Logger
  alias Phoenix.PubSub
  # alias SicktixWeb.Endpoint
  alias Sicktix.Schemas.Events
  alias Sicktix.Schemas.Tickets.Interface, as: TicketsInterface

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def init(_) do
    PubSub.subscribe(:sicktix_pubsub, "event")
    {:ok, %{}}
  end

  def handle_info(
        {"created.success", %Events{} = event},
        state
      ) do
    Logger.info(
      "[Sicktix.Subsribers.Events.TicketCreator] Triggering creation of tickets for event #{inspect(event.id)}"
    )

    TicketsInterface.create_all_tickets_for_event(event)
    # Endpoint.broadcast(
    #   "user",
    #   "heyy",
    #   event
    # )

    {:noreply, state}
  end

  def handle_info(msg, state) do
    Logger.warning("[PubSub] Unhandled message: #{inspect(msg)}")
    {:noreply, state}
  end
end
