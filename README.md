# apex20-infra

Infraestrutura local de desenvolvimento do ecossistema **Apex20**.

Contém um único Docker Compose com todos os serviços necessários para rodar o projeto localmente. Estruturado para futura migração para k3s.

## Serviços

| Serviço    | Imagem                 | Porta local |
|---|---|---|
| PostgreSQL | postgres:16-alpine     | 5420        |
| Redis      | redis:7-alpine         | 6320        |
| Prometheus | prom/prometheus:latest | 9020        |
| Grafana    | grafana/grafana:latest | 3030        |
| Tooling    | Dockerfile.dev         | —           |

## Pré-requisitos

- Docker + Docker Compose v2

## Subir a infraestrutura

```bash
# Todos os serviços (usa make para passar UID/GID automaticamente)
make up

# Apenas infra (sem tooling)
docker compose up -d db cache prometheus grafana
```

## Acessar os serviços

- **Grafana:** http://localhost:3030 — `admin / admin`
- **Prometheus:** http://localhost:9020
- **PostgreSQL:** `postgres://apex20:password@localhost:5420/apex20`
- **Redis:** `redis://localhost:6320`

## Variáveis de ambiente dos projetos

Cada projeto usa as seguintes variáveis para conectar à infra local:

```bash
DATABASE_URL=postgres://apex20:password@localhost:5420/apex20?sslmode=disable
REDIS_URL=redis://localhost:6320
```

Copie o `.env.example` de cada projeto e ajuste conforme necessário.

## Container de tooling

O serviço `tooling` disponibiliza Go 1.26, Node.js 24, golangci-lint, buf e plugins protobuf.
Monta todos os repositórios via `..:/workspace` e roda com o mesmo `UID/GID` do host — sem problemas de permissão em arquivos gerados.

```bash
# Executar comandos no container
docker compose exec tooling golangci-lint run ./apex20-backend/...
docker compose exec tooling buf generate
```

> Use sempre `make up` ao invés de `docker compose up -d` para garantir que o `UID/GID` do host seja passado corretamente para o build do container de tooling.
