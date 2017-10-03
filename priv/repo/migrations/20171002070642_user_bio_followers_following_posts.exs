defmodule Microblog.Repo.Migrations.UserBioFollowersFollowingPosts do
  use Ecto.Migration

  def change do
    alter table("users") do

      add :followers, references(:users)
      add :following, references(:users)
      add :bio, :text
      add :posts, references(:posts)

    end
  end
end
