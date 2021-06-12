package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

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

	public void doSave(VotazionePoliticaBean voto) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

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
		}
	}

	public void doUpdate(VotazionePoliticaBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}

	public void doDelete(VotazionePoliticaBean mozione) throws SQLException {
		throw new UnsupportedOperationException();
	}
}

