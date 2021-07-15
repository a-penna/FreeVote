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
		
		try {
			Collection<PartitoBean> partiti = partitoModel.doRetrieveAll("nome");
			request.setAttribute("partiti", partiti);
		} catch (SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		} 
  
		String partito = request.getParameter("partito");
		String minima = request.getParameter("minima");
		String massima = request.getParameter("massima");
		
		if (partito == null || minima== null || massima == null) {
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiPerEta.jsp"));
			dispatcher.forward(request, response);
			return;
		}
		
		minima = Utility.filter(minima);
		massima = Utility.filter(massima);
		partito = Utility.filter(partito);
		
		boolean error = false;

		int min = Utility.checkEta(minima);
		int max = Utility.checkEta(massima);

		if (min == -1) {
			request.setAttribute("erroreEtaMin", "true");
			error = true;
		}
		
		if (max == -1) {
			request.setAttribute("erroreEtaMax", "true");
			error = true;
		}
		
		if (!error && min > max) {
			int temp = min;
			min = max;
			max = temp;
		}

		try {	
			if (partitoModel.doRetrieveByKey(partito).isEmpty()) {
				request.setAttribute("errorePartito", "true");
				error = true;
			} else if(!error){
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
			}                                   
		} catch (SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		} 
		
		if (error) {
			request.setAttribute("min", minima);
			request.setAttribute("max", massima);
		} else {
			request.setAttribute("min", "" + min);
			request.setAttribute("max", "" + max);
		}	
		request.setAttribute("partito", partito);       

		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiPerEta.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
