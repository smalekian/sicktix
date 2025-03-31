defmodule Sicktix.Schemas.Users.Interface do
  require Logger

  # import Ecto.Query

  alias Phoenix.PubSub
  alias Ecto.Changeset
  alias Sicktix.Repo
  alias Sicktix.Schemas.Users

  def get_users() do
    {
      :ok,
      Repo.all(Users)
    }
  end

  def get_user(id) when is_integer(id) do
    {
      :ok,
      Repo.get(Users, id)
    }
  end

  def get_user(id) when is_binary(id) do
    try do
      id = String.to_integer(id)

      {
        :ok,
        Repo.get(Users, id)
      }
    rescue
      ArgumentError ->
        {:error, "id_must_be_int"}

      error ->
        Logger.error(
          "[Sicktix.Schemas.Users.Interface] unhandled error fetching user #{inspect(error)}"
        )

        {:error, error}
    end
  end

  def create_user(%{} = attrs, seeding_opts \\ nil) do
    Logger.info("[Sicktix.Schemas.Users.Interface] creating user with attrs #{inspect(attrs)}")

    with %Changeset{errors: []} = user_cs <- Users.changeset(%Users{}, attrs),
         {:ok, %Users{} = user} = resp <- Repo.insert(user_cs),
         nil <- seeding_opts[:seeding],
         :ok <- PubSub.broadcast(:sicktix_pubsub, "user", {"created.success", user}) do
      Logger.info("[Sicktix.Schemas.Users.Interface] user created #{inspect(user)}")
      resp
    else
      true ->
        {:ok, :seeded}

      error ->
        Logger.error(
          "[Sicktix.Schemas.Users.Interface] error occurred creating user #{inspect(error)}"
        )

        {:error, error}
    end

    # try do
    #   %Changeset{errors: []} = user_cs = Users.changeset(%Users{}, attrs)
    #   Repo.insert(user_cs)
    # rescue
    #   error ->
    #     Logger.error("[Sicktix.Schemas.Users.Interface] error occurred creating user #{inspect error}")
    #     {:error, error}
    # end
  end
end
