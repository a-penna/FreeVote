package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import model.ComuneBean;
import model.ComuneModelDS;
import utils.Utility;

@WebServlet("/ListaComuni")
public class ListaComuniAJAX extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		ComuneModelDS model = new ComuneModelDS(ds);

		JSONObject json = new JSONObject();
		String regione = (String) request.getParameter("regione");
		
		try {
			Collection<ComuneBean> comuni = model.doRetrieveByRegione(regione, "nome"); 

			JSONArray jsArray = new JSONArray();
			Iterator<ComuneBean> it = comuni.iterator();
			while(it.hasNext()) {
				ComuneBean comune = it.next();
				jsArray.put(comune.getNome());
			}
			json.put("listaComuni", jsArray);

		} catch (JSONException e) {
			e.printStackTrace();
		}
		catch (SQLException e1) {
			Utility.printSQLException(e1);
		}

		response.getWriter().print(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
