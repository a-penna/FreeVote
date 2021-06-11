/*package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import control.ListaPartitiControl;

public class ComuneModelDS implements Model<Comune> {
	private DataSource ds;
	
	public ComuneModelDS(DataSource ds) {
		this.ds = ds;
	}
	

	
	public Collection<ComuneBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ComuneBean> comuni = new LinkedList<ComuneBean>();

		String selectSQL = "SELECT * FROM Comune1 NATURAL JOIN Comune2";

		if (order != null && !order.equals("") && (order == "nome" || order == "cap" || order == "n_aventi_diritto")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ComuneBean bean = new ComuneBean();
                bean.setNome(rs.getString("nome"));
                bean.setCAP(rs.getString("cap"));
                bean.setListaCodiciPassword(rs.getString("LISTA_CODICI_E_PASSWORD_EMESSE"));
                bean.setNAventiDiritto(rs.getString("N_AVENTI_DIRITTO"));
                bean.setRegione(rs.getString("NOME_REGIONE"));

				comuni.add(bean);
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

		return comuni;
	}

	public void doSave(ComuneBean comune) throws SQLException {	
        throw new UnsupportedOperationException();
    }

	public void doUpdate(ComuneBean comune) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(AdminBean admin) throws SQLException {
        throw new UnsupportedOperationException();
    }

    public void doRetrieveByKey(String key) throws SQLException {
        throw new UnsupportedOperationException();
    }
	@Override
	public ComuneBean doRetrieveByKey(String key, String key2) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		AdminBean bean = new AdminBean();
		

		String selectSQL = "SELECT * FROM Admin WHERE nomeutente = MD5(?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, key);

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

	*/

