defmodule Sicktix.Repo.Migrations.CreateEventTypes do
  use Ecto.Migration

  def up do
    create table("event_types") do
      add :name, :string
      add :allowed_performer_types, {:array, :string}
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end

    create unique_index(:event_types, :name)
  end

  def down do
    drop table("event_types")
  end
end
