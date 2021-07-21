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

@WebServlet("/InserisciPartitoCoalizione")
public class InserisciPartitoCoalizioneControl extends HttpServlet {
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
		
		String partito = request.getParameter("nome");
		String coalizione = request.getParameter("coalizione");
         
		if (partito == null || coalizione == null) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/inserisciPartitoCoalizione.jsp"));
			return;
		};
		
		partito = partito.trim();
		coalizione = coalizione.trim();
		
        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		AppartieneModelDS model = new AppartieneModelDS(ds);

		try {
            AppartieneBean appartiene = new AppartieneBean();
            appartiene.setPartito(partito);
            appartiene.setCoalizione(coalizione);
            
			boolean flag = model.doSaveCheck(appartiene);
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

