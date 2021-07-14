package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.*;
import utils.Utility;

@WebServlet("/Elettore")
public class LoginElettoreControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginElettore.jsp"));
	 			return;
			}
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/elettore/schedaVoto.jsp"));
	 			return;
			}

			String codice = request.getParameter("codice");
			String password = request.getParameter("password");
            String comune = request.getParameter("comune");
            String age = request.getParameter("eta");
            String sesso = request.getParameter("sesso");
            String cap = request.getParameter("cap");
            
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			ComuneModelDS comuneModel = new ComuneModelDS(ds);
			
			try {
				Collection<String> regioni = comuneModel.doRetrieveAllRegioni("nome_regione");
				request.setAttribute("listaRegioni", regioni);
			} catch (SQLException e) {
				Utility.printSQLException(e);
			} 
			
			if (codice == null  || password == null || comune == null || age == null || sesso == null || cap == null) {
				RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginElettore.jsp"));
				dispatcher.forward(request, response);
				return;
			}
			
			if (!sesso.equals("M") && !sesso.equals("F")) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/loginElettore.jsp"));
	 			return;
			}
			
			boolean error = false;
			
			int eta = Utility.checkEta(age);
			if (eta == -1) {
				request.setAttribute("erroreEta", "true");
				request.setAttribute("error", "true");
				error = true;
			}

			try {
				ComuneBean bean = comuneModel.doRetrieveByKey(comune, cap); 
					
				if (bean.isEmpty()) {
					request.setAttribute("erroreCap", "true");
					request.setAttribute("error", "true");
					error = true;
				}
				
				if (error) {
					codice = Utility.filter(codice);
					password = Utility.filter(password);
					age = Utility.filter(age);
					sesso = Utility.filter(sesso);
					cap = Utility.filter(cap);
					request.setAttribute("codice", codice);
					request.setAttribute("password", password);
					request.setAttribute("eta", age);
					request.setAttribute("sesso", sesso);
					request.setAttribute("cap", cap);
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginElettore.jsp"));
					dispatcher.forward(request, response);
					return;
				}

				String lista = bean.getListaCodiciPassword();
				if (lista.contains(Utility.encryptMD5(codice+","+password))) {
					request.getSession().setAttribute("elettoreRoles", "true");
					request.getSession().setAttribute("codice", codice);
					request.getSession().setAttribute("password", password);
					request.getSession().setAttribute("comune", comune);
					request.getSession().setAttribute("eta", eta);
					request.getSession().setAttribute("sesso", sesso);
					request.getSession().setAttribute("CAP", cap);

					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/elettore/schedaVoto.jsp"));
					return;
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
			}
			request.setAttribute("erroreCredenziali", "true");
			request.setAttribute("error", "true");
			
			codice = Utility.filter(codice);
			password = Utility.filter(password);
			age = Utility.filter(age);
			sesso = Utility.filter(sesso);
			cap = Utility.filter(cap);
			request.setAttribute("codice", codice);
			request.setAttribute("password", password);
			request.setAttribute("eta", age);
			request.setAttribute("sesso", sesso);
			request.setAttribute("cap", cap);
			
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginElettore.jsp"));
			dispatcher.forward(request, response);
	}	

}
