defmodule Microblog.Repo.Migrations.CreateLikes do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :number, :integer

      timestamps()
    end

  end
end
