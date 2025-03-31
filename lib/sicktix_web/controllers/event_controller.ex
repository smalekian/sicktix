defmodule SicktixWeb.EventController do
  use SicktixWeb, :controller

  # require Logger

  alias Sicktix.Schemas.Events.Interface, as: EventInterface

  def index(conn, _params) do
    # TODO: authentication
    # TODO: authorization
    with {:ok, events} <- EventInterface.get_events(),
         events <- convert_ecto(events) do
      conn
      |> json(events)
    else
      _error ->
        conn
        |> send_resp(400, "Bad Request")
    end
  end

  def show(conn, %{"id" => id}) do
    # TODO: authentication
    # TODO: authorization
    with {:ok, %{id: _id} = event} <- EventInterface.get_event(id),
         event <- convert_ecto(event) do
      conn
      |> json(event)
    else
      {:ok, nil} ->
        conn
        |> send_resp(404, "Not found")

      _error ->
        conn
        |> send_resp(400, "Bad Request")
    end
  end

  def create(
        conn,
        %{
          "name" => _name,
          "event_type_id" => _event_type_id,
          "venue_id" => _venue_id,
          "status" => _status,
          "start_datetime" => _start_datetime,
          "end_datetime" => _end_datetime,
          "performers" => _performers
        } = params
      ) do
    # TODO: authentication
    # TODO: authorization
    with {:ok, %{id: _id} = event} <- EventInterface.create_event(params),
         event <- convert_ecto(event) do
      conn
      |> json(event)
    else
      _error ->
        conn
        |> send_resp(400, "Bad Request")
    end
  end
end
