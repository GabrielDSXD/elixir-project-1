defmodule Projeto1.Application do
  use Application

  def start(_type, _args) do
    children = [
      Projeto1.Repo
    ]

    opts = [strategy: :one_for_one, name: Projeto1.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
