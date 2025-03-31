defmodule SicktixWeb.EventSubscriber do
  # use GenServer
  # require Logger
  # alias Phoenix.PubSub
  # alias SicktixWeb.Endpoint

  # def start_link(_) do
  #   GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  # end

  # def get() do
  #   GenServer.call(__MODULE__, :get)
  # end

  # def init(_) do
  #   PubSub.subscribe(:sicktix_pubsub, "event")
  #   {:ok, %{}}
  # end

  # def handle_info(
  #       {"created.success", event},
  #       state
  #     ) do
  #   Logger.info("[PubSub] #{inspect(event)}")

  #   # Endpoint.broadcast(
  #   #   "user",
  #   #   "heyy",
  #   #   event
  #   # )

  #   {:noreply, state}
  # end

  # def handle_info(msg, state) do
  #   Logger.warning("[PubSub] Unhandled message: #{inspect(msg)}")
  #   {:noreply, state}
  # end
end
