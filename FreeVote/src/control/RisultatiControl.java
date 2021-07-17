package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.CoalizioneBean;
import model.CoalizioneModelDS;
import model.PartitoBean;
import model.PartitoModelDS;
import utils.Utility;

	@WebServlet("/Risultati")
	public class RisultatiControl extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			PartitoModelDS partitoModel = new PartitoModelDS(ds);
			CoalizioneModelDS coalizioneModel = new CoalizioneModelDS(ds);
			try {
				Collection<PartitoBean> partiti = partitoModel.doRetrieveAll("n_votazioni_ricevute DESC");
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
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
				return;
			}
			
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultati.jsp"));
			dispatcher.forward(request, response);
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doGet(request, response);
		}

	}