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
import utils.Utility;

	@WebServlet("/RisultatiCoalizione")
	public class RisultatiCoalizioneControl extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			CoalizioneModelDS coalizioneModel = new CoalizioneModelDS(ds);
			try {
				Collection<CoalizioneBean> coalizioni = coalizioneModel.doRetrieveAll("nome");
                Collection<String> nVotazioni = new LinkedList<String>();
                
				Iterator<CoalizioneBean> it = coalizioni.iterator();
                while (it.hasNext()) {
                    nVotazioni.add("" + coalizioneModel.doRetrieveVoti((CoalizioneBean)it.next()));
                }
		
				request.setAttribute("coalizioni", coalizioni);
                request.setAttribute("nVotazioni", nVotazioni);  
			} catch (SQLException e) {
				Utility.printSQLException(e);
			}
			
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiCoalizioni.jsp"));
			dispatcher.forward(request, response);
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doGet(request, response);
		}

	}
