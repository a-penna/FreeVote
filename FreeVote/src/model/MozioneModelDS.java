package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class MozioneModelDS implements Model<MozioneBean> {
	private DataSource ds;
	
	public MozioneModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public MozioneBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		MozioneBean bean = new MozioneBean();

		String selectSQL = "SELECT * FROM Mozione WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(id));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setID(rs.getInt("id"));
				bean.setTesto(rs.getString("Testo"));
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

		return bean;
	}

	public Collection<MozioneBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<MozioneBean> mozioni = new LinkedList<MozioneBean>();

		String selectSQL = "SELECT * FROM Mozione";

		if (order != null && !order.equals("") && (order.equals("id") || order.equals("testo"))) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				MozioneBean bean = new MozioneBean();

				bean.setID(rs.getInt("id"));
				bean.setTesto(rs.getString("testo"));

				mozioni.add(bean);
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

		return mozioni;
	}

	public void doSave(MozioneBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doUpdate(MozioneBean mozione) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE mozione SET testo = ? WHERE id = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);

			preparedStatement.setString(1, mozione.getTesto());
			preparedStatement.setInt(2, mozione.getID());

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

	public void doDelete(MozioneBean mozione) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String deleteSQL = "DELETE FROM mozione WHERE id = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, mozione.getID());

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

	public boolean doSaveCheck(MozioneBean mozione, AutoreBean autore) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement2 = null;

		String insertSQL = "INSERT INTO Mozione(testo, referendum) VALUES (? , (SELECT id FROM Referendum))";
		String insertAutoreSQL = "INSERT INTO Autore(id_mozione, nome_completo) VALUES ((SELECT id FROM Mozione WHERE testo=?) , ? )";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setString(1, mozione.getTesto());
			preparedStatement.executeUpdate();
			preparedStatement2 = connection.prepareStatement(insertAutoreSQL);
			preparedStatement2.setString(1, mozione.getTesto());
			preparedStatement2.setString(2, autore.getNomeCompleto());

			int rs = preparedStatement2.executeUpdate();
			if (rs != 1) {
				try {
					connection.rollback();
				} catch(SQLException e) {
					Utility.printSQLException(e);
				}
				return false;
			}

			connection.commit();
		} finally {
			try {
				if (preparedStatement2 != null)
					preparedStatement2.close();
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		}
		return true;
	}
}
