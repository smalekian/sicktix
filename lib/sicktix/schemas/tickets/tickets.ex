defmodule Sicktix.Schemas.Tickets do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "tickets" do
    field(:event_id, :string)
    field(:seat_id, :string)
    field(:taken?, :boolean)
    field(:status, :string)
    field(:reason, :string)
    field(:owner, :map)
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(event_id seat_id taken? status)a
  @optional_fields ~w(owner reason data metadata tags)a
  def changeset(ticket, params \\ %{}) do
    ticket
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_change(:status, fn :status, status ->
      # TODO: refactor to refer to shared list
      allowed_statuses = ["active", "deleted"]

      if status in allowed_statuses do
        []
      else
        [status: "must be in list of allowed statuses"]
      end
    end)
    |> unique_constraint(:id, name: :ticket_pkey)
  end
end
