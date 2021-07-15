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

@WebServlet("/InserisciCoalizione")
public class InserisciCoalizioneControl extends HttpServlet{
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
    	
    	String nome = request.getParameter("nomeCoalizione");
    	String[] partiti = request.getParameterValues("nomePartito");
    	
    	if(nome == null || partiti == null) {
    		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/inserisciCoalizione.jsp"));
			return;
    	}
    	
    	if(nome.equals("")) {
    		request.setAttribute("error", "true");
    		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/inserisciCoalizione.jsp"));
    		dispatcher.forward(request, response);
    		return;
    	}

    	for(int i = 0; i < partiti.length; i++) {
    		if(partiti[i].equals("")) {
    			request.setAttribute("error", "true");
    			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/inserisciCoalizione.jsp"));
    			dispatcher.forward(request, response);
    			return;
    		}
    	}
    	
    	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
    	CoalizioneModelDS model = new CoalizioneModelDS(ds);
    	
    	try{
    		CoalizioneBean bean = new CoalizioneBean();
    		bean.setNome(nome);
    		
    		boolean flag = model.doSaveCheck(bean, partiti);
    		if(flag) {
    			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
    			return; 
    		} else {
    			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/insertError.jsp"));
    			return;
    		}
    	} catch(SQLException e) {
    		Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
    	}
    }
}
