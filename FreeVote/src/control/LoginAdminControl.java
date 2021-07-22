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
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp")); //Non permettiamo di utilizzare la doget per non passare parametri in chiaro
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null) { //se si è già autenticati come admin si rimanda all'interfaccia
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/interfacciaAdmin.jsp"));
				return;
			}
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null) { //se si è già autenticati come elettori rimanda al login
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp"));
				return;
			}
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource"); //prendiamo connessione dal context
		    AdminModelDS model = new AdminModelDS(ds);
			
			String username = request.getParameter("username"); //prendiamo parametri dal form
			String password = request.getParameter("password"); 
			
			if (username == null || password == null) {   
			 	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginAdmin.jsp"));
			 	return;
			}
			
			try {
				AdminBean bean = model.doRetrieveByKey(username); 
			
				if (bean.isEmpty()) { //se non esiste un username nel database settiamo errori per effettuare la validazione lato server
					request.setAttribute("erroreUser", "true");
					request.setAttribute("errorePass", "true");
					username = Utility.filter(username); //per evitare html malevolo immesso da utente
					password = Utility.filter(password);
					request.setAttribute("username", username);
					request.setAttribute("password", password);
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginAdmin.jsp"));
					dispatcher.forward(request, response);
					return;
				}
		
				if (bean.getPassword().equals(Utility.encryptMD5(password))) { //se la password è corretta si procede col login
					request.getSession().setAttribute("adminRoles", "true");
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/interfacciaAdmin.jsp"));
					return;
				} else { //settiamo errori per effettuare la validazione lato server
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
