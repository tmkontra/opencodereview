defmodule Community.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Community.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Community.PubSub}
      # Start a worker by calling: Community.Worker.start_link(arg)
      # {Community.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Community.Supervisor)
  end
end
