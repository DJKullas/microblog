defmodule Microblog.Blog.Follower do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Follower


  schema "followers" do
    field :email_me, :string
    field :email_owner, :string
    belongs_to :user, Microblog.Blog.User

    timestamps()
  end

  @doc false
  def changeset(%Follower{} = follower, attrs) do
    follower
    |> cast(attrs, [:email_me, :email_owner, :user_id])
    |> validate_required([:email_me, :email_owner])
  end
end
