import Config

config :projeto_1, Projeto1.Repo,
  database: "pokemon_db",    # Nome do banco de dados (já criado no pgAdmin)
  username: "postgres",       # Nome de usuário do PostgreSQL (geralmente 'postgres')
  password: "admin",          # Senha do PostgreSQL (verifique se é essa senha)
  hostname: "localhost",      # Host do banco de dados
  port: 5432                  # Porta do PostgreSQL (normalmente 5432)

# Registrar o repositório para ser reconhecido pelo Ecto
config :projeto_1, ecto_repos: [Projeto1.Repo]
