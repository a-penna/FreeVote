package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

import model.*;
import utils.Utility;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/RisultatiReferendum")
public class RisultatiReferendumControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource)getServletContext().getAttribute("DataSource");
		VotazioneReferendumModelDS model = new VotazioneReferendumModelDS(ds);

		try {
			int si = 0;
			int no = 0;
			int astenuti = 0;
			Collection<VotazioneReferendumBean> voti = model.doRetrieveAll("");
			Iterator<VotazioneReferendumBean> it = voti.iterator();
			while(it.hasNext()) {
				VotazioneReferendumBean bean = it.next();
				if (bean.getPreferenza().equals("Si")){
					si ++;
				} else if (bean.getPreferenza().equals("No")) {
					no ++;
				} else {
					astenuti ++;
				}
			}
			request.setAttribute("si", "" + si);
			request.setAttribute("no", "" + no);
			request.setAttribute("astenuti", "" + astenuti);
			RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher(response.encodeURL("/risultatiReferendum.jsp"));
			dispatcher.forward(request, response);
		} catch(SQLException e) {
			Utility.printSQLException(e);
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/error/generic.jsp"));
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
