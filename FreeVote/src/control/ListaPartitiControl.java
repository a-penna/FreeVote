package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import utils.Utility;

@WebServlet("/PartitiControl")
public class ListaPartitiControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS model = new PartitoModelDS(ds);
		CoalizioneModelDS coalizioneModel = new CoalizioneModelDS(ds);
		try {
			Collection<PartitoBean> partiti = model.doRetrieveAll("nome");
			Iterator<PartitoBean> it = partiti.iterator();
			Collection<CoalizioneBean> coalizioni = new LinkedList<CoalizioneBean>();
			while (it.hasNext()) {
				PartitoBean partito = (PartitoBean)it.next();
				coalizioni.add(coalizioneModel.doRetrieveByPartito(partito.getNome()));
			}
			request.setAttribute("partiti", partiti);
			request.setAttribute("coalizioni", coalizioni);
		} catch (SQLException e) {
			Utility.printSQLException(e);
		}

		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/listaPartiti.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
