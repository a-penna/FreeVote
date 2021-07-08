package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.ElettoreBean;
import model.PartitoBean;
import model.PartitoModelDS;
import model.SchedaVoto;
import model.VotazionePoliticaBean;
import model.VotazionePoliticaModelDS;
import model.VotazioneReferendumBean;
import utils.Utility;

@WebServlet("/GestisciVoto")
public class GestisciVotoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;

			if(!loggedIn) {
				response.sendRedirect(response.encodeRedirectURL("/FreeVote/elettore/loginElettore.jsp"));
 				return;
			}

			SchedaVoto scheda = (SchedaVoto) request.getSession().getAttribute("scheda");
			if (scheda == null) {
				scheda = new SchedaVoto();
				request.getSession().setAttribute("scheda", scheda);
			}
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			String action = request.getParameter("action");
			try {
				if (action != null) {
					if (action.equals("vota")) {
						VotazionePoliticaBean vp = scheda.getVP();
						VotazioneReferendumBean vr = scheda.getVR();
						ElettoreBean elettore = new ElettoreBean();
						elettore.setCap((String) request.getSession().getAttribute("CAP"));
						elettore.setCodice(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						elettore.setComune((String) request.getSession().getAttribute("comune"));
						elettore.setEta((Integer) (request.getSession().getAttribute("eta")));
						elettore.setPassword(Utility.encryptMD5((String) request.getSession().getAttribute("password")));
						elettore.setSesso((String) request.getSession().getAttribute("sesso"));
						VotazionePoliticaModelDS modelVotazione = new VotazionePoliticaModelDS(ds);
						if (vp == null) {
							vp = new VotazionePoliticaBean();
							vp.setCodice(0);
							vp.setData(Utility.toSqlDate(new Date()));
							vp.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
							vp.setPartito("Scheda Bianca");
						}
						if (vr == null) {
							vr = new VotazioneReferendumBean();
							vr.setCodice(0);
							vr.setData(Utility.toSqlDate(new Date()));
							vr.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
							vr.setPreferenza("Mi Astengo");
						}
						
						if (modelVotazione.doSaveBoth(vp, vr, elettore, (String) request.getSession().getAttribute("codice"), (String) request.getSession().getAttribute("password"))) {
							request.getSession().invalidate();
							response.sendRedirect(response.encodeRedirectURL("/FreeVote/successo.jsp"));
	 						return;
						} else {
							request.getSession().invalidate();
							response.sendRedirect(response.encodeRedirectURL("/FreeVote/error/generic.jsp"));
	 						return;
						}
					} 
					else if (action.equals("aggiornaPartito")) {
						VotazionePoliticaBean voto = new VotazionePoliticaBean();
						voto.setCodice(0);
						voto.setData(Utility.toSqlDate(new Date()));
						voto.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						voto.setPartito(request.getParameter("partitoScelto"));
						scheda.addVP(voto);
					} 
					else if (action.equals("aggiornaPreferenza")) {
						VotazioneReferendumBean voto = new VotazioneReferendumBean();
						voto.setCodice(0);
						voto.setData(Utility.toSqlDate(new Date()));
						voto.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						voto.setPreferenza(request.getParameter("preferenza"));
						scheda.addVR(voto);
					}
					else if (action.equals("clear")) {
						scheda.deleteVP();
						scheda.deleteVR();
					} 
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
			}
			
			request.setAttribute("scheda", scheda);
			PartitoModelDS model = new PartitoModelDS(ds);

			try {
				Collection<PartitoBean> partiti = model.doRetrieveAll("nome");
				request.setAttribute("partiti", partiti);
				if(partiti == null) {
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/FreeVote/error/generic.jsp"));
					dispatcher.forward(request, response);
					return;
				}
			} catch (SQLException e) {
				Utility.printSQLException(e);
			}
			
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/elettore/schedaVoto.jsp"));
			dispatcher.forward(request, response);
			
	}

}

