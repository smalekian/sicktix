defmodule Sicktix.EtsManager do
  use GenServer

  require Logger

  @ets_tables [
    :locked_tickets
  ]

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    Enum.each(
      @ets_tables,
      &:ets.new(&1, [:named_table, :public, :set])
    )

    {:ok, %{}}
  end

  def handle_call({:insert, table, id}, _from, state) when is_atom(table) do
    # first statement unifies potential string, atom, int ids to be strings to ensure necessary collisions happen
    resp =
      with id <- "#{id}",
           true <- :ets.insert_new(table, {id}) do
        Logger.debug("[Sicktix.EtsManager] Inserted entry for id #{id} into table #{table}")

        {:ok, :inserted}
      else
        false ->
          Logger.error(
            "[Sicktix.EtsManager] Could not perform insertion because collision at id: #{inspect(id)}"
          )

          {:error, :collision}

        error ->
          Logger.error("[Sicktix.EtsManager] Error performing ets insertion: #{inspect(error)}")
          {:error, error}
      end

    {:reply, resp, state}
  end

  def handle_call({:delete, table, id}, _from, state) when is_atom(table),
    do: {:reply, :ets.delete(table, "#{id}"), state}

  def handle_call(msg, _from, state) do
    Logger.warning("[Sicktix.EtsManager] Unhandled call: #{inspect(msg)}")
    {:noreply, state}
  end
end
