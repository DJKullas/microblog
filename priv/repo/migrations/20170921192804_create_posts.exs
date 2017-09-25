defmodule Microblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user, :string
      add :time, :utc_datetime
      add :message, :text

      timestamps()
    end

  end
end
