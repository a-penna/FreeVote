package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;
import utils.*;
public class ElettoreModelDS implements Model<ElettoreBean>{

	private DataSource ds = null;
	
	public ElettoreModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	@Override
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
				|| order.equals("sesso")
						
						);
	}
	
	@Override
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

	@Override
	public void doSave(ElettoreBean bean) throws SQLException {
		
		//TODO
	}

	@Override
	public void doUpdate(ElettoreBean bean) throws SQLException {
		//TODO
		
	}

	
	public boolean doDeleteCheck(ElettoreBean bean) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String codice = bean.getCodice();
		
		String selectSQL = "DELETE FROM elettore WHERE codice = ?";
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, codice);
			
			int rs = preparedStatement.executeUpdate();
			
			if (rs==1) {
				return true;
				
				
			}
			
		} 
		
		
		finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		}
		return false;
	
		
	}
    
	public void doDelete(ElettoreBean bean) throws SQLException {}
	
	
	
}
