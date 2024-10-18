defmodule ApiService do
  use HTTPoison.Base

  @url "https://pokeapi.co/api/v2/"

  def fetch_data(query \\ "") do
    HTTPoison.get(@url <> query)
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
