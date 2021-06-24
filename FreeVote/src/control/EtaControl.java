package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.*;
import utils.Utility;

@WebServlet("/EtaControl")
public class EtaControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		PartitoModelDS partitoModel = new PartitoModelDS(ds);
		VotazionePoliticaModelDS votazioneModel  = new VotazionePoliticaModelDS(ds);
		ElettoreModelDS elettoreModel  = new ElettoreModelDS(ds);
		
        String partito = request.getParameter("partito");
		
		try {
			Collection<PartitoBean> partiti = partitoModel.doRetrieveAll("nome");
			request.setAttribute("partiti", partiti);
			if (partito != null && !request.getParameter("minima").equals("") && !request.getParameter("massima").equals("")) {
				int min = Integer.parseInt(request.getParameter("minima"));
				int max = Integer.parseInt(request.getParameter("massima"));
				if (min > max) {
					int temp = min;
					min = max;
					max = temp;
				}
				if (!partitoModel.doRetrieveByKey(partito).isEmpty()) {
					Collection<VotazionePoliticaBean> voti = votazioneModel.doRetrieveAllByPartito(partito);
					int n = 0;
					Iterator<VotazionePoliticaBean> it = voti.iterator();
		            while(it.hasNext()) {
		                VotazionePoliticaBean votazione = (VotazionePoliticaBean)it.next();   
		                ElettoreBean elettore = elettoreModel.doRetrieveByKey(votazione.getElettore());
		                if(elettore.getEta() <= max && elettore.getEta() >= min) {
		                	n++;
		                }
		            }
					if(voti.size() != 0) {
						request.setAttribute("percentuale", "" + n*100/voti.size());
					} else {
						request.setAttribute("percentuale", "0");
					}
					request.setAttribute("minima", String.valueOf(min));
					request.setAttribute("massima", String.valueOf(max));
					request.setAttribute("partito", partito);
					
				}                                    
			}                                                                                                                             
		} catch (SQLException e) {
			Utility.printSQLException(e);
		}


		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiPerEta.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
