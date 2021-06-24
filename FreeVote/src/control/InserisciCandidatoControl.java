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
@WebServlet("/InserisciCandidato")
public class InserisciCandidatoControl extends HttpServlet {
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
		
		String nome = Utility.filter(request.getParameter("nome"));
		String cognome = Utility.filter(request.getParameter("cognome"));
		String cf = request.getParameter("cf");
		String curriculum = Utility.filter(request.getParameter("curriculum"));
        String partito = Utility.filter(request.getParameter("partito"));
        
		if (nome == null || cognome == null || cf == null || curriculum == null || partito == null) {
			response.sendRedirect(response.encodeRedirectURL("/FreeVote/admin/inserisciCandidato.jsp"));
			return;
		}
		
		InputStream streamFoto = null; 
		
		Part filePart = request.getPart("foto");
		if (filePart != null) {
			streamFoto = filePart.getInputStream();
		}

		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		CandidatoModelDS model = new CandidatoModelDS(ds);
		
		String redirectedPage = "";

		try {
			CandidatoBean candidato = new CandidatoBean();
			candidato.setNome(nome);
			candidato.setCognome(cognome);
			candidato.setCf(cf);
			candidato.setCurriculum(curriculum);
			candidato.setPartito(partito);
			candidato.setFoto(streamFoto.readAllBytes());

			boolean flag = model.doSaveCheck(candidato);
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


