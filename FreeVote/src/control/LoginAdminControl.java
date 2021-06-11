package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.AdminModelDS;

@WebServlet("/Administrator")
public class LoginAdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginAdminControl() {
		super();
	}	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		    AdminModelDS model = new AdminModelDS(ds);
			
			
			//if (model.doRetrieveByKey("key") != null) {
			 //	response.sendRedirect(response.encodeRedirectURL("./loginAdmin.jsp"));
			 //	return;
			// }
			
			String redirectedPage;
		//	if (checkLogin(username, password)) {
			//	request.getSession().setAttribute("adminRoles", "true");
			//	redirectedPage = "/admin/interfacciaAdmin.jsp";
			// } else {
			//	redirectedPage = "/loginAdmin.jsp";
			// }
		//	response.sendRedirect(request.getContextPath() + redirectedPage);
	// }

	//private boolean checkLogin(Admin) {
		//return ("admin".equals(username)) && ("admin".equals(password));
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	

}
