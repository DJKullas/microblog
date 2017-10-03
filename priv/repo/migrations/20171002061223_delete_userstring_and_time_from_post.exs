defmodule Microblog.Repo.Migrations.DeleteUserstringAndTimeFromPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      remove :user
      remove :time
    end
  end
end
