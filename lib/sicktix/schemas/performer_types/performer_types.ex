defmodule Sicktix.Schemas.PerformerTypes do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "performer_types" do
    field(:name, :string)
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name)a
  @optional_fields ~w(data metadata tags)a
  def changeset(performer_type, params \\ %{}) do
    performer_type
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:id, name: :performer_types_pkey)
    |> unique_constraint(:name)
  end
end
