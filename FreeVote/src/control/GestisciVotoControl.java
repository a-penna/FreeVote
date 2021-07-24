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
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/elettore/loginElettore.jsp"));
 				return;
			}

			SchedaVoto scheda = (SchedaVoto) request.getSession().getAttribute("scheda");
			if (scheda == null) {
				scheda = new SchedaVoto();
				request.getSession().setAttribute("scheda", scheda);
			}
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			String action = request.getParameter("action"); //Utilizziamo il parametro action del form per capire che tipo di operazione effettuiamo sulla scheda voto
			try {
				if (action != null) {
					if (action.equals("vota")) {
						VotazionePoliticaBean vp = scheda.getVP();
						VotazioneReferendumBean vr = scheda.getVR();
						ElettoreBean elettore = new ElettoreBean();
						elettore.setCap((String) request.getSession().getAttribute("CAP")); //prendiamo i dati dell'elettore salvati nella sessione dal login
						elettore.setCodice(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						elettore.setComune((String) request.getSession().getAttribute("comune"));
						elettore.setEta((Integer) (request.getSession().getAttribute("eta")));
						elettore.setPassword(Utility.encryptMD5((String) request.getSession().getAttribute("password")));
						elettore.setSesso((String) request.getSession().getAttribute("sesso"));
						VotazionePoliticaModelDS modelVotazione = new VotazionePoliticaModelDS(ds);
						if (vp == null) { //se l'elettore non ha espresso una preferenza per un partito si considera scheda bianca
							vp = new VotazionePoliticaBean();
							vp.setCodice(0);
							vp.setData(Utility.toSqlDate(new Date()));
							vp.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
							vp.setPartito("Scheda Bianca");
						}
						if (vr == null) {//se l'elettore non ha espresso una preferenza per il referendum si considera astenuto.
							vr = new VotazioneReferendumBean();
							vr.setCodice(0);
							vr.setData(Utility.toSqlDate(new Date()));
							vr.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
							vr.setPreferenza("Mi astengo");
						}
						
						if (modelVotazione.doSaveBoth(vp, vr, elettore, (String) request.getSession().getAttribute("codice"), (String) request.getSession().getAttribute("password"))) {
							request.getSession().invalidate();
							response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/successo.jsp"));
	 						return;
						} else {
							request.getSession().invalidate();
							response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
	 						return;
						}
					} 
					else if (action.equals("aggiornaPartito")) {
						String partito = (String) request.getParameter("partitoScelto"); //prendiamo il partito selezionato
						PartitoModelDS modelPartito = new PartitoModelDS(ds);
						PartitoBean p = modelPartito.doRetrieveByKey(partito); 
						if (!p.isEmpty()) { //se esiste aggiungiamo alla scheda una votazione politica per il partito scelto
							VotazionePoliticaBean voto = new VotazionePoliticaBean();
							voto.setCodice(0);
							voto.setData(Utility.toSqlDate(new Date()));
							voto.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
							voto.setPartito(partito);
							scheda.addVP(voto);
						}
					} 
					else if (action.equals("aggiornaPreferenza")) {
						String preferenza = (String) request.getParameter("preferenza");
						if (preferenza != null && (preferenza.equals("Si") || preferenza.equals("No"))) { //se esiste ed è si/no aggiungiamo alla scheda una votazione per la preferenza scelta
							VotazioneReferendumBean voto = new VotazioneReferendumBean();
							voto.setCodice(0);
							voto.setData(Utility.toSqlDate(new Date()));
							voto.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
							voto.setPreferenza(preferenza);
							scheda.addVR(voto);
						}
					}
					else if (action.equals("clear")) { //reset button
						scheda.deleteVP();
						scheda.deleteVR();
					} 
				}
			} catch(SQLException e) {
				Utility.printSQLException(e);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
				return;
			}
			
			request.setAttribute("scheda", scheda);
			PartitoModelDS model = new PartitoModelDS(ds);

			try {
				Collection<PartitoBean> partiti = model.doRetrieveAll("nome");
				request.setAttribute("partiti", partiti);
				if(partiti == null) {
					RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/error/generic.jsp"));
					dispatcher.forward(request, response);
					return;
				}
			} catch (SQLException e) {
				Utility.printSQLException(e);
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
				return;
			}
			
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/elettore/schedaVoto.jsp"));
			dispatcher.forward(request, response);
			
	}

}

