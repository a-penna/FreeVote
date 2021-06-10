package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoginAdmin")
public class LoginAdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginAdminControl() {
		super();
	}	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		{
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String redirectedPage;
			if (checkLogin(username, password)) {
				request.getSession().setAttribute("adminRoles", "true");
				redirectedPage = "/Admin/interfacciaAdmin.jsp";
			} else {
				request.getSession().setAttribute("adminRoles", "false");
				redirectedPage = "/loginAdmin.jsp";
			}
			response.sendRedirect(request.getContextPath() + redirectedPage);
		}
	}

	private boolean checkLogin(String username, String password) {
		return ("admin".equals(username)) && ("admin".equals(password));
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	

}
