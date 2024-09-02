defmodule Main do
  use HTTPoison.Base


  defp loop do
    IO.puts("=== Menu ===")
    IO.puts("1. Listar todos os pokemons")
    IO.puts("2. Listar todas as cores de pokemons")
    IO.puts("3. Buscar pokemon por id/nome")
    IO.puts("4. Listar pokemons em habitats")
    IO.puts("5. Listar pokemons por cor")
    IO.puts("6. Listar evolucoes de pokemon")
    IO.puts("9. Sair")
    IO.puts("Escolha uma opção:")

    # Captura a entrada do usuário
    input = IO.gets("> ") |> String.trim()

    case input do
      "1" ->
        listar(0, fn offset -> Pokemon.listAll(offset) end)

        loop()

      "2" ->
        Pokemon.listAllColors()

        loop()

      "3" ->
        IO.puts("Digite um nome ou id: ")
        input = IO.gets("> ") |> String.trim() |> String.downcase()

        Pokemon.findOne(input)

        loop()

      "4" ->
        IO.puts("Digite um habitat (Ex: Cave) ou ID de um habitat: ")
        input = IO.gets("> ") |> String.trim() |> String.downcase()

        Pokemon.findHabitat(input)

        loop()

      "5" ->
        IO.puts("Digite uma cor (Ex: Black) ou ID de uma cor: ")
        input = IO.gets("> ") |> String.trim() |> String.downcase()

        Pokemon.findColor(input)

        loop()
      "6" ->
        IO.puts("Digite um id de pokemon")
        input = IO.gets("> ") |> String.trim() |> String.downcase()

        Pokemon.findEvolutionChain(input)

        loop()
      "9" ->
        IO.puts("Saindo...")

      _ ->
        IO.puts("Opção inválida, tente novamente.")
        loop()
    end
  end

  defp listar(offset, func) do
    func.(offset)

    IO.puts("Deseja listar mais 20? Sim ou nao")
        input = IO.gets("> ") |> String.trim() |> String.downcase()
    case input do
      "sim" -> listar(offset+10, func)
      _ -> IO.puts("saindo da listagem...")
    end
  end


  def main(_argv) do
    loop();
  end
end
