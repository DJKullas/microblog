defmodule Microblog.Repo.Migrations.AddUsersToPosts do
  use Ecto.Migration

  def change do
  alter table("posts") do
        add :user_id, references(:users), null: false, default: 1



      end
      create index(:posts, [:user_id])
  end
end
