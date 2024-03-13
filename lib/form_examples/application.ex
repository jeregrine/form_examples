defmodule FormExamples.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FormExamplesWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:form_examples, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FormExamples.PubSub},
      # Start a worker by calling: FormExamples.Worker.start_link(arg)
      # {FormExamples.Worker, arg},
      # Start to serve requests, typically the last entry
      FormExamplesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FormExamples.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FormExamplesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
