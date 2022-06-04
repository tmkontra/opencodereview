defmodule CommunityWeb.SubmissionController do
  use CommunityWeb, :controller

  alias Community.Submissions
  alias Community.Submissions.Submission
  alias Community.Github

  def confirm(conn, %{"repo" => repo_name, "owner" => owner, "pull" => pull_number} = params) do
    changeset = Submissions.change_submission(%Submission{})
    pull = conn.assigns.current_user
    |> Github.get_client()
    |> Github.get_pull(owner, repo_name, pull_number)
    render(conn, "new_confirm.html", changeset: changeset, pull: pull, repo_name: repo_name, repo_owner: owner)
  end

  def pull(conn, %{"repo" => repo_name, "owner" => owner} = params) do
    changeset = Submissions.change_submission(%Submission{})
    pulls = conn.assigns.current_user
    |> Github.get_client()
    |> Github.get_pulls(owner, repo_name)
    render(conn, "new_pull_select.html", changeset: changeset, pulls: pulls, repo_name: repo_name, repo_owner: owner)
  end

  def new(conn, params) do
    changeset = Submissions.change_submission(%Submission{})
    repos = conn.assigns.current_user
    |> Github.get_client()
    |> Github.get_repos()
    render(conn, "new.html", changeset: changeset, repos: repos)
  end

  def create(conn, %{"submission" => submission_params}) do
    case Submissions.create_submission(submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission created successfully.")
        |> redirect(to: Routes.submission_path(conn, :show, submission))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    submission = Submissions.get_submission!(id)
    render(conn, "show.html", submission: submission)
  end

  def edit(conn, %{"id" => id}) do
    submission = Submissions.get_submission!(id)
    changeset = Submissions.change_submission(submission)
    render(conn, "edit.html", submission: submission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "submission" => submission_params}) do
    submission = Submissions.get_submission!(id)

    case Submissions.update_submission(submission, submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, "Submission updated successfully.")
        |> redirect(to: Routes.submission_path(conn, :show, submission))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", submission: submission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    submission = Submissions.get_submission!(id)
    {:ok, _submission} = Submissions.delete_submission(submission)

    conn
    |> put_flash(:info, "Submission deleted successfully.")
    |> redirect(to: Routes.submission_path(conn, :index))
  end
end
