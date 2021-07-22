import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter{ //definito in web.xml

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
		
		HttpSession session = hrequest.getSession(false); //restituisce la sessione solo se esiste, non ne crea una nuova
		boolean loggedIn = session != null && session.getAttribute("adminRoles")!= null;
		
		if(!loggedIn) { //se un utente non è admin reindirizziamo al login, altrimenti il filtro lo lascerà passare
			hresponse.sendRedirect(hrequest.getContextPath() + "/loginAdmin.jsp");
		} else {
			chain.doFilter(request, response);
		}
		
	}

	public void init(FilterConfig fConfig) throws ServletException { }

}

