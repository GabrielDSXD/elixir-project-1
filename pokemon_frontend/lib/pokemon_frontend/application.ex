defmodule PokemonFrontend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PokemonFrontendWeb.Telemetry,
      PokemonFrontend.Repo,
      {DNSCluster, query: Application.get_env(:pokemon_frontend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PokemonFrontend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PokemonFrontend.Finch},
      # Start a worker by calling: PokemonFrontend.Worker.start_link(arg)
      # {PokemonFrontend.Worker, arg},
      # Start to serve requests, typically the last entry
      PokemonFrontendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PokemonFrontend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PokemonFrontendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
