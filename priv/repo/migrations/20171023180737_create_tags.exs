defmodule Microblog.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :search, :string

      timestamps()
    end

  end
end
