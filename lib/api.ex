defmodule Api do
  use HTTPoison.Base

  def main(_argv) do
    IO.puts("tesr123123")
    GitHub.fetch_data()
    |> mostra_resultado()
  end

  defp mostra_resultado({:error, _}) do
    IO.puts "Ocorreu um erro"
  end


  defp mostra_resultado({:ok, json}) do
    {:ok, issues}  = Poison.decode(json)
    mostra_issues(issues)
  end

  defp mostra_issues([]), do: nil
  defp mostra_issues([i | rest]) do
    number = i["number"]
    title = i["title"]
    status = i["state"]
    IO.puts("#{number} | #{title} | #{status}")

    mostra_issues(rest)
  end

end
