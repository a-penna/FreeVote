package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class CoalizioneModelDS implements Model<CoalizioneBean>{
    
	private DataSource ds = null;
	public CoalizioneModelDS(DataSource ds) {
		this.ds = ds;
	}

	public CoalizioneBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		CoalizioneBean bean = new CoalizioneBean();

		String selectSQL = "SELECT * FROM coalizione WHERE nome = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) 	
				bean.setNome(rs.getString("nome"));
			

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

	public Collection<CoalizioneBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<CoalizioneBean> coalizioni = new LinkedList<CoalizioneBean>();

		String selectSQL = "SELECT * FROM coalizione";

		if (order != null && !order.equals("") && order.equals("nome"))
			selectSQL += " ORDER BY " + order;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				CoalizioneBean bean = new CoalizioneBean();
				bean.setNome(rs.getString("nome"));
				coalizioni.add(bean);
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

		return coalizioni;

	}

	public boolean doSaveCheck(CoalizioneBean coalizione, String partito1, String partito2) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement2 = null;
		PreparedStatement preparedStatement3 = null;

		String insertSQL = "INSERT INTO coalizione(nome) VALUES (?)";
		String insert2SQL = "INSERT INTO appartiene(partito,coalizione) VALUES (?,?)";
		String insert3SQL = "INSERT INTO appartiene(partito,coalizione) VALUES (?,?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setString(1, coalizione.getNome());

			int rs = preparedStatement.executeUpdate();
			if (rs != 1) {
				return false;
			}
			
			preparedStatement2 = connection.prepareStatement(insert2SQL);
			preparedStatement2.setString(1, partito1);
			preparedStatement2.setString(2, coalizione.getNome());

			rs = preparedStatement2.executeUpdate();
			if (rs != 1) {
				try {
					connection.rollback();
				} catch(SQLException e) {
					Utility.printSQLException(e);
				}
				return false;
			}
		
			preparedStatement3 = connection.prepareStatement(insert3SQL);
			preparedStatement3.setString(1, partito2);
			preparedStatement3.setString(2, coalizione.getNome());

			rs = preparedStatement3.executeUpdate();
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
				if (preparedStatement3 != null)
					preparedStatement3.close();
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

	public void doSave(CoalizioneBean coalizione) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doUpdate(CoalizioneBean coalizione) throws SQLException { 
		throw new UnsupportedOperationException(); 
	}

	public void doDelete(CoalizioneBean coalizione) throws SQLException {
		doDeleteCheck(coalizione);
	}
	
	public boolean doDeleteCheck(CoalizioneBean coalizione) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String deleteSQL = "DELETE FROM coalizione WHERE nome = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, coalizione.getNome());

			int rs = preparedStatement.executeUpdate();
			if (rs != 1) 
				return false;
			
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
		return true;
	}
    
	public CoalizioneBean doRetrieveByPartito(String partito) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		CoalizioneBean bean = new CoalizioneBean();

		String selectSQL = "SELECT * FROM coalizione WHERE nome = (SELECT coalizione FROM appartiene WHERE partito=?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, partito);

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) 	
				bean.setNome(rs.getString("nome"));
			

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

	public int doRetrieveVoti(CoalizioneBean coalizione) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int somma = -1;
		String selectSQL = "SELECT SUM(n_votazioni_ricevute) "
							+ "FROM partito "
							+ "WHERE nome IN (SELECT partito "
											+ "FROM appartiene "
											+ "WHERE coalizione = ?)";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, coalizione.getNome());

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) 	
				 somma = rs.getInt(1);
				
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
		return somma;
	}
}

