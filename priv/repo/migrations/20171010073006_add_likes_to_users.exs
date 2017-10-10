defmodule Microblog.Repo.Migrations.AddLikesToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do

      add :likes, references(:likes)

    end
  end
end
