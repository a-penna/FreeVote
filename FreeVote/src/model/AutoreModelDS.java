package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

public class AutoreModelDS implements Model<AutoreBean> {
	private DataSource ds;
	
	public AutoreModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public Collection<AutoreBean> doRetrieveByID(int id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<AutoreBean> autori = new LinkedList<AutoreBean>();

		String selectSQL = "SELECT * FROM Autore WHERE id_mozione = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				AutoreBean bean = new AutoreBean();				
				
				bean.setID(rs.getInt("id_mozione"));
				bean.setNomeCompleto(rs.getString("nome_completo"));
				
				autori.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		}
		
		return autori;
	}

	public AutoreBean doRetrieveByKey(String key) throws SQLException {
		throw new UnsupportedOperationException();
	}
	
	public Collection<AutoreBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<AutoreBean> autori = new LinkedList<AutoreBean>();

		String selectSQL = "SELECT * FROM Autore";

		if (order != null && !order.equals("") && (order == "id_mozione" || order == "nome_completo")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				AutoreBean bean = new AutoreBean();

				bean.setID(rs.getInt("id_mozione"));
				bean.setNomeCompleto(rs.getString("nome_completo"));

				autori.add(bean);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		}

		return autori;
	}

	public void doSave(AutoreBean autore) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO Autore (id_mozione, nome_completo) VALUES (?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setInt(1, autore.getID());
			preparedStatement.setString(2, autore.getNomeCompleto());

			preparedStatement.executeUpdate();

			connection.commit();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		}
	}

	public void doUpdate(AutoreBean autore) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(AutoreBean autore) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String deleteSQL = "DELETE FROM Autore WHERE id_mozione = ? AND nome_completo= ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, autore.getID());
			preparedStatement.setString(2, autore.getNomeCompleto());

			preparedStatement.executeUpdate();

			connection.commit();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		}
	}
}

