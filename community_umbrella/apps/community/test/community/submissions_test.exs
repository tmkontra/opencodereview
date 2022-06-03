defmodule Community.SubmissionsTest do
  use Community.DataCase

  alias Community.Submissions

  describe "submissions" do
    alias Community.Submissions.Submission

    import Community.SubmissionsFixtures

    @invalid_attrs %{created_at: nil, github_id: nil, html_url: nil, url: nil}

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Submissions.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Submissions.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      valid_attrs = %{created_at: ~U[2022-06-02 03:03:00Z], github_id: 42, html_url: "some html_url", url: "some url"}

      assert {:ok, %Submission{} = submission} = Submissions.create_submission(valid_attrs)
      assert submission.created_at == ~U[2022-06-02 03:03:00Z]
      assert submission.github_id == 42
      assert submission.html_url == "some html_url"
      assert submission.url == "some url"
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Submissions.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      update_attrs = %{created_at: ~U[2022-06-03 03:03:00Z], github_id: 43, html_url: "some updated html_url", url: "some updated url"}

      assert {:ok, %Submission{} = submission} = Submissions.update_submission(submission, update_attrs)
      assert submission.created_at == ~U[2022-06-03 03:03:00Z]
      assert submission.github_id == 43
      assert submission.html_url == "some updated html_url"
      assert submission.url == "some updated url"
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Submissions.update_submission(submission, @invalid_attrs)
      assert submission == Submissions.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Submissions.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Submissions.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Submissions.change_submission(submission)
    end
  end
end
