package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


import model.PartitoBean;
import model.PartitoModelDS;
import utils.Utility;

@WebServlet("/PartitiControl")
public class ListaPartitiControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS model = new PartitoModelDS(ds);

		try {
			Collection<PartitoBean> partiti = model.doRetrieveAll("nome");
			request.setAttribute("partiti", partiti);
		} catch (SQLException e) {
			Utility.printSQLException(e);
		}

		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/listaPartiti.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
