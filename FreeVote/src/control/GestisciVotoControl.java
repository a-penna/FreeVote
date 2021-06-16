package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.ElettoreBean;
import model.ElettoreModelDS;
import model.VotazionePoliticaBean;
import model.VotazionePoliticaModelDS;
import utils.Utility;

/**
 * Servlet implementation class GestisciVoto
 */
@WebServlet("/GestisciVoto")
public class GestisciVotoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestisciVotoControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Empty
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;

			if(!loggedIn) {
				response.sendRedirect(response.encodeRedirectURL("/FreeVote/elettore/loginElettore.jsp"));
 				return;
			}
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			VotazionePoliticaModelDS modelVotazione = new VotazionePoliticaModelDS(ds);
			ElettoreModelDS modelElettore = new ElettoreModelDS(ds);
			String redirectedPage = "";
			try {
				VotazionePoliticaBean voto = new VotazionePoliticaBean();
				voto.setCodice(0);
				voto.setData(Utility.toSqlDate(new Date()));
				voto.setElettore((String) request.getSession().getAttribute( "codice"));
				voto.setPartito(request.getParameter("partitoScelto"));

				ElettoreBean elettore = new ElettoreBean();
				elettore.setCap((String) request.getSession().getAttribute("CAP"));
				elettore.setCodice((String) request.getSession().getAttribute("codice"));
				elettore.setComune((String) request.getSession().getAttribute("comune"));
				elettore.setEta((Integer) (request.getSession().getAttribute("eta")));
				elettore.setPassword((String) request.getSession().getAttribute("password"));
				elettore.setSesso((String) request.getSession().getAttribute("sesso"));

				if (modelVotazione.doSaveCheck(voto, elettore)) {
					redirectedPage = "/elettore/successo.jsp";
				} else {
					redirectedPage = "/error/generic.jsp";
				}
			
			} catch(SQLException e) {
				Utility.printSQLException(e);
			}
			
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
	}

}
