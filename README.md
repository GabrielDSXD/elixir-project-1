# Projeto1

**TODO: Add description**

1 - mix deps.get

2 - Para executar use: iex.bat -S mix
Projeto1.[METODO]

3 - Para compilar use: mix escript.build
4 - para rodar use: escript projeto_1

------------------------------------------------------------------------------

**Funções Importantes**

iex -S mix para entrar no ambiente virtual e rodar as funções e recompile() caso faça alterações no código ou fecha e abre o ambiente

-------------------------------------------------------------------------------
**Funções ligadas ao Banco de Dados**

-PokemonLogic.saveAllPokemons() - salva todos os pokemons no banco de dados

-PokemonLogic.deleteAllPokemons() - deleta todos os pokemons no banco de dados

-PokemonLogic.findOne("nomePokemon") - salva os dados do pokemon digitado no banco de dados

-PokemonLogic.deletePokemon("nomePokemon ou ID") - deleta os dados do pokemon digitado ou ID no banco de dados

-------------------------------------------------------------------------------

*Funções que acessam a api*

-PokemonLogic.findOne(NomeOuID) - busca pokemon pelo ID ou nome

-PokemonLogic.findColor(color) - busca pokemon pela cor

