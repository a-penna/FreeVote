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

import model.AutoreBean;
import model.MozioneBean;
import model.MozioneModelDS;
import utils.Utility;

@WebServlet("/InserisciMozione")
public class InserisciMozioneControl extends HttpServlet{
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
        
        String nomeCompleto = request.getParameter("nomeCompleto");
        String testo = request.getParameter("testo");
        
        if(nomeCompleto == null || testo == null) {
            response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/inserisciMozione.jsp"));
			return;
        }

        boolean error = false;
        
        if(testo.trim().equals("")) {
        	request.setAttribute("erroreTesto", "true");
			error = true;
        }
        
		if (!Utility.checkNomeCompleto(nomeCompleto)) {
			request.setAttribute("erroreNomeCompleto", "true");
			error = true;
		}
        
		nomeCompleto = Utility.filter(nomeCompleto);
		testo = Utility.filter(testo);

		if(error) {
			request.setAttribute("nomeCompleto", nomeCompleto);
			request.setAttribute("testo", testo);
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/inserisciMozione.jsp"));
			dispatcher.forward(request, response);
			return;
		}
		
        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        MozioneModelDS mozioneModel = new MozioneModelDS(ds);
        
        try{
            AutoreBean autore = new AutoreBean();
            autore.setNomeCompleto(nomeCompleto);
            autore.setID(1);
            MozioneBean mozione = new MozioneBean();
            mozione.setID(1);
            mozione.setTesto(testo);
            boolean flag = mozioneModel.doSaveCheck(mozione, autore);
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
