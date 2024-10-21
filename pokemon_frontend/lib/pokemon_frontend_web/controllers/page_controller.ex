defmodule PokemonFrontendWeb.PageController do
  use PokemonFrontendWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def getOnePokemon(conn, %{"idOrName" => idOrName}) do
    case Pokemon.findOne(idOrName) do
      {:ok, result} ->
        # Você pode usar o result para renderizar na página
        render(conn, "pokemon.html", pokemon: result, layout: false)

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Pokemon not found")
    end
  end

   def searchByHabitats(conn, %{"habitat" => habitat}) do
    IO.puts(habitat)
    case Pokemon.findHabitat(habitat) do
      {:ok, result} ->
        # Você pode usar o result para renderizar na página
        render(conn, "habitat.html", habitat: result, layout: false)

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Pokemon not found")
    end
  end
end
