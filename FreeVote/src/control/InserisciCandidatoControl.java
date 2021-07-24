package control;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
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

@WebServlet("/InserisciCandidato")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB dimensione dopo la quale il file sarà temporaneamente spostato su disco
				maxFileSize = 1024 * 1024 * 10) // 10MB dimensione massima permessa per i file caricati
public class InserisciCandidatoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
		if(!loggedIn) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp"));
			return;
		}
		
		request.setCharacterEncoding("UTF-8"); //metodo per evitare problemi con accenti, setta l'encoding utf-8
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String cf = request.getParameter("cf");
		String curriculum = request.getParameter("curriculum");
        String partito = request.getParameter("partito");
        
        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        PartitoModelDS modelPartito = new PartitoModelDS(ds); 
        try {
        	Collection<PartitoBean> partiti = modelPartito.doRetrieveAll("nome");
			request.setAttribute("listaPartiti", partiti);
		} catch (SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		} 
        
        if (nome == null || cognome == null || cf == null || curriculum == null || partito == null) {
        	RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/inserisciCandidato.jsp"));
			dispatcher.forward(request, response);
			return;
        }
        
        nome = nome.trim();  //Rimuove gli spazi all'inizio e alla fine di una stringa
        cognome = cognome.trim();
        cf = cf.trim();
        curriculum = curriculum.trim();
        partito = partito.trim();
        
        boolean error = false;

        if (!Utility.checkNomeCognome(nome)) {
			request.setAttribute("erroreNome", "true");
			error = true;
		}
		if (!Utility.checkNomeCognome(cognome)) {
			request.setAttribute("erroreCognome", "true");
			error = true;
		}
		if (!Utility.checkCf(cf)) {
			request.setAttribute("erroreCf", "true");
			error = true;
		}
		if (curriculum.equals("")) {
			request.setAttribute("erroreCurriculum", "true");
			error = true;
		}
		
		nome = Utility.filter(nome);
		cognome = Utility.filter(cognome);
		cf = Utility.filter(cf);
		curriculum = Utility.filter(curriculum);
		partito = Utility.filter(partito);
		
		if(error) {
			request.setAttribute("nome", nome);
			request.setAttribute("cognome", cognome);
			request.setAttribute("cf", cf);
			request.setAttribute("curriculum", curriculum);
			request.setAttribute("partito", partito);
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/inserisciCandidato.jsp"));
			dispatcher.forward(request, response);
			return;
		}
		
		cf = Utility.encryptMD5(request.getParameter("cf"));
        
		InputStream streamFoto = null; 
		
		Part filePart = request.getPart("foto"); //usiamo la classe Part ed il suo metodo getPart per ottenere la foto trasferita
		if (filePart != null) { 
			streamFoto = filePart.getInputStream();
		}
		
		CandidatoModelDS model = new CandidatoModelDS(ds);
		
		try {
			CandidatoBean candidato = new CandidatoBean();
			candidato.setNome(nome);
			candidato.setCognome(cognome);
			candidato.setCf(cf);
			candidato.setCurriculum(curriculum);
			candidato.setPartito(partito);
			candidato.setFoto(streamFoto.readAllBytes()); //readallbytes permette di ottenere un array di bytes dall'inputstream

			boolean flag = model.doSaveCheck(candidato);
			if(flag) {
    			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
    			return; 
    		} else {
    			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/insertError.jsp"));
    			return;
    		}
		    
		} catch(SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/insertError.jsp"));
			return;
		}
	}
}


