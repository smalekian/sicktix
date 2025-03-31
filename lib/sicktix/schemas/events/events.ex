defmodule Sicktix.Schemas.Events do
  use Ecto.Schema

  import Ecto.Changeset

  # @derive {Jason.Encoder, except: [:__meta__]}
  schema "events" do
    field(:name, :string)
    field(:event_type_id, :string)
    field(:venue_id, :string)
    field(:start_datetime, :string)
    field(:end_datetime, :string)
    # field(:timezone, :string)
    field(:performers, {:array, :string})
    field(:status, :string)
    field(:reason, :string)
    field(:data, :map)
    field(:metadata, :map)
    field(:tags, {:array, :string})
    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name event_type_id venue_id status start_datetime end_datetime performers)a
  @optional_fields ~w(reason data metadata tags)a
  def changeset(event, params \\ %{}) do
    event
    |> cast(params, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_change(:status, fn :status, status ->
      # TODO: refactor to refer to shared list
      allowed_statuses = ["scheduled", "canceled", "deleted"]

      if status in allowed_statuses do
        []
      else
        [status: "must be in list of allowed statuses"]
      end
    end)
    |> validate_change(:performers, fn :performers, performers ->
      if performers !== [] do
        []
      else
        [performers: "must not be empty"]
      end
    end)
    |> validate_change(:start_datetime, fn :start_datetime, start_datetime ->
      case DateTime.from_iso8601(start_datetime) do
        {:ok, %DateTime{}, 0} -> []
        _ -> [start_datetime: "must be a valid ISO8601 datetime"]
      end
    end)
    |> validate_change(:end_datetime, fn :end_datetime, end_datetime ->
      case DateTime.from_iso8601(end_datetime) do
        {:ok, %DateTime{}, 0} -> []
        _ -> [end_datetime: "must be a valid ISO8601 datetime"]
      end
    end)
    |> unique_constraint(:id, name: :event_pkey)
  end
end
