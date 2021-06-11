package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.*;
import utils.Utility;

/**
 * Servlet implementation class PhotoControl
 */
@WebServlet("/PhotoControl")
public class PhotoControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoControl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type = (String) request.getParameter("type");
		String id = (String) request.getParameter("id");
		
		if (type == null || id == null) {
			response.sendRedirect(response.encodeRedirectURL("./PartitiControl"));
		 	return;
		}
		
		byte[] bt = null;
		
		if (type.equals("partito")) {
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			PartitoModelDS partitoModel = new PartitoModelDS(ds);
			try {
				PartitoBean partito = partitoModel.doRetrieveByKey(id);
				System.out.println(partito.getNome());
				bt = partito.getLogo();
				
			} catch (SQLException e) {
				Utility.printSQLException(e);
			}
			
		}
		
		if (type.equals("candidato")) {
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			CandidatoModelDS candidatoModel = new CandidatoModelDS(ds);
			try {
				CandidatoBean candidato = candidatoModel.doRetrieveByKey(id);
				bt = candidato.getFoto();
				
			} catch (SQLException e) {
				Utility.printSQLException(e);
			}
			
		}
		
		ServletOutputStream out = response.getOutputStream();
		
		if(bt != null) {
			out.write(bt);
			response.setContentType("image/png");			
		}
		out.close();
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}