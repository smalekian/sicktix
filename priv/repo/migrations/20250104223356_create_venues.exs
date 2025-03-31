defmodule Sicktix.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def up do
    create table("venues") do
      add :name, :string
      add :location, :map
      add :allowed_event_types, {:array, :string}
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end

    create unique_index(:venues, :name)
  end

  def down do
    drop table("venues")
  end
end
