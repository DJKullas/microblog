defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :message, :string
    belongs_to :user, Microblog.Blog.User
    has_many :likes, Microblog.Blog.Like, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:message, :user_id])
    |> validate_required([:message])
  end
end
