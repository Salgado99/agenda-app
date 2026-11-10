package com.agenda.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DAO {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://mysqldb:3306/db_agenda?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "root";

    private Connection conectar() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC não encontrado no projeto: " + e.getMessage());
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }

    public void inserirContato(JavaBeans contato) {
        String sql = "INSERT INTO contatos (nome, fone, email) VALUES (?, ?, ?)";

        try (Connection conn = conectar(); PreparedStatement pstm = conn.prepareStatement(sql)) {

            pstm.setString(1, contato.getNome());
            pstm.setString(2, contato.getFone());
            pstm.setString(3, contato.getEmail());

            pstm.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Erro ao inserir contato: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public ArrayList<JavaBeans> listarContatos() {

        String sql = "SELECT * from contatos order by nome";
        ArrayList<JavaBeans> contatos = new ArrayList<JavaBeans>();

        try {
            // GARANTA QUE CHAMA O MÉTODO DE CONEXÃO AQUI
            Connection con = conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                JavaBeans contato = new JavaBeans();
                contato.setIdcon(rs.getString("idcon")); // verifique o nome da coluna de id
                contato.setNome(rs.getString("nome"));
                contato.setFone(rs.getString("fone"));
                contato.setEmail(rs.getString("email"));
                contatos.add(contato);
            }
            con.close(); // Sempre feche após usar
            return contatos;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contatos;
    }

    public void selecionarContato(JavaBeans contato) {
        String sql = "SELECT * FROM contatos WHERE idcon = ?";

        // CORRIGIDO: Removido o 'DAO.' antes do conectar() e completado o PreparedStatement
        try (Connection conn = conectar();
             PreparedStatement pstm = conn.prepareStatement(sql)) {

            // Configura o ID que veio no objeto JavaBeans para a busca
            pstm.setString(1, contato.getIdcon());

            // Executa a busca no banco de dados
            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    // Preenche o próprio objeto contato com os dados que vieram do banco
                    contato.setNome(rs.getString("nome"));
                    contato.setFone(rs.getString("fone"));
                    contato.setEmail(rs.getString("email"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erro ao selecionar contato: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void alterarContato(JavaBeans contato) {
        String create = "update contatos set nome = ?, fone=?, email=? where idcon = ?";

        try (Connection conn = conectar();
             PreparedStatement pstm = conn.prepareStatement(create))
		{
			pstm.setString(1, contato.getNome());
			pstm.setString(2, contato.getFone());
			pstm.setString(3, contato.getEmail());
			pstm.setString(4, contato.getIdcon());
			pstm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void excluirContato(JavaBeans contato){
        String delete = "DELETE FROM contatos WHERE idcon = ?";
        try {
            Connection con = conectar();
            PreparedStatement pst = con.prepareStatement(delete);
            pst.setString(1, contato.getIdcon());
            pst.executeUpdate();
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
