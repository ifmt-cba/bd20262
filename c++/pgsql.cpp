#include <iostream>
#include <pqxx/pqxx>

int main() {
    // String de conexão (Ajuste para as suas credenciais)
    std::string connection_string = 
        "host=localhost "
        "port=5432 "
        "dbname=postgres "
        "user=postgres "
        "password=postgres";

    try {
        // 1. Conectar ao banco de dados
        pqxx::connection conn(connection_string);

        if (conn.is_open()) {
            std::cout << "Conectado com sucesso ao banco: " << conn.dbname() << std::endl;
        } else {
            std::cerr << "Falha ao abrir conexão." << std::endl;
            return 1;
        }

        // 2. Criar um objeto de transação de leitura (read-only)
        pqxx::nontransaction tx(conn);

        // 3. Executar a consulta na tabela desejada
        std::string query = "SELECT id, nome FROM usuario;";
        pqxx::result result = tx.exec(query);

        // 4. Iterar sobre os resultados
        std::cout << "\n--- Registros Encontrados ---" << std::endl;
        for (auto row : result) {
            int id = row["id"].as<int>();
            std::string nome = row["nome"].as<std::string>();

            std::cout << "ID: " << id 
                    << " | Nome: " << nome << std::endl;
        }

    } catch (const pqxx::sql_error& e) {
        std::cerr << "Erro de SQL: " << e.what() << std::endl;
        std::cerr << "Query executada: " << e.query() << std::endl;
        return 1;
    } catch (const std::exception& e) {
        std::cerr << "Erro de Execução: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}