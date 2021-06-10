package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

public class PartitoModelDS implements Model<PartitoBean>{
    
	private DataSource ds = null;

	public PartitoModelDS(DataSource ds) {
		this.ds = ds;
	}

	public PartitoBean doRetrieveByKey(String id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		PartitoBean bean = new PartitoBean();

		String selectSQL = "SELECT * FROM partito WHERE nome = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setLeader(rs.getString("leader"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setn_votazioni_ricevute(rs.getInt("n_votazioni_ricevute"));
				bean.setLogo(rs.getBlob("logo")); //???
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

	public Collection<PartitoBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<PartitoBean> partiti = new LinkedList<PartitoBean>();

		String selectSQL = "SELECT * FROM partito";

		if (order != null && !order.equals("") && ((order == "leader") || (order == "nome") || (order == "descrizione") || (order == "n_votazioni_ricevute") || (order == "logo"))) {
			selectSQL += " ORDER BY " + order + " DESC";
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				PartitoBean bean = new PartitoBean();

				bean.setLeader(rs.getString("leader"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setn_votazioni_ricevute(rs.getInt("n_votazioni_ricevute"));
				bean.setLogo(rs.getBlob("logo")); 

				partiti.add(bean);
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

		return partiti;

	}

	public void doSave(PartitoBean partito) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO Partito (leader, nome, descrizione, n_votazioni_ricevute, logo) VALUES (?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);

			preparedStatement.setString(1, partito.getLeader());
			preparedStatement.setString(2, partito.getNome());
			preparedStatement.setString(3, partito.getDescrizione());
			preparedStatement.setInt(4, partito.getn_votazioni_ricevute());
            preparedStatement.setBlob(5, partito.getLogo());

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

	public void doUpdate(PartitoBean partito) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE partito SET leader = ?, nome = ?, descrizione = ?, n_votazioni_ricevute = ?, logo=? WHERE code = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);

            preparedStatement.setString(1, partito.getLeader());
			preparedStatement.setString(2, partito.getNome());
			preparedStatement.setString(3, partito.getDescrizione());			
			preparedStatement.setInt(4, partito.getn_votazioni_ricevute());
			preparedStatement.setBlob(5, partito.getLogo());

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

	@Override
	public void doDelete(PartitoBean partito) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String deleteSQL = "DELETE FROM partito WHERE nome = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, partito.getNome());

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
}
