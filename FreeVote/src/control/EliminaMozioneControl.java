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

import model.MozioneBean;
import model.MozioneModelDS;
import utils.Utility;

@WebServlet("/EliminaMozione")
public class EliminaMozioneControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
		if(!loggedIn) {
			response.sendRedirect(request.getContextPath() + "/loginAdmin.jsp");
			return;
		}
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		MozioneModelDS model = new MozioneModelDS(ds);	
		
		try {
				Collection<MozioneBean> mozioni = model.doRetrieveAll("id");
				request.setAttribute("mozioni", mozioni);
				if (request.getParameter("id") != null) {
					MozioneBean mozione = new MozioneBean();
					try {
						mozione.setID(Integer.parseInt(request.getParameter("id")));
					} catch(NumberFormatException exc) {
						response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/deleteError.jsp"));
						return;
					}
					boolean flag = model.doDeleteCheck(mozione);
					if(flag) {
						response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
						return;
					} else {
						response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/deleteError.jsp"));
						return;
					}
				}
			
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/eliminaMozione.jsp"));
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
