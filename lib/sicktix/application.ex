defmodule Sicktix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SicktixWeb.Telemetry,
      Sicktix.Repo,
      Sicktix.EtsManager,
      {Oban, Application.fetch_env!(:sicktix, Oban)},
      {DNSCluster, query: Application.get_env(:sicktix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: :sicktix_pubsub},
      Sicktix.SubscriberSupervisors.Events,
      # Start the Finch HTTP client for sending emails
      {Finch, name: Sicktix.Finch},
      # Start a worker by calling: Sicktix.Worker.start_link(arg)
      # {Sicktix.Worker, arg},
      # Start to serve requests, typically the last entry
      SicktixWeb.Endpoint
      # SicktixWeb.EventSubscriber
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sicktix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SicktixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
