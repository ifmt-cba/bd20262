# MongoDB

O MongoDB é um sistema de gerenciamento de banco de dados NoSQL (não relacional) orientado a documentos.

Em vez de organizar os dados em tabelas com linhas e colunas (como nos bancos de dados tradicionais do tipo SQL), ele armazena as informações em documentos flexíveis no formato BSON (uma versão binária do JSON)

## Instalação

```shell
docker run --name mongodb -p 27017:27017 -d mongodb mongodb-community-server:latest

docker exec -it mongodb mongosh
```

## Comandos Básicos

```shell
#Para listar todos os bancos de dados:
show dbs

#Para criar ou acessar um banco de dados:
use meu_banco

#Operações CRUD
#Inserir um único documento:
db.usuarios.insertOne({
  nome: "Ana Silva",
  idade: 28,
  email: "ana@email.com",
  interesses: ["tecnologia", "música"]
})

#Inserir múltiplos documentos:
db.usuarios.insertMany([
  { nome: "Carlos Souza", idade: 35, ativo: true },
  { nome: "Beatriz Lima", idade: 22, ativo: false }
])

#Listar todos os documentos de uma coleção:
db.usuarios.find()

#Filtrar por um campo específico:
db.usuarios.find({ nome: "Ana Silva" })

#Usar operadores gt e lt:
db.usuarios.find({ idade: { $gt: 25 } })

#Atualizar um único documento:
db.usuarios.updateOne(
  { nome: "Ana Silva" },
  { $set: { idade: 29 } }
)

#Adicionar um novo campo em múltiplos documentos:
db.usuarios.updateMany(
  { ativo: { $exists: false } },
  { $set: { ativo: true } }
)

#Remover um único documento:
db.usuarios.deleteOne({ nome: "Beatriz Lima" })

#Remover múltiplos documentos:
db.usuarios.deleteMany({ ativo: false })

#Excluir uma coleção inteira:
db.usuarios.drop()
