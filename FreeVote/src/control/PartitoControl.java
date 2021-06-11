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

import model.*;
import utils.Utility;

@WebServlet("/Partito")
public class PartitoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nome = request.getParameter("nome");
		
		if (nome == null) {
		 	response.sendRedirect(response.encodeRedirectURL("./PartitiControl"));
		 	return;
		}
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS partitoModel = new PartitoModelDS(ds);
        CandidatoModelDS candidatoModel = new CandidatoModelDS(ds);
		
		try {
			PartitoBean partito = partitoModel.doRetrieveByKey(nome);
			request.setAttribute("partito", partito); 
			
			Collection<CandidatoBean> candidati = candidatoModel.doRetrieveByPartito(nome, "cognome");
			request.setAttribute("candidati", candidati);
		} catch (SQLException e) {
			Utility.printSQLException(e);
		}
		
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/partito.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

