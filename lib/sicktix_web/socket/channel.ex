defmodule SicktixWeb.UserChannel do
  use SicktixWeb, :channel

  def join("user", _params, socket), do: {:ok, socket}
end
