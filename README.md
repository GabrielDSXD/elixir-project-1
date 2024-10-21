# Projeto

Primeiro, inicializar banco de dados com docker-compose:
docker-compose up

Após isso:
1 - mix deps.get
2 - mix phx.server

#Tutorial de desenvolvimento

PARA ADCIONAR UMA NOVA ROTA
No arquivo /pokemon_frontend/lib/pokemon_frontend_web/router.ex adcione algo como essa linha onde tem \_scope "/"\* :

get "/get-one-pokemon", PageController, :getOnePokemon

Depois no PageController:

def getOnePokemon(conn, \_params) do
render(conn, :getOnePokemon, layout: false)
end

depois no arquivo de mesmo nome da função:
lib/pokemon_frontend_web/controllers/page_html/getOnePokemon.html.heex

`<.flash_group flash={@flash} />`
`<div>GET ONE POKEMON</div>`
