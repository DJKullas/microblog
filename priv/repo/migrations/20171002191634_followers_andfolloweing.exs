defmodule Microblog.Repo.Migrations.FollowersAndfolloweing do
  use Ecto.Migration

  def change do
  alter table("followers") do
        add :user_id, references(:users)

      end
      alter table("following") do
            add :user_id, references(:users)

          end
        
      create index(:followers, [:user_id])
      create index(:following, [:user_id])
      end
end
