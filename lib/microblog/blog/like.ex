defmodule Microblog.Blog.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Like


  schema "likes" do
    field :number, :integer
    belongs_to :post, Microblog.Blog.Post
    belongs_to :user, Microblog.Blog.User

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:number, :post_id, :user_id])
    |> validate_required([:number])
  end
end
