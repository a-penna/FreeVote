package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class ElettoreModelDS implements Model<ElettoreBean>{

	private DataSource ds = null;
	
	public ElettoreModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public ElettoreBean doRetrieveByKey(String key) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		ElettoreBean bean = new ElettoreBean();
		
		String selectSQL = "SELECT * FROM elettore WHERE codice = ?";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, key);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				bean.setCap(rs.getString("ComuneCAP"));
				bean.setComune(rs.getString("ComuneNome"));
				bean.setCodice(rs.getString("Codice"));
				bean.setPassword(rs.getString("Password"));
				bean.setEta(rs.getInt("eta"));
				bean.setSesso(rs.getString("sesso"));
			}
			rs.close();
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
				&& (order.equals("codice") 
				|| order.equals("password") 
				|| order.equals("eta") 
				|| order.equals("ComuneNome") 
				|| order.equals("ComuneCAP") 
				|| order.equals("regione")
				|| order.equals("sesso"));
	}
	
	public Collection<ElettoreBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<ElettoreBean> elettori = new LinkedList<ElettoreBean>();
		
		String selectSQL = "SELECT * FROM elettore";
		
		if (checkOrder(order)) { 
			selectSQL += " ORDER BY " + order;
		}
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				ElettoreBean bean = new ElettoreBean();
				
				bean.setCap(rs.getString("ComuneCAP"));
				bean.setComune(rs.getString("ComuneNome"));
				bean.setCodice(rs.getString("Codice"));
				bean.setPassword(rs.getString("Password"));
				bean.setEta(rs.getInt("eta"));
				bean.setSesso(rs.getString("sesso"));
				
				elettori.add(bean);
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
		
		return elettori; 
	}

	public void doSave(ElettoreBean bean) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doUpdate(ElettoreBean bean) throws SQLException {
		throw new UnsupportedOperationException();
	}
	
	public boolean doDeleteCheck(ElettoreBean bean) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement preparedStatement2 = null;
		
		
		String updatePartitoSQL = "UPDATE Partito SET n_votazioni_ricevute=n_votazioni_ricevute-1 "
					+ "WHERE nome=(SELECT partito  "
					+ "FROM Votazione_Politica "
					+ "WHERE elettore=?) " ;
		
		String deleteSQL = "DELETE FROM Elettore "
						 + "WHERE codice=?" ;
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			
			preparedStatement = connection.prepareStatement(updatePartitoSQL);
			
			String codice = bean.getCodice();
			preparedStatement.setString(1, codice);
			
			int result = preparedStatement.executeUpdate();
			if (result != 1) {
				try {
					connection.rollback();
				} catch (SQLException e) {
					Utility.printSQLException(e);
				}
				return false;
			}
			
			preparedStatement2 = connection.prepareStatement(deleteSQL);
			
			preparedStatement2.setString(1, codice);
			
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
		} 
		finally {
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
    
	public void doDelete(ElettoreBean bean) throws SQLException {
		doDeleteCheck(bean);
	}
	
	
	
}
