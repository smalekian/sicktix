defmodule Sicktix.Repo do
  use Ecto.Repo,
    otp_app: :sicktix,
    adapter: Ecto.Adapters.Postgres
end
