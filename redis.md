# Redis

O Redis é um banco de dados NoSQL chave-valor em memória ultra-rápido.

## Instalação

```shell
docker run -d --name redis -p 6379:6379 redis:latest

docker exec -it redis redis-cli
```

## Comandos básicos

```shell
#Testar conexão:
PING

#Limpar terminal:
CLEAR

#Sair da linha de comando:
QUIT

#Definir um valor:
SET usuario:100 "Ana Silva"

#Buscar um valor:
GET usuario:100

#Incrementa um número:
SET acessos:pagina 0
INCR acessos:pagina
INCRBY acessos:pagina 10

#Definir chave com tempo de expiração:
SETEX sessao:token 60 "abc123xyz"

#Visualizar o tempo de vida:
TTL sessao:token
```

## Hash

```shell
#Inserir campos em um hash:
HSET usuario:100 nome "Ana Silva" idade "28" email "ana@email.com"

#Buscar um campo específico:
HGET usuario:100 nome

#Buscar todos os campos e valores:
HGETALL usuario:100

#Remover um campo específico:
HDEL usuario:100 email
```

## Listas encadeadas

```shell
#Adicionar elemento no final (right )e no início (left):
RPUSH fila:notificacoes "email_1"
RPUSH fila:notificacoes "email_2"
LPUSH fila:notificacoes "email_prioritario"

#Listar elementos por intervalo (0 a -1 exibe tudo):
LRANGE fila:notificacoes 0 -1

#Remover e retornar o primeiro elemento:
LPOP fila:notificacoes
```

# Sets

```shell
#Adicionar membros ao set:
SADD tags:artigo "nosql" "redis" "banco-de-dados"

#Listar todos os membros:
SMEMBERS tags:artigo

#Verificar se um membro existe:
SISMEMBER tags:artigo "redis"
```

# Gerenciamento de chaves:

```shell
#Listar chaves que combinam com um padrão:
KEYS usuario:*

#Verificar se uma chave existe:
EXISTS usuario:100

#Deletar uma chave:
DEL usuario:100

#Limpar todas as chaves do banco atual:
FLUSHDB
