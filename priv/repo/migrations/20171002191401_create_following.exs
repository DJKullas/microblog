defmodule Microblog.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:following) do
      add :email_me, :string
      add :email_owner, :string

      timestamps()
    end

  end
end
