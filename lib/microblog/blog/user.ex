# PASSWORD CODE NOT MINE
# PASSWORD CODE FROM NAT TUCK

defmodule Microblog.Blog.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.User


  schema "users" do

    field :name, :string
    field :handle, :string
    field :email, :string
    field :password, :string, virtual: true
    field :bio, :string
    has_many :followers, Microblog.Blog.Follower, on_delete: :delete_all
    has_many :following, Microblog.Blog.Following, on_delete: :delete_all
    has_many :posts, Microblog.Blog.Post, on_delete: :delete_all
    has_many :likes, Microblog.Blog.Like, on_delete: :delete_all

    field :password_hash, :string
    field :pw_tries, :integer
    field :pw_last_try, :utc_datetime

    field :password_confirmation, :string, virtual: true
    field :admin, :boolean



    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :handle, :email, :password, :bio, :password_confirmation, :admin])
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_pass_hash()
    |> validate_required([:name, :handle, :email, :password_hash])
  end

  # Password validation
    # From Comeonin docs
    def validate_password(changeset, field, options \\ []) do
      validate_change(changeset, field, fn _, password ->
        case valid_password?(password) do
          {:ok, _} -> []
          {:error, msg} -> [{field, options[:message] || msg}]
        end
      end)
    end

    def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
      change(changeset, Comeonin.Argon2.add_hash(password))
    end
    def put_pass_hash(changeset), do: changeset

    def valid_password?(password) when byte_size(password) > 7 do
      {:ok, password}
    end
    def valid_password?(_), do: {:error, "The password is too short"}

end
