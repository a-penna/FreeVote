package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

public class ComuneModelDS implements Model<ComuneBean> {
	private DataSource ds;
	
	public ComuneModelDS(DataSource ds) {
		this.ds = ds;
	}
	
	public ComuneBean doRetrieveByKey(String key, String key2) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ComuneBean bean = new ComuneBean();

		String selectSQL = "SELECT * FROM Comune1 NATURAL JOIN Comune2 WHERE nome=? AND cap=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, key);
			preparedStatement.setString(2, key2);

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {				
				bean.setNome(rs.getString("nome"));
                bean.setCAP(rs.getString("cap"));
                bean.setListaCodiciPassword(rs.getString("LISTA_CODICI_E_PASSWORD_EMESSE"));
                bean.setNAventiDiritto(rs.getInt("N_AVENTI_DIRITTO"));
                bean.setRegione(rs.getString("NOME_REGIONE"));
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
	
	public Collection<ComuneBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ComuneBean> comuni = new LinkedList<ComuneBean>();

		String selectSQL = "SELECT * FROM Comune1 NATURAL JOIN Comune2";

		if (order != null && !order.equals("") && (order.equals("nome") || order.equals("cap") || order.equals("n_aventi_diritto") || order.equals("nome_regione"))) {
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
                bean.setNAventiDiritto(rs.getInt("N_AVENTI_DIRITTO"));
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

	public void doDelete(ComuneBean admin) throws SQLException {
        throw new UnsupportedOperationException();
    }

    public ComuneBean doRetrieveByKey(String key) throws SQLException {
        throw new UnsupportedOperationException();
    }

    public Collection<String> doRetrieveAllRegioni(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<String> regioni = new LinkedList<String>();

		String selectSQL = "SELECT DISTINCT nome_regione FROM comune2";

		if (order != null && !order.equals("") && order.equals("nome_regione")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				regioni.add(rs.getString(1));
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

		return regioni;
	}

}
	

