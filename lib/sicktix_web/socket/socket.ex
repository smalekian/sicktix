defmodule SicktixWeb.Socket do
  use Phoenix.Socket

  require Logger

  channel "user", SicktixWeb.UserChannel

  def connect(_, socket, _connect_info) do
    {:ok, socket}
    # TODO: Get bearer token, verify, then connect
    # with {:ok, claims} <- Token.verify_and_validate(token) do
    #   open_id = claims["sub"]
    # else
    #   {:error, reason} ->
    #     Logger.error(reason)
    #     :error
    #   _ ->
    #     Logger.error("AuthPlug unhandled exception in verifying token")
    #     :error
    # end
  end

  def id(_socket), do: "user"
end
