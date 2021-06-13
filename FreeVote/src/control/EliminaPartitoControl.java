package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.CoalizioneBean;
import model.CoalizioneModelDS;
import model.PartitoBean;
import model.PartitoModelDS;
import utils.Utility;

/**
 * Servlet implementation class EliminaPartito
 */
@WebServlet("/EliminaPartito")
public class EliminaPartitoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS model = new PartitoModelDS(ds);	
		CoalizioneModelDS coalizioneModel = new CoalizioneModelDS(ds);	
		String nome = request.getParameter("nome");
		
		if (nome == null) {
		 	response.sendRedirect(response.encodeRedirectURL("./eliminaPartito.jsp"));
		 	return;
		}
		
		String redirectedPage = "";

		try {
			PartitoBean partito = new PartitoBean();
            partito.setNome(nome);
			CoalizioneBean coalizione = coalizioneModel.doRetrieveByPartito(nome);
			if (!coalizione.getNome().equals("")) { //se il partito appartiene ad una coalizione
				Collection<PartitoBean> partitiDiCoalizione = model.doRetrieveAllByCoalizione(partito); //prendiamo tutti i partiti coalizzati con il partito
				if (partitiDiCoalizione.size() <= 2) 
					coalizioneModel.doDelete(coalizione);
			} 
			boolean flag = model.doDeleteCheck(partito);

		    if(flag) {
		    	redirectedPage="/admin/successoEliminazione.jsp";
		    } else redirectedPage="/error/generic.jsp";
			
		} catch(SQLException e) {
			System.out.println(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
	}

}

