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

@WebServlet("/EliminazioneElettore")
public class EliminaElettoreControl extends HttpServlet {
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
		
		String codice = request.getParameter("codice");
		if (codice == null) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/eliminaElettore.jsp"));
			return;
		}
		codice = Utility.encryptMD5(codice.trim());
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		ElettoreModelDS model = new ElettoreModelDS(ds);	

		try {
			ElettoreBean bean = model.doRetrieveByKey(codice);
			boolean flag = model.doDeleteCheck(bean);
			
		    if(flag) {
		    	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
				return;
		    } else {
		    	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/deleteError.jsp"));
				return;
		    }
		} catch(SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		}
	}
}


