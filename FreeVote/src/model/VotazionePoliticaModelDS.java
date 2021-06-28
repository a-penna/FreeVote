package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import utils.Utility;

public class VotazionePoliticaModelDS implements Model<VotazionePoliticaBean> {
	private DataSource ds;
	
	public VotazionePoliticaModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public VotazionePoliticaBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		VotazionePoliticaBean bean = new VotazionePoliticaBean();

		String selectSQL = "SELECT * FROM votazione_politica WHERE codice = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(id));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setData(rs.getDate("Data"));
				bean.setPartito(rs.getString("Partito"));
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
	
	public VotazionePoliticaBean doRetrieveByElettore(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		VotazionePoliticaBean bean = new VotazionePoliticaBean();

		String selectSQL = "SELECT * FROM votazione_politica WHERE elettore = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setData(rs.getDate("Data"));
				bean.setPartito(rs.getString("Partito"));
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

	public Collection<VotazionePoliticaBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<VotazionePoliticaBean> votazioni = new LinkedList<VotazionePoliticaBean>();

		String selectSQL = "SELECT * FROM votazione_politica";

		if (order != null && !order.equals("") && (order.equals("data") || order.equals("partito"))) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				VotazionePoliticaBean bean = new VotazionePoliticaBean();

				bean.setData(rs.getDate("Data"));
				bean.setPartito(rs.getString("Partito"));
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
	
	public Collection<VotazionePoliticaBean> doRetrieveAllByRegione(String regione) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<VotazionePoliticaBean> votazioni = new LinkedList<VotazionePoliticaBean>();

		String selectSQL = "SELECT VP.data, VP.partito, VP.elettore, VP.codice "
				+ "FROM Votazione_Politica as VP, Elettore as E, Comune2 as C2 "
				+ "WHERE VP.elettore=E.codice "
				+ "AND E.comuneCap=C2.cap "
				+ "AND C2.nome_regione=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, regione);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				VotazionePoliticaBean bean = new VotazionePoliticaBean();

				bean.setData(rs.getDate("Data"));
				bean.setPartito(rs.getString("Partito"));
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
	
	public Collection<VotazionePoliticaBean> doRetrieveAllByPartito(String partito) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<VotazionePoliticaBean> votazioni = new LinkedList<VotazionePoliticaBean>();

		String selectSQL = "SELECT * FROM votazione_politica WHERE partito=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, partito);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				VotazionePoliticaBean bean = new VotazionePoliticaBean();

				bean.setData(rs.getDate("Data"));
				bean.setPartito(rs.getString("Partito"));
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

	public void doSave(VotazionePoliticaBean voto) throws SQLException{
		throw new UnsupportedOperationException();
	}

	public boolean doSaveCheck(VotazionePoliticaBean voto, ElettoreBean elettore, String codice, String password) throws SQLException {
    	Connection connection = null;
		PreparedStatement preparedStatement1 = null;
		PreparedStatement preparedStatement2 = null;
		PreparedStatement preparedStatement3 = null;
		PreparedStatement preparedStatement4 = null;
		PreparedStatement preparedStatement5 = null;
		
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
				
				String nuovo = lista.replace(Utility.encryptMD5(codice + "," + password),"");
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
            
            String insertVotoSQL = "INSERT INTO Votazione_Politica(data,elettore,partito) "
            	+ "VALUES (?,?,?)";
            
			preparedStatement4 = connection.prepareStatement(insertVotoSQL);
            if (voto.getData() != null) {
				preparedStatement4.setDate(1, voto.getData());
			} else {
				preparedStatement4.setObject(1, null);
			} 
            preparedStatement4.setString(2, voto.getElettore());
            preparedStatement4.setString(3, voto.getPartito());
            result = preparedStatement4.executeUpdate();
            if (result != 1) {
            	try {
    				connection.rollback();
    			} catch (SQLException e) {
    				Utility.printSQLException(e);
    			}
            	return false;
			}
            
            String updatePartitoSQL = "UPDATE Partito SET n_votazioni_ricevute=n_votazioni_ricevute+1 "
            	+ "WHERE nome=? ";
                
            preparedStatement5 = connection.prepareStatement(updatePartitoSQL);
            preparedStatement5.setString(1, voto.getPartito());
            
            result = preparedStatement5.executeUpdate();
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
				if (preparedStatement5 != null)
					preparedStatement5.close();
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



	public boolean doSaveBoth(VotazionePoliticaBean voto, VotazioneReferendumBean votoReferendum, ElettoreBean elettore, String codice, String password) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement1 = null;
		PreparedStatement preparedStatement2 = null;
		PreparedStatement preparedStatement3 = null;
		PreparedStatement preparedStatement4 = null;
		PreparedStatement preparedStatement5 = null;
		PreparedStatement preparedStatement6 = null;
		
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
				
				String nuovo = lista.replace(Utility.encryptMD5(codice+ "," + password),"");
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
            
            String insertVotoSQL = "INSERT INTO Votazione_Politica(data,elettore,partito) "
            	+ "VALUES (?,?,?)";
            
			preparedStatement4 = connection.prepareStatement(insertVotoSQL);
            if (voto.getData() != null) {
				preparedStatement4.setDate(1, voto.getData());
			} else {
				preparedStatement4.setObject(1, null);
			} 
            preparedStatement4.setString(2, voto.getElettore());
            preparedStatement4.setString(3, voto.getPartito());
            result = preparedStatement4.executeUpdate();
            if (result != 1) {
            	try {
    				connection.rollback();
    			} catch (SQLException e) {
    				Utility.printSQLException(e);
    			}
            	return false;
			}
            
            String updatePartitoSQL = "UPDATE Partito SET n_votazioni_ricevute=n_votazioni_ricevute+1 "
            	+ "WHERE nome=? ";
                
            preparedStatement5 = connection.prepareStatement(updatePartitoSQL);
            preparedStatement5.setString(1, voto.getPartito());
            
            result = preparedStatement5.executeUpdate();
            if (result != 1) {
            	try {
            		connection.rollback();
            	} catch (SQLException e) {
            		Utility.printSQLException(e);
            	}
            	return false;
			}
			
			 String insertRefSQL = "INSERT INTO Votazione_Referendum(preferenza,data,elettore,referendum) "
            	+ "VALUES (?,?,?,(SELECT id FROM referendum))";
            
			preparedStatement6 = connection.prepareStatement(insertRefSQL);
            preparedStatement6.setString(1, votoReferendum.getPreferenza());
            if (voto.getData() != null) {
				preparedStatement6.setDate(2, votoReferendum.getData());
			} else {
				preparedStatement6.setObject(2, null);
			} 
            preparedStatement6.setString(3, votoReferendum.getElettore());
            result = preparedStatement6.executeUpdate();
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
				if (preparedStatement6 != null)
					preparedStatement6.close();
				if (preparedStatement5 != null)
					preparedStatement5.close();
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
	
	public void doUpdate(VotazionePoliticaBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(VotazionePoliticaBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}
	
	public Collection<String> doRetrievePercByRegione(String regione) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<String> percentuali = new LinkedList<String>();

		String selectSQL = "SELECT VP.partito, COUNT(*)*100/(SELECT COUNT(*) "
														  + "FROM Votazione_Politica as VP2, Elettore as E2, Comune2 as C2 "
														  + "WHERE c2.nome_regione=? "
														  + "AND VP2.elettore = E2.codice "
														  + "AND E2.comuneCap=C2.cap) AS PERCENTUALE "
						+ "FROM Votazione_Politica as VP, Elettore as E, Comune2 as C "
						+ "WHERE VP.elettore=E.codice "
						+ "AND E.comuneCap=C.cap "
						+ "AND C.nome_regione=? "
						+ "GROUP BY VP.partito "
						+ "ORDER BY  PERCENTUALE desc";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, regione);
			preparedStatement.setString(2, regione);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				String percentuale = "";
				percentuale += rs.getString("partito");
				percentuale += " ";
				percentuale += rs.getString("percentuale");
				percentuali.add(percentuale);
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

		return percentuali;
	}
}

