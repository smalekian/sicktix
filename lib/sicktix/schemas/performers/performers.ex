defmodule Sicktix.Schemas.Performers do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "performers" do
    field(:name, :string)
    field(:type, :string)
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name type)a
  @optional_fields ~w(data metadata tags)a
  def changeset(performer, params \\ %{}) do
    performer
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:id, name: :performers_pkey)
    |> unique_constraint(:name)
  end
end
