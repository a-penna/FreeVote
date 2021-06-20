package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import model.*;
import utils.Utility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/EliminaCoalizione")
public class EliminaCoalizioneControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
		if(!loggedIn) {
			response.sendRedirect(request.getContextPath() + "/loginAdmin.jsp");
			return;
		}
		
		DataSource ds = (DataSource)getServletContext().getAttribute("DataSource");
		CoalizioneModelDS model = new CoalizioneModelDS(ds); 
		
		try {
			Collection<CoalizioneBean> coalizioni = model.doRetrieveAll("nome");
			request.setAttribute("listaCoalizioni", coalizioni);
			String coalizione = (String)request.getParameter("coalizione");
			if (coalizione != null) {
				CoalizioneBean bean = model.doRetrieveByKey(coalizione);
				boolean flag = model.doDeleteCheck(bean);
				
				if(flag) {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
					return;
				} else {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
					return;
				}
			}
		} catch (SQLException e) {
			Utility.printSQLException(e);
		}
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/eliminaCoalizione.jsp"));
		dispatcher.forward(request, response);
	}

}
