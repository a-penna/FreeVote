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

import model.*;
import utils.Utility;

@WebServlet("/Statistiche")
public class StatisticheControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		VotazionePoliticaModelDS modelPol = new VotazionePoliticaModelDS(ds);
		VotazioneReferendumModelDS modelRef = new VotazioneReferendumModelDS(ds);
		
		try {
			int nVotantiPol = modelPol.doRetrieveNVotanti();
			if (nVotantiPol == -1) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp")); 
			 	return;
			} else {
				request.setAttribute("nVotantiPol", "" + nVotantiPol);
			}
			
			int nBianche = modelPol.doRetrieveNSchedeBianche();
			if (nBianche == -1) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp")); 
			 	return;
			} else {
				request.setAttribute("nBianche", "" + nBianche);
			}
			
			int nVotantiRef = modelRef.doRetrieveNVotanti();
			if (nVotantiRef == -1) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp")); 
			 	return;
			} else {
				request.setAttribute("nVotantiRef", "" + nVotantiRef);
			}
			
			int nAstenuti = modelRef.doRetrieveNAstenuti();
			if (nAstenuti == -1) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp")); 
			 	return;
			} else {
				request.setAttribute("nAstenuti", "" + nAstenuti);
			}
			
			int nonVotanti = modelRef.doRetrieveNNonVotanti();
			if (nonVotanti == -1) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp")); 
			 	return;
			} else {
				request.setAttribute("nonVotanti", "" + nonVotanti);
			}
			
			Collection<String> affluenza = modelPol.doRetrieveAffluenza();
			request.setAttribute("affluenza", affluenza);
		
		} catch (SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		}

		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/statisticheLive.jsp"));
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
