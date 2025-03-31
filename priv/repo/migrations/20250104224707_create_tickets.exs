defmodule Sicktix.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def up do
    create table("tickets") do
      add :event_id, :string
      add :seat_id, :string
      add :taken?, :boolean
      add :owner, :map
      add :status, :string
      add :reason, :string
      add :data, :map
      add :metadata, :map
      add :tags, {:array, :string}

      timestamps()
    end
  end

  def down do
    drop table("tickets")
  end
end
