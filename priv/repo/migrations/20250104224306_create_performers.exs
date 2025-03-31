defmodule Sicktix.Repo.Migrations.CreatePerformers do
  use Ecto.Migration

  def up do
    create table("performers") do
      add :name, :string
      add :type, :string
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end

    create unique_index(:performers, :name)
  end

  def down do
    drop table("performers")
  end
end
