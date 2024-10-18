defmodule Projeto1.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemons" do
    field :name, :string
    field :height, :integer
    field :weight, :integer
    field :order, :integer

    timestamps()
  end

  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :height, :weight, :order])
    |> validate_required([:name, :height, :weight, :order])
  end
end
