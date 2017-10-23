defmodule Microblog.Blog.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Tag


  schema "tags" do
    field :search, :string

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:search])
    |> validate_required([:search])
  end
end
