defmodule Microblog.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers) do
      add :email_me, :string
      add :email_owner, :string

      timestamps()
    end

  end
end
