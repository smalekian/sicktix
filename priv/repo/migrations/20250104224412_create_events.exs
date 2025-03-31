defmodule Sicktix.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def up do
    create table("events") do
      add :name, :string
      add :event_type_id, :string
      add :venue_id, :string
      add :start_datetime, :string
      add :end_datetime, :string
      add :performers, {:array, :string}
      add :status, :string
      add :reason, :string
      # omitting timezone because it should inherit from venue
      # add :timezone, :string
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end
  end

  def down do
    drop table("events")
  end
end
