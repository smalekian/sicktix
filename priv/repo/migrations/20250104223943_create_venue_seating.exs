defmodule Sicktix.Repo.Migrations.CreateVenueSeating do
  use Ecto.Migration

  def up do
    create table("venue_seating") do
      add :venue_id, :string
      add :event_type, :string
      add :seating_chart, :map
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end

    create unique_index(:venue_seating, [:venue_id, :event_type])
  end

  def down do
    drop table("venue_seating")
  end
end
