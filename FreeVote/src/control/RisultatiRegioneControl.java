package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import model.*;
import utils.Utility;

@WebServlet("/RisultatiReg")
public class RisultatiRegioneControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DataSource ds = (DataSource)getServletContext().getAttribute("DataSource");
		ComuneModelDS comuneModel = new ComuneModelDS(ds);
		VotazionePoliticaModelDS votoModel = new VotazionePoliticaModelDS(ds);
		
		try {
			Collection<String> regioni = new LinkedList<String>();
			Collection<ComuneBean> comuni = comuneModel.doRetrieveAll("nome_regione");
			for (ComuneBean c : comuni) {
				if (!regioni.contains(c.getRegione())) {
					regioni.add(c.getRegione());
				}
			}
			request.setAttribute("regioni", regioni);
			
			String regione = request.getParameter("regione");
			if (regione == null) {
				RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiRegioni.jsp"));
				dispatcher.forward(request, response);
				return;
			}
			request.setAttribute("regione", regione);
			
			Collection<VotazionePoliticaBean> voti = votoModel.doRetrieveAllByRegione(regione);
			Collection<String> partiti = new LinkedList<String>();
			for (VotazionePoliticaBean v : voti) {
				if (!partiti.contains(v.getPartito()) && !v.getPartito().equals("Scheda Bianca")) {
					partiti.add(v.getPartito());
				}
			}
			
			Collection<String> percentuali = new LinkedList<String>();
			for (String p : partiti) {
				int count = 0;
				Iterator<VotazionePoliticaBean> it = voti.iterator();
				while(it.hasNext()) {
					if(it.next().getPartito().equals(p)) count++;
				}
				percentuali.add(p + " " + count*100/voti.size());
			}

			request.setAttribute("percentuali", percentuali);
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiRegioni.jsp"));
			dispatcher.forward(request, response);
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
