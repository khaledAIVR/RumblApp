defmodule Rumbl.Repo.Migrations.AddTitleAndSlugToVideos do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :slug, :string
      add :title, :string
    end

  end
end
