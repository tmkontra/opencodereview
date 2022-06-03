defmodule Community.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :github_id, :integer, null: false
      add :url, :string, null: false
      add :html_url, :string
      add :github_created_at, :utc_datetime
      add :created_by, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:submissions, [:created_by])
  end
end
