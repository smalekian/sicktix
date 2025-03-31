defmodule Sicktix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table("users") do
      add :email, :string
      add :registered_datetime, :utc_datetime
      add :roles, {:array, :string}
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end

    create unique_index(:users, :email)
  end

  def down do
    drop table("users")
  end
end
