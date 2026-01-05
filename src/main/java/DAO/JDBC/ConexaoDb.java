package DAO.JDBC;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.Properties;

public class ConexaoDb {

    private static Connection _connection;

    public static Connection openConnection() {
        if (_connection == null) {
            try {
                Properties props = loadProperties();
                String url = props.getProperty("dburl");
                // The driver is automatically loaded in newer JDBC versions,
                // but adding the user/pass from props is needed.
                _connection = DriverManager.getConnection(url, props);
            }
            catch (SQLException e) {
                throw new RuntimeException("Erro ao conectar ao banco. Verifique se o MySQL está rodando e se o banco 'sistema_gestao_comercial' existe.\nErro: " + e.getMessage());
            }
        }
        return _connection;
    }

    private static Properties loadProperties() {
        // CHANGED: Load from classpath resources instead of FileInputStream
        try (InputStream input = ConexaoDb.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (input == null) {
                throw new RuntimeException("Arquivo 'database.properties' não encontrado em src/main/resources");
            }
            Properties props = new Properties();
            props.load(input);
            return props;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static void closeConnection() {
        if (_connection != null) {
            try {
                _connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    public static void closeStatement(Statement statement) {
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    public static void closeResultSet(ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                throw new RuntimeException(e.getMessage());
            }
        }
    }

    public static void setConnection(Connection connection) {
        _connection = connection;
    }
}