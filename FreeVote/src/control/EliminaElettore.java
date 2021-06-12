package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.AdminBean;
import model.ElettoreBean;
import model.ElettoreModelDS;
import utils.Utility;

/**
 * Servlet implementation class EliminaElettore
 */
@WebServlet("/EliminazioneElettore")
public class EliminaElettore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaElettore() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		ElettoreModelDS model = new ElettoreModelDS(ds);	
		String codice = request.getParameter("codice");
		codice=Utility.encryptMD5(codice);
		
		if (codice == null) {
		 	response.sendRedirect(response.encodeRedirectURL("./error/generic.jsp"));
		 	return;
		}
		
		String redirectedPage = "";

		try {
			ElettoreBean bean = model.doRetrieveByKey(codice);
			boolean flag = model.doDeleteCheck(bean);
			
		    if(flag==true) {
		    	
		    	redirectedPage="/admin/successoEliminazione.jsp";
		    	
		    }
		    else if(flag==false) {
		    	redirectedPage="/error/generic.jsp";
		    }
			
		} catch(SQLException e) {
			Utility.printSQLException(e);
		}
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + redirectedPage));
		}
		
		
		
		
	

}
