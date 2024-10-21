defmodule PokemonFrontend.Repo do
  use Ecto.Repo,
    otp_app: :pokemon_frontend,
    adapter: Ecto.Adapters.Postgres
end
