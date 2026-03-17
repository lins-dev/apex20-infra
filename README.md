# apex20-infra

Infraestrutura local de desenvolvimento do ecossistema **Apex20**.

Contém um único Docker Compose com todos os serviços necessários para rodar o projeto localmente. Estruturado para futura migração para k3s.

## Serviços

| Serviço      | Imagem                  | Porta local |
|---|---|---|
| PostgreSQL   | postgres:16-alpine      | 5420        |
| Redis        | redis:7-alpine          | 6320        |
| Prometheus   | prom/prometheus:latest  | 9020        |
| Grafana      | grafana/grafana:latest  | 3030        |
| Tooling      | Dockerfile.dev          | —           |

## Pré-requisitos

- Docker + Docker Compose v2

## Subir a infraestrutura

```bash
# Todos os serviços
docker compose up -d

# Apenas infra (sem tooling)
docker compose up -d db cache prometheus grafana
```

## Acessar os serviços

- **Grafana:** http://localhost:3030 (admin / admin)
- **Prometheus:** http://localhost:9020
- **PostgreSQL:** `postgres://apex20:password@localhost:5420/apex20`
- **Redis:** `redis://localhost:6320`

## Container de tooling

O serviço `tooling` disponibiliza Go, Node.js, golangci-lint, buf e plugins protobuf:

```bash
# Executar um comando pontual
docker compose exec tooling golangci-lint run ./...
docker compose exec tooling buf generate
```

## Variáveis de ambiente dos projetos

Cada projeto usa as seguintes variáveis para conectar à infra local:

```bash
DATABASE_URL=postgres://apex20:password@localhost:5420/apex20?sslmode=disable
REDIS_URL=redis://localhost:6320
```

Copie o `.env.example` de cada projeto e ajuste conforme necessário.
