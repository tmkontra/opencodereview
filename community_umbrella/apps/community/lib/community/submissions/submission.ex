defmodule Community.Submissions.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :github_created_at, :utc_datetime
    field :github_id, :integer
    field :html_url, :string
    field :url, :string
    field :created_by, :id

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:github_id, :url, :html_url, :github_created_at])
    |> validate_required([:github_id, :url])
  end
end
