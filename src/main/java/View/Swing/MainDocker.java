package View.Swing;

import DAO.JDBC.ConexaoDb;
import DAO.MySQL.*;
import Service.*;
import com.formdev.flatlaf.themes.FlatMacLightLaf;
import org.testcontainers.containers.MySQLContainer;

import javax.swing.*;
import java.sql.Connection;
import java.sql.DriverManager;

public class MainDocker {

    public static MySQLContainer<?> mysqlContainer = new MySQLContainer<>("mysql:8.0.33")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test")
            .withInitScript("schema.sql"); // Ensure schema.sql is in src/main/resources

    public static void main(String[] args) {
        try {
            System.out.println("Iniciando container Docker MySQL...");
            mysqlContainer.start();
            System.out.println("Banco de dados iniciado!");

            // 1. Get the connection from the running container
            Connection conn = DriverManager.getConnection(
                    mysqlContainer.getJdbcUrl(),
                    mysqlContainer.getUsername(),
                    mysqlContainer.getPassword()
            );

            ConexaoDb.setConnection(conn);

            try {
                UIManager.setLookAndFeel(new FlatMacLightLaf());
            } catch (Exception ex) {
                System.err.println("Falha ao iniciar LaF");
            }

            ProdutoDAO produtoDAO = new ProdutoDAO(conn);
            ClienteDAO clienteDAO = new ClienteDAO(conn);
            EnderecoDAO enderecoDAO = new EnderecoDAO(conn);
            EmailDAO emailDAO = new EmailDAO(conn);
            VendaDAO vendaDAO = new VendaDAO(conn);
            OrcamentoDAO orcamentoDAO = new OrcamentoDAO(conn);
            OrcamentoProdutoDAO orcamentoProdutoDAO = new OrcamentoProdutoDAO(conn);
            AvaliacaoDAO avaliacaoDAO = new AvaliacaoDAO(conn);

            ProdutoService produtoService = new ProdutoService(produtoDAO);
            ClienteService clienteService = new ClienteService(clienteDAO, enderecoDAO, emailDAO);
            OrcamentoService orcamentoService = new OrcamentoService(orcamentoDAO, clienteDAO, orcamentoProdutoDAO, produtoDAO);
            VendaService vendaService = new VendaService(vendaDAO, orcamentoDAO);
            AvaliacaoService avaliacaoService = new AvaliacaoService(avaliacaoDAO, vendaService);
            OrcamentoProdutoService orcamentoProdutoService = new OrcamentoProdutoService(orcamentoProdutoDAO);

            SwingUtilities.invokeLater(() -> {
                MainFrame frame = new MainFrame(produtoService, clienteService, orcamentoService, orcamentoProdutoService, vendaService, avaliacaoService);

                frame.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent windowEvent) {
                        mysqlContainer.stop();
                    }
                });

                frame.setVisible(true);
            });

        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "Erro ao iniciar com Docker: " + e.getMessage());
        }
    }
}