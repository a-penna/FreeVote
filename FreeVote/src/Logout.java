import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		boolean isElettore = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
		boolean isAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
		String redirectedPage = "";

		if(isElettore) {
			redirectedPage += "/loginElettore.jsp";
			request.getSession().removeAttribute("elettoreRoles");
		}
		
		if(isAdmin) {
			redirectedPage += "/loginAdmin.jsp";
			request.getSession().removeAttribute("adminRoles");
		}
		request.getSession().invalidate();
		
		response.sendRedirect("/FreeVote" + redirectedPage);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}
    
}
