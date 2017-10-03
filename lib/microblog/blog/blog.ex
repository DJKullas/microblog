defmodule Microblog.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias Microblog.Blog.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_posts(user) do
    user.all(Post)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_email!(email) do
    Repo.get_by(User, email: email)
  end

  alias Microblog.Blog.Follower

  @doc """
  Returns the list of followers.

  ## Examples

      iex> list_followers()
      [%Follower{}, ...]

  """
  def list_followers do
    Repo.all(Follower)
  end

  @doc """
  Gets a single follower.

  Raises `Ecto.NoResultsError` if the Follower does not exist.

  ## Examples

      iex> get_follower!(123)
      %Follower{}

      iex> get_follower!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follower!(id), do: Repo.get!(Follower, id)

  @doc """
  Creates a follower.

  ## Examples

      iex> create_follower(%{field: value})
      {:ok, %Follower{}}

      iex> create_follower(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follower(attrs \\ %{}) do
    %Follower{}
    |> Follower.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a follower.

  ## Examples

      iex> update_follower(follower, %{field: new_value})
      {:ok, %Follower{}}

      iex> update_follower(follower, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follower(%Follower{} = follower, attrs) do
    follower
    |> Follower.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follower.

  ## Examples

      iex> delete_follower(follower)
      {:ok, %Follower{}}

      iex> delete_follower(follower)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follower(%Follower{} = follower) do
    Repo.delete(follower)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follower changes.

  ## Examples

      iex> change_follower(follower)
      %Ecto.Changeset{source: %Follower{}}

  """
  def change_follower(%Follower{} = follower) do
    Follower.changeset(follower, %{})
  end
end
