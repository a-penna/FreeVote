package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.*;
import utils.Utility;

@WebServlet("/InserisciPartito")
public class InserisciPartitoControl extends HttpServlet {
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
		
		String nome = request.getParameter("nome");
		System.out.println(nome);
		String descrizione = request.getParameter("descrizione");
		System.out.println(descrizione);
		String nomeLeader = request.getParameter("nomeLeader");
		System.out.println(nomeLeader);
		String cognomeLeader = request.getParameter("cognomeLeader");
		System.out.println(cognomeLeader);
		String cf = request.getParameter("cf");
		System.out.println(cf);
		String curriculum = request.getParameter("curriculum");
		System.out.println(curriculum);
		if (nome == null || descrizione == null || nomeLeader == null || cognomeLeader == null || cf == null || curriculum == null) {
			response.sendRedirect(response.encodeRedirectURL("/FreeVote/admin/inserisciPartito.jsp"));
			return;
		}
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS model = new PartitoModelDS(ds);
		
		String redirectedPage = "";

		try {
			PartitoBean partito = new PartitoBean();
			partito.setNome(nome);
			partito.setDescrizione(descrizione);
			partito.setLeader(nomeLeader + " " + cognomeLeader);
			partito.setn_votazioni_ricevute(0);
			//partito.setLogo(null);
			
			CandidatoBean candidato = new CandidatoBean();
			candidato.setNome(nomeLeader);
			candidato.setCognome(cognomeLeader);
			candidato.setCf(cf);
			candidato.setCurriculum(curriculum);
			candidato.setPartito(nome);
			//candidato.setFoto(null);

			boolean flag = model.doSaveCheck(partito, candidato);
			
		    if(flag) {
		    	redirectedPage="/admin/successo.jsp";
		    } else {
		    	redirectedPage="/error/generic.jsp";
		    }
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
		}
}

