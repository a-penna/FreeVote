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

		boolean loggedIn = request.getSession() != null && request.getSession().getAttribute("adminRoles")!= null;
		if(!loggedIn) {
			response.sendRedirect(request.getContextPath() + "/loginAdmin.jsp");
			return;
		}
		
		String codice = request.getParameter("codice");
		if (codice == null) {
			response.sendRedirect(response.encodeRedirectURL("/admin/eliminaElettore.jsp"));
			return;
		}
		codice = Utility.encryptMD5(request.getParameter("codice"));
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		ElettoreModelDS model = new ElettoreModelDS(ds);	
		
		String redirectedPage = "";

		try {
			ElettoreBean bean = model.doRetrieveByKey(codice);

			boolean flag = model.doDeleteCheck(bean);
			
		    if(flag) {
		    	redirectedPage="/admin/successoEliminazione.jsp";
		    } else {
		    	redirectedPage="/error/generic.jsp";
		    }
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
		}
}


