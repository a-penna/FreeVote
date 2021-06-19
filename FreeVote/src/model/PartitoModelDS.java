package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class PartitoModelDS implements Model<PartitoBean>{
    
	private DataSource ds = null;

	public PartitoModelDS(DataSource ds) {
		this.ds = ds;
	}

	public PartitoBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		PartitoBean bean = new PartitoBean();

		String selectSQL = "SELECT * FROM partito WHERE nome = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setLeader(rs.getString("leader"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setn_votazioni_ricevute(rs.getInt("n_votazioni_ricevute"));
				bean.setLogo(rs.getBytes("logo"));
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

	private boolean checkOrder(String order) {
		return order != null 
			   && !order.equals("") 
			   && (order.equals("leader") 
			   || order.equals("nome") 
			   || order.equals("descrizione") 
			   || order.equals("n_votazioni_ricevute DESC") 
			   || order.equals("logo"));
	}
	
	public Collection<PartitoBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<PartitoBean> partiti = new LinkedList<PartitoBean>();

		String selectSQL = "SELECT * FROM partito";

		if (checkOrder(order)) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				PartitoBean bean = new PartitoBean();

				bean.setLeader(rs.getString("leader"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setn_votazioni_ricevute(rs.getInt("n_votazioni_ricevute"));
				bean.setLogo(rs.getBytes("logo")); 

				partiti.add(bean);
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

		return partiti;

	}

	public void doSave(PartitoBean partito) throws SQLException {
		throw new UnsupportedOperationException();
	}
	
	public boolean doSaveCheck(PartitoBean partito, CandidatoBean candidato) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement2 = null;

		String insertSQL = "INSERT INTO Partito (leader, nome, descrizione, n_votazioni_ricevute, logo) VALUES (?, ?, ?, ?, ?)";
		
		String insertCandidatoSQL = "INSERT INTO Candidato(codice_fiscale,nome,cognome,partito, curriculum, foto) VALUES (MD5(?), ?, ?, ?, ?, ?)";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setString(1, partito.getLeader());
			preparedStatement.setString(2, partito.getNome());
			preparedStatement.setString(3, partito.getDescrizione());
			preparedStatement.setInt(4, partito.getn_votazioni_ricevute());
            preparedStatement.setBytes(5, partito.getLogo());

            int result = preparedStatement.executeUpdate();
            if (result != 1) {
				try {
					connection.rollback();
				} catch (SQLException e) {
					Utility.printSQLException(e);
				}
				return false;
			}
            
            preparedStatement2 = connection.prepareStatement(insertCandidatoSQL);
            preparedStatement2.setString(1, candidato.getCf());
            preparedStatement2.setString(2, candidato.getNome());
            preparedStatement2.setString(3, candidato.getCognome());
            preparedStatement2.setString(4, candidato.getPartito());
            preparedStatement2.setString(5, candidato.getCurriculum());
            preparedStatement2.setBytes(6, candidato.getFoto());
            
            result = preparedStatement2.executeUpdate();

            if (result != 1) {
				try {
					connection.rollback();
				} catch (SQLException e) {
					Utility.printSQLException(e);
				}
				return false;
			}
            
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

	public void doUpdate(PartitoBean partito) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE partito SET leader = ?, descrizione = ?, n_votazioni_ricevute = ?, logo=? WHERE nome = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);

            preparedStatement.setString(1, partito.getLeader());
			preparedStatement.setString(2, partito.getDescrizione());			
			preparedStatement.setInt(3, partito.getn_votazioni_ricevute());
			preparedStatement.setBytes(4, partito.getLogo());
			preparedStatement.setString(5, partito.getNome());

			preparedStatement.executeUpdate();

			connection.commit();
		}catch(SQLException e){ System.out.println(e);
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

	public void doDelete(PartitoBean partito) throws SQLException {
		doDeleteCheck(partito);
	}

	public boolean doDeleteCheck(PartitoBean bean) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement2 = null;
		PreparedStatement preparedStatement3 = null;
		
		String querySQL = "SELECT COUNT(*) "
				   				+ "FROM Appartiene "
				   				+ "WHERE coalizione=(SELECT coalizione "
				   					 			+ "FROM Appartiene "
				   					 			+ "WHERE partito=? "
				   					 			+ ") ";
		
		String deleteCoalizioneSQL =  "DELETE FROM Coalizione "
						  + "WHERE nome=( SELECT coalizione "
						  + "FROM Appartiene "
						  + "WHERE partito=?"
						  + " ) ";
		
		String deleteSQL = "DELETE FROM Partito "
						+ "WHERE nome=?";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			
			String partito = bean.getNome();
			preparedStatement = connection.prepareStatement(querySQL);
			preparedStatement.setString(1, partito);
			ResultSet rs = preparedStatement.executeQuery();
			int count = 1000;
			if (rs.next()) {
				count = rs.getInt(1);
			}
		
			if (count == 2) {
				preparedStatement2 = connection.prepareStatement(deleteCoalizioneSQL);
				preparedStatement2.setString(1, partito);
				int result = preparedStatement2.executeUpdate();
				if (result != 1) {
					try {
						connection.rollback();
					} catch (SQLException e) {
						Utility.printSQLException(e);
					}
					return false;
				}
			}
	
			preparedStatement3 = connection.prepareStatement(deleteSQL);
			preparedStatement3.setString(1, partito);
			
			int result = preparedStatement3.executeUpdate();
			if (result != 1) {
				try {
					connection.rollback();
				} catch (SQLException e) {
					Utility.printSQLException(e);
				}
				return false;
			}
			
			connection.commit();
		} 
		finally {
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
	
	public Collection<PartitoBean> doRetrieveAllByCoalizione(PartitoBean partito) throws SQLException{
	Connection connection = null;
	PreparedStatement preparedStatement = null;

	Collection<PartitoBean> partiti = new LinkedList<PartitoBean>();

	String selectSQL = "SELECT * FROM partito WHERE nome IN (SELECT partito FROM appartiene WHERE coalizione=(SELECT coalizione FROM appartiene WHERE partito=?))";

	try {
		connection = ds.getConnection();
		preparedStatement = connection.prepareStatement(selectSQL);
		preparedStatement.setString(1, partito.getNome());

		ResultSet rs = preparedStatement.executeQuery();

		while (rs.next()) {
			PartitoBean bean = new PartitoBean();
			bean.setLeader(rs.getString("leader"));
			bean.setNome(rs.getString("nome"));
			bean.setDescrizione(rs.getString("descrizione"));
			bean.setn_votazioni_ricevute(rs.getInt("n_votazioni_ricevute"));
			bean.setLogo(rs.getBytes("logo")); 

			partiti.add(bean);
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

	return partiti;

}

}
