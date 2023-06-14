defmodule EdctnChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EdctnChatWeb.Telemetry,
      # Start the Ecto repository
      EdctnChat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: EdctnChat.PubSub},
      # Start Finch
      {Finch, name: EdctnChat.Finch},
      # Start the Endpoint (http/https)
      EdctnChatWeb.Endpoint,
      # Start a worker by calling: EdctnChat.Worker.start_link(arg)
      # {EdctnChat.Worker, arg}
      EdctnChatWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EdctnChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EdctnChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
