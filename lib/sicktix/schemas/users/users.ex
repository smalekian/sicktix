defmodule Sicktix.Schemas.Users do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "users" do
    field(:email, :string)
    field(:registered_datetime, :utc_datetime)
    field(:roles, {:array, :string})
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(email registered_datetime roles data)a
  @optional_fields ~w(metadata tags )a
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_change(:roles, fn :roles, roles ->
      # TODO: refactor to refer to shared list
      allowed_set = MapSet.new(["seller", "customer"])
      changeset_set = MapSet.new(roles)

      if MapSet.subset?(changeset_set, allowed_set) do
        []
      else
        [roles: "must be in list of allowed roles"]
      end
    end)
    |> validate_change(:data, fn :data, data ->
      # TODO: add validation of iana timezone
      has_required_keys? =
        Enum.all?(
          [:first_name, :last_name, :timezone],
          fn key ->
            Map.has_key?(data, key) && is_binary(data[key])
          end
        )

      if has_required_keys? do
        []
      else
        [data: "must have required keys"]
      end
    end)
    |> unique_constraint(:id, name: :users_pkey)
    |> unique_constraint(:email)
  end
end
