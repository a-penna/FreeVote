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
import model.ElettoreModelDS;
import utils.Utility;
 

@WebServlet("/Elettore")
public class LoginElettoreControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			ComuneModelDS comuneModel = new ComuneModelDS(ds);

			if (request.getAttribute("listaComuni") == null) {
				try {
					Collection<ComuneBean> comuni = comuneModel.doRetrieveAll("nome");
					request.setAttribute("listaComuni", comuni);
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/loginElettore.jsp"));
					dispatcher.forward(request, response);
				} catch(SQLException e) {
					Utility.printSQLException(e);
				}
			}
			
			String codice = request.getParameter("codice");
			String password = request.getParameter("password");
            String regione = request.getParameter("regione");
            String comune = request.getParameter("comune");
            int eta = Integer.parseInt(request.getParameter("eta"));
            String sesso = request.getParameter("sesso");
            String cap = request.getParameter("CAP");
			
			if (codice == null) {
			 	response.sendRedirect(response.encodeRedirectURL("./loginElettore.jsp"));
			 	return;
			}

            ElettoreModelDS elettoreModel = new ElettoreModelDS(ds);		
			String redirectedPage = "";

			try {
				ComuneBean bean = comuneModel.doRetrieveByKey(comune, cap); 

                if (bean.getNome().equals("")) {
                    response.sendRedirect(response.encodeRedirectURL("./loginElettore.jsp"));
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

                    redirectedPage = "/elettore/schedaVoto.jsp";
				} else {
					redirectedPage = "/loginElettore.jsp";
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
			}
			response.sendRedirect(request.getContextPath() + redirectedPage);
	}	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
