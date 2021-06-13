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

/**
 * Servlet implementation class EliminaElettore
 */
@WebServlet("/EliminazioneElettore")
public class EliminaElettoreControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaElettoreControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		ElettoreModelDS model = new ElettoreModelDS(ds);	
		VotazionePoliticaModelDS votazioneModel = new VotazionePoliticaModelDS(ds);	
		PartitoModelDS partitoModel = new PartitoModelDS(ds);	
		String codice = Utility.encryptMD5(request.getParameter("codice"));
		
		if (codice == null) {
		 	response.sendRedirect(response.encodeRedirectURL("./eliminaElettore.jsp"));
		 	return;
		}
		
		String redirectedPage = "";

		try {
			ElettoreBean bean = model.doRetrieveByKey(codice);
			VotazionePoliticaBean voto = votazioneModel.doRetrieveByElettore(bean.getCodice());
			PartitoBean partito = partitoModel.doRetrieveByKey(voto.getPartito());
			int updated = partito.getn_votazioni_ricevute() - 1;
			partito.setn_votazioni_ricevute(updated);
			partitoModel.doUpdate(partito);
			boolean flag = model.doDeleteCheck(bean);
			
		    if(flag) {
		    	redirectedPage="/admin/successoEliminazione.jsp";
		    } else redirectedPage="/error/generic.jsp";
			
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
		}
		
		
		
		
	

}
