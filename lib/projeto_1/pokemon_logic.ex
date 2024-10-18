defmodule PokemonLogic do
  alias Projeto1.{Repo, Pokemon}
  require Logger

  # Função para buscar um Pokémon por ID ou Nome e salvar no banco de dados
  def findOne(idOrName) do
    ApiService.fetch_data("pokemon/#{idOrName}") |> show_pokemon()
  end

  # Função para listar todos os Pokémon e salvar no banco de dados
  def saveAllPokemons do
    saveAllPaginated(0)
  end

  defp saveAllPaginated(offset) do
    case ApiService.fetch_data("pokemon/?offset=#{offset}&limit=20") do
      {:ok, json} ->
        {:ok, result} = Poison.decode(json)
        pokemons = result["results"]

        Enum.each(pokemons, fn pokemon ->
          savePokemon(pokemon["name"])
        end)

        # Se houver mais resultados, continue chamando a função para a próxima página
        if length(pokemons) == 20 do
          saveAllPaginated(offset + 20)
        else
          Logger.info("Todos os Pokémon foram salvos no banco de dados.")
        end

      {:error, _reason} ->
        Logger.error("Erro ao buscar os Pokémon.")
    end
  end

  defp savePokemon(name) do
    case Repo.get_by(Pokemon, name: name) do
      nil ->
        case ApiService.fetch_data("pokemon/#{name}") do
          {:ok, json} ->
            {:ok, result} = Poison.decode(json)
            %Pokemon{}
            |> Pokemon.changeset(%{
              name: result["name"],
              height: result["height"],
              weight: result["weight"],
              order: result["order"]
            })
            |> Repo.insert()
            Logger.info("#{name} foi salvo no banco de dados.")

          {:error, _reason} ->
            Logger.error("Erro ao buscar o Pokémon #{name}.")
        end

      _pokemon ->
        Logger.info("#{name} já está salvo no banco de dados.")
    end
  end

  # Função para deletar todos os Pokémon do banco de dados
  def deleteAllPokemons do
    Repo.delete_all(Pokemon)
    Logger.info("Todos os Pokémon foram removidos do banco de dados.")
  end

  # Função para deletar um Pokémon específico por nome ou ID
  def deletePokemon(idOrName) do
    case Repo.get_by(Pokemon, name: idOrName) || Repo.get(Pokemon, idOrName) do
      nil ->
        Logger.info("Pokémon #{idOrName} não encontrado no banco de dados.")

      pokemon ->
        Repo.delete(pokemon)
        Logger.info("Pokémon #{pokemon.name} foi removido do banco de dados.")
    end
  end

  # Função para buscar Pokémon por cor
  def findColor(color) do
    ApiService.fetch_data("pokemon-color/#{color}") |> show_colors()
  end

  defp show_colors({:error, _}) do
    IO.puts "Ocorreu um erro ao mostrar as cores"
  end

  defp show_colors({:ok, json}) do
    {:ok, result} = Poison.decode(json)
    name = result["name"]
    id = result["id"]
    IO.puts "COR"
    IO.puts "#{id} | #{name}"
    IO.puts "LISTA DE POKEMONS COM A RESPECTIVA COR:"
    show_list(result["pokemon_species"], 0)
  end

  # Funções auxiliares para mostrar os Pokémon
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
        Logger.info("#{name} foi salvo no banco de dados.")

      _pokemon ->
        Logger.info("#{name} já está salvo no banco de dados.")
    end
  end

  defp show_list([], _), do: nil
  defp show_list([i | rest], index) do
    name = i["name"]
    IO.puts "#{index} | #{name}"
    show_list(rest, index + 1)
  end
end
