package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class VotazioneReferendumModelDS implements Model<VotazioneReferendumBean> {
	private DataSource ds;
	
	public VotazioneReferendumModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public VotazioneReferendumBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		VotazioneReferendumBean bean = new VotazioneReferendumBean();

		String selectSQL = "SELECT * FROM votazione_referendum WHERE codice = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(id));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setData(rs.getDate("Data"));
				bean.setPreferenza(rs.getString("Preferenza"));
				bean.setElettore(rs.getString("Elettore"));
				bean.setCodice(rs.getInt("Codice"));
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
	
	public VotazioneReferendumBean doRetrieveByElettore(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		VotazioneReferendumBean bean = new VotazioneReferendumBean();

		String selectSQL = "SELECT * FROM votazione_referendum WHERE elettore = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setData(rs.getDate("Data"));
				bean.setPreferenza(rs.getString("Preferenza"));
				bean.setElettore(rs.getString("Elettore"));
				bean.setCodice(rs.getInt("Codice"));
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

	public Collection<VotazioneReferendumBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<VotazioneReferendumBean> votazioni = new LinkedList<VotazioneReferendumBean>();

		String selectSQL = "SELECT * FROM votazione_referendum";

		if (order != null && !order.equals("") && (order.equals("data") || order.equals("preferenza"))) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				VotazioneReferendumBean bean = new VotazioneReferendumBean();

				bean.setData(rs.getDate("Data"));
				bean.setPreferenza(rs.getString("Preferenza"));
				bean.setElettore(rs.getString("Elettore"));
				bean.setCodice(rs.getInt("Codice"));

				votazioni.add(bean);
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
		return votazioni;
	}
	
	public Collection<VotazioneReferendumBean> doRetrieveAllByPreferenza(String preferenza) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<VotazioneReferendumBean> votazioni = new LinkedList<VotazioneReferendumBean>();

		String selectSQL = "SELECT * FROM votazione_referendum WHERE preferenza=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, preferenza);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				VotazioneReferendumBean bean = new VotazioneReferendumBean();

				bean.setData(rs.getDate("Data"));
				bean.setPreferenza(rs.getString("Preferenza"));
				bean.setElettore(rs.getString("Elettore"));
				bean.setCodice(rs.getInt("Codice"));

				votazioni.add(bean);
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
		return votazioni;
	}

	public void doSave(VotazioneReferendumBean voto) throws SQLException{
		throw new UnsupportedOperationException();
	}

	public boolean doSaveCheck(VotazioneReferendumBean voto, ElettoreBean elettore) throws SQLException {
    	Connection connection = null;
		PreparedStatement preparedStatement1 = null;
		PreparedStatement preparedStatement2 = null;
		PreparedStatement preparedStatement3 = null;
		PreparedStatement preparedStatement4 = null;
		
		ResultSet rs = null;
	
		try {
			connection = ds.getConnection();	
			connection.setAutoCommit(false);		
			String selectSQL = "SELECT lista_codici_e_password_emesse "
        			   + "FROM Comune1 "
        			   + "WHERE nome=? AND cap=?";
        
			preparedStatement1 = connection.prepareStatement(selectSQL);
			preparedStatement1.setString(1, elettore.getComune());
			preparedStatement1.setString(2, elettore.getCap());
			rs = preparedStatement1.executeQuery();
			
			int result = 0;
			if(rs.next()) {		
				String lista = rs.getString(1);
				
				String nuovo = lista.replace(Utility.encryptMD5(elettore.getCodice()+ "," + elettore.getPassword()),"");
				String updateSQL = "UPDATE Comune1 "
					+ "SET lista_codici_e_password_emesse=? "
					+ "WHERE nome=? AND cap=?";
				preparedStatement2 = connection.prepareStatement(updateSQL);
				preparedStatement2.setString(1,nuovo);
				preparedStatement2.setString(2, elettore.getComune());
				preparedStatement2.setString(3, elettore.getCap());
				result = preparedStatement2.executeUpdate();
				if (result != 1) {
					try {
						connection.rollback();
					} catch(SQLException e) {
						Utility.printSQLException(e);
					}
					return false;
				}		
			}
			
			String insertSQL = "INSERT INTO Elettore(codice,password,sesso,eta,comunenome,comunecap) "
				+ "VALUES (?,?,?,?,?,?)";

			preparedStatement3 = connection.prepareStatement(insertSQL);
			preparedStatement3.setString(1, elettore.getCodice());
			preparedStatement3.setString(2, elettore.getPassword());
			preparedStatement3.setString(3, elettore.getSesso());
			preparedStatement3.setInt(4, elettore.getEta());
			preparedStatement3.setString(5, elettore.getComune());
			preparedStatement3.setString(6, elettore.getCap());
            result = preparedStatement3.executeUpdate();
         	if (result != 1) {
					try {
						connection.rollback();
					} catch(SQLException e) {
						Utility.printSQLException(e);
					}
					return false;
				}
            
            String insertVotoSQL = "INSERT INTO Votazione_Referendum(preferenza,data,elettore,referendum) "
            	+ "VALUES (?,?,?,(SELECT id FROM referendum))";
            
			preparedStatement4 = connection.prepareStatement(insertVotoSQL);
            preparedStatement4.setString(1, voto.getPreferenza());
            if (voto.getData() != null) {
				preparedStatement4.setDate(2, voto.getData());
			} else {
				preparedStatement4.setObject(2, null);
			} 
            preparedStatement4.setString(3, voto.getElettore());
            result = preparedStatement4.executeUpdate();
            if (result != 1) {
            	try {
    				connection.rollback();
    			} catch (SQLException e) {
    				Utility.printSQLException(e);
    			}
            	return false;
			}       
		} finally {
			try {
				if (preparedStatement4 != null)
					preparedStatement4.close();
				if (preparedStatement3 != null)
					preparedStatement3.close();
				if (preparedStatement2 != null)
					preparedStatement2.close();
				if (preparedStatement1 != null)
					preparedStatement1.close();
			} finally {
				if (connection != null) {
					connection.close();
				}
			}
		} 
		return true;
	} 

	public void doUpdate(VotazioneReferendumBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(VotazioneReferendumBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}
}