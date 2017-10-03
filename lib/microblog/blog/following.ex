defmodule Microblog.Blog.Following do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Following


  schema "following" do
    field :email_me, :string
    field :email_owner, :string
    belongs_to :user, Microblog.Blog.User

    timestamps()
  end

  @doc false
  def changeset(%Following{} = following, attrs) do
    following
    |> cast(attrs, [:email_me, :email_owner, :user_id])
    |> validate_required([:email_me, :email_owner])
  end
end
