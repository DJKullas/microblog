defmodule Microblog.Repo.Migrations.AddUserToLikes do
  use Ecto.Migration

  def change do
  alter table("likes") do
        add :user_id, references(:users), null: false, default: 1



      end
      create index(:likes, [:user_id])
  end
end
