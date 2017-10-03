defmodule Microblog.Repo.Migrations.AddUsersToPosts do
  use Ecto.Migration

  def change do
  alter table("posts") do
      remove :user_id
        add :user_id, references(:users)



      end
      create index(:posts, [:user_id])
  end
end
