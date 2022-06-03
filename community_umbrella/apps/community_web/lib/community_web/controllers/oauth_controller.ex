defmodule CommunityWeb.OauthController do
  use CommunityWeb, :controller

  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias Community.Accounts
  alias CommunityWeb.UserAuth

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.get_or_create_user(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You are now logged in.")
        |> UserAuth.log_in_user(user)

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def callback(%{assigns: %{ueberauth_failure: failure}} = conn, _params) do
    msg = IO.inspect(failure.errors)
    conn
    |> put_flash(:error, "Failed to authenticate. #{msg}")
    |> redirect(to: "/")
  end
end
