defmodule Pokemon do
  defp show_result({:error, _}) do
    IO.puts "Ocorreu um erro"
  end


  defp show_result({:ok, json}) do
    Poison.decode(json)
  end

  defp show_pokemon({:error, _}) do
    IO.puts "Ocorreu um erro ao mostrar um unico pokemon"
  end


  defp show_pokemon({:ok, json}) do
    Poison.decode(json)
  end

  defp show_habitat({:error, _}) do
    IO.puts("Ocorreu um erro ao mostrar habitat")
  end

  defp show_habitat({:ok, json}) do
    Poison.decode(json)
  end

  defp show_colors({:error, _}) do
    IO.puts "Ocorreu um erro ao mostrar as cores"
  end

  defp show_colors({:ok, json}) do
    {:ok, result}  = Poison.decode(json)
    result
  end

   defp show_evolution({:error, _}) do
       IO.puts "Ocorreu um erro ao mostrar as evoluções"
  end


  defp show_evolution({:ok, json}) do
    {:ok, result}  = Poison.decode(json)

    find_species_names(result)
  end

  defp find_species_names(%{"chain" => chain}) do
    find_species_names_from_chain(chain)
  end

  defp find_species_names_from_chain(%{"species" => %{"name" => name}, "evolves_to" => evolves_to}) do
    [name] ++ Enum.flat_map(evolves_to, &find_species_names_from_chain/1)
  end


  def listAll(offset \\ 0) do
    ApiService.fetch_data("pokemon/?offset=#{offset}") |> show_result()
  end

  def findOne(idOrName) do
    ApiService.fetch_data("pokemon/#{idOrName}") |> show_pokemon()
  end

  def findHabitat(habitat) do
    ApiService.fetch_data("pokemon-habitat/#{habitat}") |> show_habitat()
  end

  def listAllColors(offset \\ 0) do
    ApiService.fetch_data("pokemon-color/?offset=#{offset}") |> show_result()
  end

  def findColor(color) do
    ApiService.fetch_data("pokemon-color/#{color}") |> show_colors()
  end

  def findEvolutionChain(id) do
    ApiService.fetch_data("evolution-chain/#{id}") |> show_evolution()
  end
end
