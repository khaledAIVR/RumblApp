defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts  context.
  """
  alias Rumbl.Accounts.User
  alias Rumbl.Repo

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  # def change_user(%User{} = user) do
  #   User.changeset(user, %{})
  # end

  # def create_user(attrs \\ %{}) do
  #   %User{}
  #   |> User.changeset(attrs)
  #   |> Repo.insert()
  # end

  def change_registeration(%User{} = user, params) do
    User.registeration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registeration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_username_and_password(username, given_pass) do
    user = get_user_by(username: username)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end