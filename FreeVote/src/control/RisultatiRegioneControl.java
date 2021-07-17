package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import model.*;
import utils.Utility;

@WebServlet("/RisultatiReg")
public class RisultatiRegioneControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DataSource ds = (DataSource)getServletContext().getAttribute("DataSource");
		ComuneModelDS comuneModel = new ComuneModelDS(ds);
		VotazionePoliticaModelDS votoModel = new VotazionePoliticaModelDS(ds);
		
		try {
			Collection<String> regioni = comuneModel.doRetrieveAllRegioni("nome_regione");
			request.setAttribute("regioni", regioni);
			
			String regione = request.getParameter("regione");
			if (regione == null) {
				RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiRegioni.jsp"));
				dispatcher.forward(request, response);
				return;
			}
			
			if (comuneModel.doRetrieveAllRegioni(regione).isEmpty()) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/risultatiRegioni.jsp"));
				return;
			}
			
			request.setAttribute("regione", regione);
			Collection<String[]> percentuali = votoModel.doRetrievePercByRegione(regione);
			request.setAttribute("percentuali", percentuali);
			
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiRegioni.jsp"));
			dispatcher.forward(request, response);
		} catch(SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
