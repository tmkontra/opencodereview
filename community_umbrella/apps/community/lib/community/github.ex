defmodule Community.Github do
  alias Community.Accounts.User

  def get_client(%User{} = user) do
    Tentacat.Client.new(
      %{access_token: user.github_access_token}
    )
  end

  def get_repos(%Tentacat.Client{} = client) do
    client
    |> Tentacat.Repositories.list_mine()
    |> handle_response()
  end

  def get_pulls(%Tentacat.Client{} = client, repo_owner, repo_name) do
    client
    |> Tentacat.Pulls.list(repo_owner, repo_name)
    |> handle_response()
  end

  def get_pull(%Tentacat.Client{} = client, repo_owner, repo_name, pull_number) do
    client
    |> Tentacat.Pulls.find(repo_owner, repo_name, pull_number)
    |> handle_response()
  end

  defp handle_response({200, data, _} = response) do
    data
  end

  defp handle_response({status, data, resp} = response) do
    raise "Error Response: #{status} #{resp}"
  end
end
