defmodule MicroblogWeb.UserController do
  use MicroblogWeb, :controller

  alias Microblog.Blog
  alias Microblog.Blog.User

  def index(conn, _params) do
    users = Blog.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Blog.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Blog.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
  if get_session(conn, :user_id) do
    user = Blog.get_user!(id)
    user = Microblog.Repo.preload(user, :posts)
    user = Microblog.Repo.preload(user, :followers)
    follower = %Microblog.Blog.Follower{
      email_me: Blog.get_user!(get_session(conn, :user_id)).email,
      email_owner: user.email,
      user_id: id,
}
follower = Blog.change_follower(follower)

current_user = Blog.get_user!(get_session(conn, :user_id))

    render(conn, "show.html", user: user, follower: follower, current_user: current_user)
    else
    conn
    |> put_flash(:info, "Must be logged in to view a user.")
    |> redirect(to: post_path(conn, :index))

    end
  end

  def edit(conn, %{"id" => id}) do
    user = Blog.get_user!(id)
    changeset = Blog.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Blog.get_user!(id)

    case Blog.update_user(user, user_params) do
      {:ok, user} ->

        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Blog.get_user!(id)
    {:ok, _user} = Blog.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end


end
