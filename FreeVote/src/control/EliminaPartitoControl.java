package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.PartitoBean;
import model.PartitoModelDS;
import utils.Utility;

@WebServlet("/EliminaPartito")
public class EliminaPartitoControl extends HttpServlet {
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
		
		String nome = request.getParameter("nome");
		if (nome == null) {
			response.sendRedirect(response.encodeRedirectURL("./eliminaPartito.jsp"));
			return;
		}
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS model = new PartitoModelDS(ds);	
		
		String redirectedPage = "";

		try {
			PartitoBean partito = new PartitoBean();
            partito.setNome(nome);

            boolean flag = model.doDeleteCheck(partito);

		    if(flag) {
		    	redirectedPage="/admin/successoEliminazione.jsp";
		    } else redirectedPage="/error/generic.jsp";
			
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
	}

}

