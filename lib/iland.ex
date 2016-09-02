defmodule Iland do
  use Application

  @moduledoc """
  Provides a basic API wrapper for accessing the iland cloud API.
  The package handles API token retrieval and renewal behind the scenes.
  """

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(Iland.Token, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Iland.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
