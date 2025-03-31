defmodule Sicktix.Schemas.Venues do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "venues" do
    field(:name, :string)
    field(:location, :map)
    field(:allowed_event_types, {:array, :string})
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name location allowed_event_types)a
  @optional_fields ~w(data metadata tags)a
  def changeset(venue, params \\ %{}) do
    venue
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_change(:location, fn :location, location ->
      # TODO: add validations of iana timezone, state, zip_code
      has_required_keys? =
        Enum.all?(
          [:street_address, :city, :state, :zip_code],
          fn key ->
            Map.has_key?(location, key) && is_binary(location[key])
          end
        )

      if has_required_keys? do
        []
      else
        [data: "must have required keys"]
      end
    end)
    |> validate_change(:allowed_event_types, fn :allowed_event_types, allowed_event_types ->
      # TODO: refactor to refer to shared list
      if allowed_event_types === [] do
        [allowed_event_types: "must be in list of allowed types"]
      else
        []
      end
    end)
    |> unique_constraint(:id, name: :venues_pkey)
    |> unique_constraint(:name)
  end
end
