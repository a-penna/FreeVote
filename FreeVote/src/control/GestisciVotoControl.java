package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.ElettoreBean;
import model.VotazionePoliticaBean;
import model.VotazionePoliticaModelDS;
import model.VotazioneReferendumBean;
import model.VotazioneReferendumModelDS;
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
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			String redirectedPage = "";

			String[] selected = request.getParameterValues("type[]");
			List tipo = Arrays.asList(selected);
			if(tipo.contains("politica") && tipo.contains("referendum")) {
				VotazionePoliticaModelDS modelVotazione = new VotazionePoliticaModelDS(ds);
				try {
					VotazionePoliticaBean voto = new VotazionePoliticaBean();
					voto.setCodice(0);
					voto.setData(Utility.toSqlDate(new Date()));
					voto.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
					voto.setPartito(request.getParameter("partitoScelto"));

					VotazioneReferendumBean votoReferendum = new VotazioneReferendumBean();
					votoReferendum.setCodice(0);
					votoReferendum.setData(Utility.toSqlDate(new Date()));
					votoReferendum.setPreferenza(request.getParameter("preferenza"));
					votoReferendum.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));

					ElettoreBean elettore = new ElettoreBean();
					elettore.setCap((String) request.getSession().getAttribute("CAP"));
					elettore.setCodice(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
					elettore.setComune((String) request.getSession().getAttribute("comune"));
					elettore.setEta((Integer) (request.getSession().getAttribute("eta")));
					elettore.setPassword(Utility.encryptMD5((String) request.getSession().getAttribute("password")));
					elettore.setSesso((String) request.getSession().getAttribute("sesso"));

					if (modelVotazione.doSaveBoth(voto, votoReferendum, elettore,(String) request.getSession().getAttribute("codice"), (String) request.getSession().getAttribute("password"))) {
						redirectedPage = "/successo.jsp";
						request.getSession().invalidate();
					} else {
						redirectedPage = "/error/generic.jsp";
					}
				} catch(SQLException e) {
					Utility.printSQLException(e);
				}

			} else if(tipo.contains("politica") && !tipo.contains("referendum")){
					VotazionePoliticaModelDS modelVotazione = new VotazionePoliticaModelDS(ds);
					try {
						VotazionePoliticaBean voto = new VotazionePoliticaBean();
						voto.setCodice(0);
						voto.setData(Utility.toSqlDate(new Date()));
						voto.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						voto.setPartito(request.getParameter("partitoScelto"));

						ElettoreBean elettore = new ElettoreBean();
						elettore.setCap((String) request.getSession().getAttribute("CAP"));
						elettore.setCodice(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						elettore.setComune((String) request.getSession().getAttribute("comune"));
						elettore.setEta((Integer) (request.getSession().getAttribute("eta")));
						elettore.setPassword(Utility.encryptMD5((String) request.getSession().getAttribute("password")));
						elettore.setSesso((String) request.getSession().getAttribute("sesso"));

						if (modelVotazione.doSaveCheck(voto, elettore, (String) request.getSession().getAttribute("codice"), (String) request.getSession().getAttribute("password"))) {
							redirectedPage = "/successo.jsp";
							request.getSession().invalidate();
						} else {
							redirectedPage = "/error/generic.jsp";
						}
					} catch(SQLException e) {
						Utility.printSQLException(e);
					}
			} else if(!tipo.contains("politica") && tipo.contains("referendum")) {
					VotazioneReferendumModelDS modelReferendum = new VotazioneReferendumModelDS(ds);
					try {
						VotazioneReferendumBean votoReferendum = new VotazioneReferendumBean();					
						votoReferendum.setCodice(0);
						votoReferendum.setData(Utility.toSqlDate(new Date()));
						votoReferendum.setElettore(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						votoReferendum.setPreferenza(request.getParameter("preferenza"));

						ElettoreBean elettore = new ElettoreBean();
						elettore.setCap((String) request.getSession().getAttribute("CAP"));
						elettore.setCodice(Utility.encryptMD5((String) request.getSession().getAttribute("codice")));
						elettore.setComune((String) request.getSession().getAttribute("comune"));
						elettore.setEta((Integer) (request.getSession().getAttribute("eta")));
						elettore.setPassword(Utility.encryptMD5((String) request.getSession().getAttribute("password")));
						elettore.setSesso((String) request.getSession().getAttribute("sesso"));
						if (modelReferendum.doSaveCheck(votoReferendum, elettore,(String) request.getSession().getAttribute("codice"), (String) request.getSession().getAttribute("password"))) {
							redirectedPage = "/successo.jsp";
							request.getSession().invalidate();
						} else {
							redirectedPage = "/error/generic.jsp";
						}
                    } catch(SQLException e) {
						Utility.printSQLException(e);
					}
				} else if(!tipo.contains("politica") && !tipo.contains("referendum")) {
						redirectedPage="/elettore/schedaVoto.jsp";
				}
			
		
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
	}

}
