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

import model.AppartieneBean;
import model.AppartieneModelDS;
import model.CoalizioneModelDS;
import model.PartitoBean;
import model.PartitoModelDS;
import utils.Utility;

@WebServlet("/EliminaPartitoCoalizione")
public class EliminaPartitoCoalizioneControl extends HttpServlet {
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
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS model = new PartitoModelDS(ds);	
        AppartieneModelDS appartieneModel = new AppartieneModelDS(ds);	
        CoalizioneModelDS coalizioneModel = new CoalizioneModelDS(ds);	
		
		try {
            Collection<PartitoBean> partiti = model.doRetrieveAllCoalizzati("nome");
			request.setAttribute("listaPartiti", partiti);
			String nome = request.getParameter("nome");
			if (nome != null) {
                AppartieneBean appartiene = new AppartieneBean();
                appartiene.setPartito(nome);
                appartiene.setCoalizione(coalizioneModel.doRetrieveByPartito(nome).getNome());
			
				boolean flag = appartieneModel.doDeleteCheck(appartiene);
				
				if(flag) {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
					return;
				} else {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/deleteError.jsp"));
					return;
				}
			}
		} catch(SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		}
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/admin/eliminaPartitoCoalizione.jsp"));
		dispatcher.forward(request, response);
	}

}

