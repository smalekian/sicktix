defmodule SicktixWeb.TicketController do
  use SicktixWeb, :controller

  # require Logger

  alias Sicktix.Schemas.Tickets.Interface, as: TicketInterface

  def claim(conn, %{"id" => _ticket_id, "owner" => %{"user" => _user_id}} = params) do
    # TODO: authentication
    # TODO: authorization

    # TODO: currently only supports claiming one ticket at a time, extend to support claiming multiple for same event
    with {:ok, %{taken?: true} = claimed_ticket} <- TicketInterface.claim_ticket(params),
         claimed_ticket <- convert_ecto(claimed_ticket) do
      conn
      |> json(claimed_ticket)
    else
      {:ok, :already_claimed} ->
        conn
        |> send_resp(400, "Ticket already claimed")

      {:ok, nil} ->
        conn
        |> send_resp(404, "Not found")

      _error ->
        conn
        |> send_resp(400, "Bad Request")
    end
  end
end
