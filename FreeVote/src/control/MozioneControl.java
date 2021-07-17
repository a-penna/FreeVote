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

import model.MozioneModelDS;
import utils.Utility;

import model.*;

@WebServlet("/Mozione")
public class MozioneControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		if (id == null) {
		 	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Referendum"));
		 	return;
		}
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		MozioneModelDS mozioneModel = new MozioneModelDS(ds);
		AutoreModelDS autoreModel = new AutoreModelDS(ds);
		
		try {
			MozioneBean mozione = mozioneModel.doRetrieveByKey(id);
			if (mozione.isEmpty()) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Referendum"));
			 	return;
			}
			request.setAttribute("mozione", mozione); 
			
			Collection<AutoreBean> autori = autoreModel.doRetrieveByID(mozione.getID());
			request.setAttribute("autori", autori);
		} catch (SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		} catch (NumberFormatException ex) {
		 	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Referendum"));
		 	return;
		}
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/mozione.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
