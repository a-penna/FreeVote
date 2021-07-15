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
import utils.*;
 
@WebServlet("/Administrator")
public class LoginAdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp"));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/interfacciaAdmin.jsp"));
				return;
			}
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp"));
				return;
			}
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		    AdminModelDS model = new AdminModelDS(ds);		
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			if (username == null || password == null) {
			 	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp"));
			 	return;
			}
			
			try {
				AdminBean bean = model.doRetrieveByKey(username); 
			
				if (bean.isEmpty()) {
					request.setAttribute("erroreUser", "true");
					request.setAttribute("errorePass", "true");
					username = Utility.filter(username);
					password = Utility.filter(password);
					request.setAttribute("username", username);
					request.setAttribute("password", password);
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginAdmin.jsp"));
					dispatcher.forward(request, response);
					return;
				}
		
				if (bean.getPassword().equals(Utility.encryptMD5(password))) {
					request.getSession().setAttribute("adminRoles", "true");
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/interfacciaAdmin.jsp"));
					return;
				} else {
					request.setAttribute("errorePass", "true");
					username = Utility.filter(username);
					password = Utility.filter(password);
					request.setAttribute("username", username);
					request.setAttribute("password", password);
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginAdmin.jsp"));
					dispatcher.forward(request, response);
					return;
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
				return;
			}
	}	

}
