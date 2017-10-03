defmodule Microblog.Blog.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.User


  schema "users" do

    field :name, :string
    field :handle, :string
    field :email, :string
    field :password, :string
    field :bio, :string
    has_many :followers, Microblog.Blog.Follower
    has_many :following, Microblog.Blog.Following
    has_many :posts, Microblog.Blog.Post



    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :handle, :email, :password, :bio])
    |> validate_required([:name, :handle, :email, :password])
  end
end
