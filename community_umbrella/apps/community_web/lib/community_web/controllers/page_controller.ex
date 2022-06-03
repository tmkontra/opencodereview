defmodule CommunityWeb.PageController do
  use CommunityWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def user_home(conn, _params) do
    render(conn, "user_home.html", recent_submissions: nil)
  end
end
