defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :message, :string
    field :time, :utc_datetime
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:user, :time, :message])
    |> validate_required([:user, :time, :message])
  end
end
