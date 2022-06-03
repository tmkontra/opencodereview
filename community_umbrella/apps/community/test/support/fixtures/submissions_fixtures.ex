defmodule Community.SubmissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Community.Submissions` context.
  """

  @doc """
  Generate a submission.
  """
  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{
        created_at: ~U[2022-06-02 03:03:00Z],
        github_id: 42,
        html_url: "some html_url",
        url: "some url"
      })
      |> Community.Submissions.create_submission()

    submission
  end
end
