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
import utils.*;
 

@WebServlet("/Administrator")
public class LoginAdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginAdminControl() {
		super();
	}	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		    AdminModelDS model = new AdminModelDS(ds);		
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			if (username == null) {
			 	response.sendRedirect(response.encodeRedirectURL("./loginAdmin.jsp"));
			 	return;
			}
			
			String redirectedPage = "";

			try {
				AdminBean bean = model.doRetrieveByKey(username); 
			
				if (bean.getnomeUtente().equals("")) {
					response.sendRedirect(response.encodeRedirectURL("./loginAdmin.jsp"));
					return;
				}
		
				if (bean.getPassword().equals(Utility.encryptMD5(password))) {
					request.getSession().setAttribute("adminRoles", "true");
					redirectedPage = "/admin/interfacciaAdmin.jsp";
				} else {
					redirectedPage = "/loginAdmin.jsp";
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
			}
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
	}	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
