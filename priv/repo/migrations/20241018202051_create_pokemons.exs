defmodule Projeto1.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :height, :integer
      add :weight, :integer
      add :order, :integer

      timestamps()
    end
  end
end
