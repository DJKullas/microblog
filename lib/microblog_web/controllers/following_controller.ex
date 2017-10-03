defmodule MicroblogWeb.FollowingController do
  use MicroblogWeb, :controller

  alias Microblog.Blog
  alias Microblog.Blog.Following

  def index(conn, _params) do
  if get_session(conn, :user_id) do
  current_user = Blog.get_user!(get_session(conn, :user_id))
    following = Blog.list_following()

    users = Microblog.Repo.all(Blog.User)
    users = Microblog.Repo.preload(users, :followers)
    render(conn, "index.html", following: following, current_user: current_user, users: users)
    else
    conn
    |> put_flash(:info, "Must login for this page.")
    |> redirect(to: post_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Blog.change_following(%Following{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"following" => following_params}) do
    case Blog.create_following(following_params) do
      {:ok, following} ->
        conn
        |> put_flash(:info, "Following created successfully.")
        |> redirect(to: following_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    following = Blog.get_following!(id)
    render(conn, "show.html", following: following)
  end

  def edit(conn, %{"id" => id}) do
    following = Blog.get_following!(id)
    changeset = Blog.change_following(following)
    render(conn, "edit.html", following: following, changeset: changeset)
  end

  def update(conn, %{"id" => id, "following" => following_params}) do
    following = Blog.get_following!(id)

    case Blog.update_following(following, following_params) do
      {:ok, following} ->
        conn
        |> put_flash(:info, "Following updated successfully.")
        |> redirect(to: following_path(conn, :show, following))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", following: following, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    following = Blog.get_following!(id)
    {:ok, _following} = Blog.delete_following(following)

    conn
    |> put_flash(:info, "Following deleted successfully.")
    |> redirect(to: following_path(conn, :index))
  end
end
