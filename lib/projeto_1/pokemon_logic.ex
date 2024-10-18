defmodule PokemonLogic do
  alias Projeto1.{Repo, Pokemon}

  defp show_pokemon({:error, _}) do
    IO.puts "Ocorreu um erro ao mostrar um único pokemon"
  end

  defp show_pokemon({:ok, json}) do
    {:ok, result} = Poison.decode(json)
    name = result["name"]
    id = result["id"]
    height = result["height"]
    weight = result["weight"]
    order = result["order"]

    # Mostrar informações no console
    IO.puts "#{id} | #{name} | Height: #{height} | Weight: #{weight} | Order: #{order}"

    # Criar um changeset e salvar no banco de dados
    case Repo.get_by(Pokemon, name: name) do
      nil ->
        %Pokemon{}
        |> Pokemon.changeset(%{name: name, height: height, weight: weight, order: order})
        |> Repo.insert()
        IO.puts "#{name} foi salvo no banco de dados."

      _pokemon ->
        IO.puts "#{name} já está salvo no banco de dados."
    end
  end

  def findOne(idOrName) do
    ApiService.fetch_data("pokemon/#{idOrName}") |> show_pokemon()
  end

  def listAll(offset \\ 0) do
    ApiService.fetch_data("pokemon/?offset=#{offset}") |> show_result()
  end

  defp show_result({:error, _}) do
    IO.puts "Ocorreu um erro"
  end

  defp show_result({:ok, json}) do
    {:ok, result} = Poison.decode(json)
    show_list(result["results"], 0)
  end

  defp show_list([], _), do: nil
  defp show_list([i | rest], index) do
    name = i["name"]
    IO.puts "#{index} | #{name}"
    show_list(rest, index + 1)
  end

  # Outras funções para lidar com habitat, cor, evolução, etc.
  def findHabitat(habitat) do
    ApiService.fetch_data("pokemon-habitat/#{habitat}") |> show_habitat()
  end

  defp show_habitat({:error, _}) do
    IO.puts("Ocorreu um erro ao mostrar habitat")
  end

  defp show_habitat({:ok, json}) do
    {:ok, result} = Poison.decode(json)
    name = result["name"]
    id = result["id"]
    IO.puts "HABITAT"
    IO.puts "#{id} | #{name}"
    IO.puts "LISTA DE POKEMONS ENCONTRADOS NESSE HABITAT:"
    show_list(result["pokemon_species"], 0)
  end
end
