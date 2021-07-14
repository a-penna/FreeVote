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

import model.ComuneBean;
import model.ComuneModelDS;
import utils.Utility;

@WebServlet("/Elettore")
public class LoginElettoreControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("AdminRoles")!= null) {
				response.sendRedirect(response.encodeRedirectURL("/FreeVote/loginElettore.jsp"));
	 			return;
			}
			
			if (request.getSession(false) != null && request.getSession(false).getAttribute("ElettoreRoles")!= null) {
				response.sendRedirect(response.encodeRedirectURL("/FreeVote/elettore/schedaVoto.jsp"));
	 			return;
			}
			
			String codice = request.getParameter("codice");
			String password = request.getParameter("password");
            String comune = request.getParameter("comune");
            String age = request.getParameter("eta");
            String sesso = request.getParameter("sesso");
            String cap = request.getParameter("cap");
            boolean error = false;
            int eta = 9000;
            
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			ComuneModelDS comuneModel = new ComuneModelDS(ds);
			try {
				Collection<String> regioni = comuneModel.doRetrieveAllRegioni("nome_regione");
				request.setAttribute("listaRegioni", regioni);
				
				if ( !(codice == null  || password==null || comune==null || age==null || sesso==null || cap==null || codice.equals("") || comune.equals("") || age.equals("") || sesso.equals("") || cap.equals("") || password.equals(""))) {
					try {
						eta = Integer.parseInt(age);
						
						if(eta<18 || eta>120) {
							request.setAttribute("erroreEta", "true");
							error = true;
						}
						if(!Utility.checkCAP(cap)) {
							request.setAttribute("erroreCap", "true");
							error = true;
						}
					} catch (NumberFormatException e) {
						request.setAttribute("erroreEta", "true");
						error = true;
					}
					
					if(error) {
						request.setAttribute("codice", codice);
						request.setAttribute("password", password);
						request.setAttribute("comune", comune);
						request.setAttribute("eta", age);
						request.setAttribute("sesso", sesso);
						request.setAttribute("cap", cap);
						RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginElettore.jsp"));
						dispatcher.forward(request, response);
						return;
					}
					ComuneBean bean = comuneModel.doRetrieveByKey(comune, cap); 
					
					if (bean.getNome().equals("")) {
						response.sendRedirect(response.encodeRedirectURL("/FreeVote/loginElettore.jsp"));
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

						response.sendRedirect(response.encodeRedirectURL("/FreeVote/elettore/schedaVoto.jsp"));
						return;
					}
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
			}
			request.setAttribute("erroreNome", "true");
			request.setAttribute("errorePass", "true");
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginElettore.jsp"));
			dispatcher.forward(request, response);
	}	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
