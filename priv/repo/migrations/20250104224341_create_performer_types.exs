defmodule Sicktix.Repo.Migrations.CreatePerformerTypes do
  use Ecto.Migration

  def up do
    create table("performer_types") do
      add :name, :string
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end

    create unique_index(:performer_types, :name)
  end

  def down do
    drop table("performer_types")
  end
end
