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

import model.*;
import utils.Utility;

@WebServlet("/EliminazioneCandidato")
public class EliminaCandidatoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
		if(!loggedIn) {
			response.sendRedirect(request.getContextPath() + "/loginAdmin.jsp");
			return;
		}
		
		String codice = request.getParameter("cf");
		if (codice == null) {
			response.sendRedirect(response.encodeRedirectURL("/admin/eliminaCandidato.jsp"));
			return;
		}
		
		if (!Utility.checkCf(codice)) {
			request.setAttribute("cfInvalido", "true");
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/eliminaCandidato.jsp"));
			dispatcher.forward(request, response);
			return;
		} 
		codice = codice.toUpperCase();
		
		codice = Utility.encryptMD5(request.getParameter("cf"));

		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		CandidatoModelDS model = new CandidatoModelDS(ds);	
		
		String redirectedPage = "";

		try {
			CandidatoBean bean = model.doRetrieveByKey(codice);

			boolean flag = model.doDeleteCheck(bean);
			
		    if(flag) {
		    	redirectedPage="/successo.jsp";
		    } else {
		    	redirectedPage="/error/deleteError.jsp"; //page di errore non esiste candidato
		    }
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
		}
}


