package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

public class AdminModelDS implements Model<AdminBean> {
	private DataSource ds;
	
	public AdminModelDS(DataSource ds) {
		this.ds = ds;
	}

	public Collection<AdminBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<AdminBean> admins = new LinkedList<AdminBean>();

		String selectSQL = "SELECT * FROM Admin";

		if (order != null && !order.equals("") && (order.equals("password") || order.equals("nomeutente"))) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection(); 
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				AdminBean bean = new AdminBean();

				bean.setPassword(rs.getString("password"));
				bean.setnomeUtente(rs.getString("nomeutente"));

				admins.add(bean);
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

		return admins;
	}

	public void doSave(AdminBean admin) throws SQLException {	}

	public void doUpdate(AdminBean admin) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(AdminBean admin) throws SQLException { }

	@Override
	public AdminBean doRetrieveByKey(String key) throws SQLException { 
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		AdminBean bean = new AdminBean();
		

		String selectSQL = "SELECT * FROM Admin WHERE nomeutente = MD5(?)";

		try {
			connection = ds.getConnection(); 
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, key); //inseriamo key nello statement SQL

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {					
				bean.setPassword(rs.getString("password"));
				bean.setnomeUtente(rs.getString("nomeutente"));
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
}

	
