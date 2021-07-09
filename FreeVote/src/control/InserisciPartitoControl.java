package control;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import model.*;
import utils.Utility;

@MultipartConfig(maxFileSize = 16177215)
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
		String descrizione = request.getParameter("descrizione");
		String nomeLeader = request.getParameter("nomeLeader");
		String cognomeLeader = request.getParameter("cognomeLeader");
		String cf = request.getParameter("cf");
		String curriculum = request.getParameter("curriculum");
		if (nome == null || descrizione == null || nomeLeader == null || cognomeLeader == null || cf == null || curriculum == null) {
			response.sendRedirect(response.encodeRedirectURL("/FreeVote/admin/inserisciPartito.jsp"));
			return;
		}
		nome = Utility.filter(nome);
		descrizione = Utility.filter(descrizione);
		nomeLeader = Utility.filter(nomeLeader);
		cognomeLeader = Utility.filter(cognomeLeader);
        curriculum = Utility.filter(curriculum);
		
		InputStream streamLogo = null; 
		
		Part filePart = request.getPart("logo");
		if (filePart != null) {
			streamLogo = filePart.getInputStream();
		}
		
		InputStream streamFoto = null; 
		
		filePart = request.getPart("foto");
		if (filePart != null) {
			streamFoto = filePart.getInputStream();
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
			partito.setLogo(streamLogo.readAllBytes());
			
			CandidatoBean candidato = new CandidatoBean();
			candidato.setNome(nomeLeader);
			candidato.setCognome(cognomeLeader);
			candidato.setCf(cf);
			candidato.setCurriculum(curriculum);
			candidato.setPartito(nome);
			candidato.setFoto(streamFoto.readAllBytes());

			boolean flag = model.doSaveCheck(partito, candidato);
		    if(flag) {
		    	redirectedPage="/successo.jsp";
		    } else {
		    	redirectedPage="/error/insertError.jsp";
		    }
		} catch(SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/insertError.jsp"));
			return;
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
	}
}


