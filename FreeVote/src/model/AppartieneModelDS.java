package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class AppartieneModelDS implements Model<AppartieneBean>{
    
	private DataSource ds = null;
	public AppartieneModelDS(DataSource ds) {
		this.ds = ds;
	}

	public AppartieneBean doRetrieveByKey(String id) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public Collection<AppartieneBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<AppartieneBean> listaAppartenenze = new LinkedList<AppartieneBean>();

		String selectSQL = "SELECT * FROM appartiene";

		if (order != null && !order.equals("") && order.equals("partito") && order.equals("coalizione"))
			selectSQL += " ORDER BY " + order;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				AppartieneBean bean = new AppartieneBean();
				bean.setPartito(rs.getString("partito"));
				bean.setCoalizione(rs.getString("coalizione"));
                listaAppartenenze.add(bean);
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

		return listaAppartenenze;
	}

    public boolean doSaveCheck(AppartieneBean appartiene) throws SQLException {
        Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO appartiene(partito,coalizione) VALUES (?,?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setString(1, appartiene.getPartito());
            preparedStatement.setString(2, appartiene.getCoalizione());

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


	public void doSave(AppartieneBean appartiene) throws SQLException {
        doSaveCheck(appartiene);
	}

	public void doUpdate(AppartieneBean coalizione) throws SQLException { 
		throw new UnsupportedOperationException(); 
	}

	public void doDelete(AppartieneBean appartiene) throws SQLException {
		doDeleteCheck(appartiene);
	}
	
	public boolean doDeleteCheck(AppartieneBean appartiene) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
        PreparedStatement preparedStatement2 = null;

		ResultSet rs = null;

		try {
			connection = ds.getConnection();		    
			
			String selectSQL = "SELECT COUNT(*) "
					   + "FROM Appartiene "
					   + "WHERE coalizione=(SELECT coalizione "
					   					 + "FROM Appartiene "
					   					 + "WHERE partito=? "
					   					 + ") ";
			
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, appartiene.getPartito());
			rs = preparedStatement.executeQuery();
			int count = 1000;
			if (rs.next()) 
				count = rs.getInt(1);
			
			if (count > 2) {
				String deleteSQL = "DELETE FROM Appartiene "
						+ "WHERE Partito=?";
				
				preparedStatement2 = connection.prepareStatement(deleteSQL);
                preparedStatement2.setString(1, appartiene.getPartito());
				int result = preparedStatement2.executeUpdate(deleteSQL);
				if (result > 0) {
					return true;
				} else {
					
					return false;
				}
			} else if (count == 2){
				String deleteSQL = "DELETE FROM Coalizione "
					+ "WHERE nome=( SELECT coalizione "
								 + "FROM Appartiene "
								 + "WHERE partito=?"
								+ " ) ";
				
				preparedStatement2 = connection.prepareStatement(deleteSQL);
				int result = preparedStatement2.executeUpdate(deleteSQL);
				if (result > 0) {
					return true;
				} else {
					return false;
				}
			} else if (count == 0) {
				return false;
			}
            connection.commit();
		}
	 	catch (SQLException e) {
			Utility.printSQLException(e);
		} finally {
			try {
				if (rs != null) 
					rs.close();
				if (preparedStatement2!= null)
					preparedStatement2.close();
				if (preparedStatement != null)
					preparedStatement.close();
			
			} catch (SQLException e) {
				Utility.printSQLException(e);
			}
		}
        return true;
	}
}


