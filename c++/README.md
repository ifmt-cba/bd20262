É preciso instalar a biblioteca que permite acesso ao banco de dados:

```shell
sudo pamac install libpqxx
```

Para compilar execute:

```shell
g++ pgsql.cpp -o app -lpqxx -lpq
```