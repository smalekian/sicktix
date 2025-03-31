defmodule Sicktix.Schemas.EventTypes do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "event_types" do
    field(:name, :string)
    field(:allowed_performer_types, {:array, :string})
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name allowed_performer_types)a
  @optional_fields ~w(data metadata tags)a
  def changeset(event_type, params \\ %{}) do
    event_type
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_change(:allowed_performer_types, fn :allowed_performer_types,
                                                    allowed_performer_types ->
      # TODO: refactor to refer to shared list
      if allowed_performer_types === [] do
        [allowed_performer_types: "must be in list of allowed types"]
      else
        []
      end
    end)
    |> unique_constraint(:id, name: :event_types_pkey)
    |> unique_constraint(:name)
  end
end
