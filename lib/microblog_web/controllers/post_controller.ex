defmodule MicroblogWeb.PostController do
  use MicroblogWeb, :controller

  import Plug.Conn
  alias Microblog.Blog
  alias Microblog.Blog.Post

  def index(conn, _params) do


  changeset = Blog.change_post(%Post{})
    if get_session(conn, :user_id) do
    user = Blog.get_user!(get_session(conn, :user_id))

    end
    if user do
    posts = Blog.list_posts()
    posts = Microblog.Repo.preload(posts, :user)
    logged_in = true
    user = Microblog.Repo.preload user, :followers
    followers = user.followers
    followers = Microblog.Repo.preload followers, :user
    users = Microblog.Repo.all(Blog.User)
    users = Microblog.Repo.preload(users, :followers)
    render(conn, "index.html", changeset: changeset, user: user, logged_in: logged_in, users: users, posts: posts)
     else
     logged_in = nil
     posts = Blog.list_posts()
     posts = Microblog.Repo.preload(posts, :user)
    conn
    render(conn, "index.html", changeset: changeset, logged_in: logged_in, posts: posts)
      end
  end

  def new(conn, _params) do
  if get_session(conn, :user_id) do
    changeset = Blog.change_post(%Post{})
      user = Blog.get_user!(get_session(conn, :user_id))


  render(conn, "new.html", changeset: changeset)
       else
      conn
      |> put_flash(:info, "Must be logged in to make a post.")
      |> redirect(to: post_path(conn, :index))
        end

  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->

        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    if get_session(conn, :user_id) do
    current_user = Blog.get_user!(get_session(conn, :user_id))

    post = Blog.get_post!(id)
    user = Blog.get_user!(post.user_id)
    post = Microblog.Repo.preload(post, :likes)
    user_id = :user_id
    already_liked = Blog.already_liked(current_user.id, id)
    liked = Enum.count(already_liked)

    render(conn, "show.html", post: post, user: user, current_user: current_user, liked: liked)
    else
    conn
    |> put_flash(:info, "Login to view posts.")
    |> redirect(to: post_path(conn, :index))

    end
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
