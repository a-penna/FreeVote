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

	public void doSave(VotazionePoliticaBean voto, ElettoreBean elettore) throws SQLException {

    	Connection connection = null;
		PreparedStatement preparedStatement1 = null;
		PreparedStatement preparedStatement2 = null;
		PreparedStatement preparedStatement3 = null;
		PreparedStatement preparedStatement4 = null;
		PreparedStatement preparedStatement5 = null;

		
		ResultSet rs = null;
	
		/*try {
			con = DBConnectionPool.getConnection(user, pass);	
						
			String sql = "SELECT lista_codici_e_password_emesse "
        			   + "FROM Comune1 "
        			   + "WHERE nome=? AND cap=?";
        
			ps = con.prepareStatement(sql);
			ps.setString(1, );
			ps.setString(2,e.getComuneCAP());
			rs = ps.executeQuery();
			
			int result = 0;
			if(rs.next()) {		
				String lista = rs.getString(1);
				
				String nuovo = lista.replace(Utility.encryptMD5(e.getCodice()+","+e.getPassword()),"");
				sql = "UPDATE Comune1 "
					+ "SET lista_codici_e_password_emesse=? "
					+ "WHERE nome=? AND cap=?";
				ps2 = con.prepareStatement(sql);
				ps2.setString(1,nuovo);
				ps2.setString(2, e.getComuneNome());
				ps2.setString(3,e.getComuneCAP());
				result = ps2.executeUpdate();
				if (result <= 0) {
					System.out.println("\nImpossibile entrare, riprovare!\n");
					return;
				}		
			}
			
			sql = "INSERT INTO Elettore(codice,password,sesso,eta,comunenome,comunecap) "
				+ "VALUES (MD5(?),MD5(?),?,?,?,?)";

			ps3 = con.prepareStatement(sql);
			ps3.setString(1, e.getCodice());
			ps3.setString(2, e.getPassword());
			ps3.setString(3, "" + e.getSesso());
			ps3.setInt(4, e.getEta());
			ps3.setString(5,e.getComuneNome());
			ps3.setString(6, e.getComuneCAP());
			ps3.setString(1, e.getCodice());
            result = ps3.executeUpdate();
            if (result <= 0) {
				System.out.println("\nImpossibile inserire la votazione nel sistema!\n");
				try {
    				con.rollback();
    			} catch (SQLException exc) {
    				System.err.println(exc.getMessage());
    			}
				return;
			}
            
            sql = "INSERT INTO Votazione_Politica(data,elettore,partito) "
            	+ "VALUES (?,MD5(?),?)";
            
			ps4 = con.prepareStatement(sql);
            if (vp.getData() != null) {
				ps4.setDate(1, Utility.toSqlDate(vp.getData()));
			} else {
				ps4.setObject(1, null);
			} 
            ps4.setString(2, vp.getElettore());
            ps4.setString(3, vp.getPartito());
            result = ps4.executeUpdate();
            if (result <= 0) {
            	System.out.println("\nImpossibile inserire la votazione nel sistema!\n");
            	try {
    				con.rollback();
    			} catch (SQLException exc) {
    				System.err.println(exc.getMessage());
    			}
            	return;
			}
            
            sql = "UPDATE Partito SET n_votazioni_ricevute=n_votazioni_ricevute+1 "
            	+ "WHERE nome=? ";
                
            ps5 = con.prepareStatement(sql);
            ps5.setString(1, vp.getPartito());
            
            result = ps5.executeUpdate();
            if (result <= 0) {
            	System.out.println("\nImpossibile inserire la votazione nel sistema!\n");
            	try {
            		con.rollback();
            	} catch (SQLException exc) {
            		System.err.println(exc.getMessage());
            	}
            	return;
			}

            con.commit();
		} catch (SQLException s) {
			try {
				con.rollback();
			} catch (SQLException exc) {
				System.out.println(exc.getMessage());
			}
			System.out.println("\nERRORE NELL'INSERIMENTO VOTAZIONE!\n");
			Utility.printSQLException(s);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (ps2 != null)
					ps2.close();
				if (ps3 != null)
					ps3.close();
				if (ps4 != null)
					ps4.close();
				if (ps5 != null)
					ps5.close();
				if (ps6 != null)
					ps6.close();
				DBConnectionPool.releaseConnection(con);
			} catch (SQLException s) {
				System.err.println(s.getMessage());
				Utility.printSQLException(s);
			}
        }
    }
    
		

		String insertSQL = "INSERT INTO Votazione_Politica(data,elettore,partito) VALUES (?,MD5(?),?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			if (voto.getData() != null) {
				preparedStatement.setDate(1, voto.getData());
			} else {
				preparedStatement.setObject(1, null);
			} 
			preparedStatement.setString(2, voto.getElettore());
			preparedStatement.setString(3, voto.getPartito());

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
		} */
	} 

	public void doUpdate(VotazionePoliticaBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(VotazionePoliticaBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}
}

