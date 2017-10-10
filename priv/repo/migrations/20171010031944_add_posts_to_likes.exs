defmodule Microblog.Repo.Migrations.AddPostsToLikes do
  use Ecto.Migration

  def change do
  alter table("likes") do
        add :post_id, references(:posts), null: false, default: 1



      end
      create index(:likes, [:post_id])
  end
end
