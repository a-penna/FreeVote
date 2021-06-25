package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class CandidatoModelDS implements Model<CandidatoBean>{
	
	private DataSource ds = null;
	
	public CandidatoModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public CandidatoBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		CandidatoBean bean = new CandidatoBean();
		
		String selectSQL = "SELECT * FROM candidato WHERE codice_fiscale = ?";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				bean.setCf(rs.getString("codice_fiscale"));
				bean.setNome(rs.getString("nome"));
				bean.setCognome(rs.getString("cognome"));
				bean.setPartito(rs.getString("partito"));
				bean.setFoto(rs.getBytes("foto")); 
				bean.setCurriculum(rs.getString("curriculum"));
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
				&& (order.equals("codice_fiscale") 
				|| order.equals("nome") 
				|| order.equals("cognome") 
				|| order.equals("partito") 
				|| order.equals("foto") 
				|| order.equals("curriculum"));
	}
	
	public Collection<CandidatoBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<CandidatoBean> candidati = new LinkedList<CandidatoBean>();
		
		String selectSQL = "SELECT * FROM candidato";
		
		if (checkOrder(order)) { 
			selectSQL += " ORDER BY " + order;
		}
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				CandidatoBean bean = new CandidatoBean();
				
				bean.setCf(rs.getString("codice_fiscale"));
				bean.setNome(rs.getString("nome"));
				bean.setCognome(rs.getString("cognome"));
				bean.setPartito(rs.getString("partito"));
				bean.setFoto(rs.getBytes("foto")); 
				bean.setCurriculum(rs.getString("curriculum")); 
				
				candidati.add(bean);
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
		
		return candidati; 
	}
	
	public void doSave(CandidatoBean candidato) throws SQLException {
		doSaveCheck(candidato);
	}
	
	public boolean doSaveCheck(CandidatoBean candidato) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL = "INSERT INTO Candidato (codice_fiscale,nome,cognome,curriculum,foto,partito) VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			
			preparedStatement.setString(1, candidato.getCf());
			preparedStatement.setString(2, candidato.getNome());
			preparedStatement.setString(3, candidato.getCognome());
			preparedStatement.setString(4, candidato.getCurriculum());
			preparedStatement.setBytes(5, candidato.getFoto());
			preparedStatement.setString(6, candidato.getPartito());
			
			int rs = preparedStatement.executeUpdate();
			if (rs != 1) {
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

	public void doUpdate(CandidatoBean candidato) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String updateSQL = "UPDATE candidato SET nome = ?, cognome = ?, partito = ?, foto = ?, curriculum =? WHERE codice_fiscale = ?";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);
			
			preparedStatement.setString(1, candidato.getNome());
			preparedStatement.setString(2, candidato.getCognome());
			preparedStatement.setString(3, candidato.getPartito());			
			preparedStatement.setBytes(4, candidato.getFoto());
			preparedStatement.setString(5, candidato.getCurriculum());
			preparedStatement.setString(6, candidato.getCf());
			
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
	

	public void doDelete(CandidatoBean candidato) throws SQLException {
		doDeleteCheck(candidato);
	}
	
	public boolean doDeleteCheck(CandidatoBean candidato) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String deleteSQL = "DELETE FROM candidato WHERE codice_fiscale = ?";
		
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, candidato.getCf());
			
			int rs = preparedStatement.executeUpdate();
			if (rs != 1) {
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
	
	public Collection<CandidatoBean> doRetrieveByPartito(String partito, String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<CandidatoBean> candidati = new LinkedList<CandidatoBean>();
		
		String selectSQL = "SELECT * FROM candidato WHERE partito = ?";
		
		if (checkOrder(order)) { 
			selectSQL += " ORDER BY " + order;
		}
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1,partito);
			ResultSet rs = preparedStatement.executeQuery();
			
			while (rs.next()) {
				CandidatoBean bean = new CandidatoBean();
				
				bean.setCf(rs.getString("codice_fiscale"));
				bean.setNome(rs.getString("nome"));
				bean.setCognome(rs.getString("cognome"));
				bean.setPartito(rs.getString("partito"));
				bean.setFoto(rs.getBytes("foto")); 
				bean.setCurriculum(rs.getString("curriculum")); 
				
				candidati.add(bean);
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
		
		return candidati; 
	}
	
}
