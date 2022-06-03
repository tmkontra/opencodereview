defmodule CommunityWeb.SubmissionControllerTest do
  use CommunityWeb.ConnCase

  import Community.SubmissionsFixtures

  @create_attrs %{created_at: ~U[2022-06-02 03:13:00Z], github_id: 42, html_url: "some html_url", url: "some url"}
  @update_attrs %{created_at: ~U[2022-06-03 03:13:00Z], github_id: 43, html_url: "some updated html_url", url: "some updated url"}
  @invalid_attrs %{created_at: nil, github_id: nil, html_url: nil, url: nil}

  describe "index" do
    test "lists all submissions", %{conn: conn} do
      conn = get(conn, Routes.submission_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Submissions"
    end
  end

  describe "new submission" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.submission_path(conn, :new))
      assert html_response(conn, 200) =~ "New Submission"
    end
  end

  describe "create submission" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.submission_path(conn, :create), submission: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.submission_path(conn, :show, id)

      conn = get(conn, Routes.submission_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Submission"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.submission_path(conn, :create), submission: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Submission"
    end
  end

  describe "edit submission" do
    setup [:create_submission]

    test "renders form for editing chosen submission", %{conn: conn, submission: submission} do
      conn = get(conn, Routes.submission_path(conn, :edit, submission))
      assert html_response(conn, 200) =~ "Edit Submission"
    end
  end

  describe "update submission" do
    setup [:create_submission]

    test "redirects when data is valid", %{conn: conn, submission: submission} do
      conn = put(conn, Routes.submission_path(conn, :update, submission), submission: @update_attrs)
      assert redirected_to(conn) == Routes.submission_path(conn, :show, submission)

      conn = get(conn, Routes.submission_path(conn, :show, submission))
      assert html_response(conn, 200) =~ "some updated html_url"
    end

    test "renders errors when data is invalid", %{conn: conn, submission: submission} do
      conn = put(conn, Routes.submission_path(conn, :update, submission), submission: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Submission"
    end
  end

  describe "delete submission" do
    setup [:create_submission]

    test "deletes chosen submission", %{conn: conn, submission: submission} do
      conn = delete(conn, Routes.submission_path(conn, :delete, submission))
      assert redirected_to(conn) == Routes.submission_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.submission_path(conn, :show, submission))
      end
    end
  end

  defp create_submission(_) do
    submission = submission_fixture()
    %{submission: submission}
  end
end
