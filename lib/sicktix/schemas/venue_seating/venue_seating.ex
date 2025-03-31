defmodule Sicktix.Schemas.VenueSeating do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "venue_seating" do
    field(:venue_id, :string)
    field(:event_type, :string)
    field(:seating_chart, :map)
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(venue_id event_type seating_chart)a
  @optional_fields ~w(data metadata tags)a
  def changeset(venue_seating, params \\ %{}) do
    venue_seating
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:id, name: :venue_seating_pkey)
    |> unique_constraint([:venue_id, :event_type])
  end
end
