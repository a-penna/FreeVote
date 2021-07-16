package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.CandidatoBean;
import model.CandidatoModelDS;
import utils.Utility;

@WebServlet("/Candidato")
public class CandidatoControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
        
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cf = request.getParameter("cf");
		
		if (cf == null) {
		 	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/PartitiControl")); 
		 	return;
		}
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        CandidatoModelDS candidatoModel = new CandidatoModelDS(ds);
		
		try {
			CandidatoBean candidato = candidatoModel.doRetrieveByKey(cf);
			if (candidato.isEmpty()) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/PartitiControl")); 
				return;
			}
			request.setAttribute("candidato", candidato); 
		} catch (SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		}
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/candidato.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
}

