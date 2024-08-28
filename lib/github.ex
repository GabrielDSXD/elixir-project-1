defmodule GitHub do
  use HTTPoison.Base

  @url "https://api.github.com/repos/elixir-lang/elixir/issues"

  def fetch_data() do
    HTTPoison.get(@url)
    |> processa_resposta
  end

  defp processa_resposta({:ok, %HTTPoison.Response{status_code: 200, body: b}}) do
    {:ok, b}
  end

  defp processa_resposta({:error, r}), do: {:error, r}
  defp processa_resposta({:ok, %HTTPoison.Response{status_code: 404, body: b}}) do
    {:error, b}
  end

end
