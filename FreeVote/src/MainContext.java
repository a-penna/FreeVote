import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;

@WebListener
public class MainContext implements ServletContextListener {
	public void contextInitialized(ServletContextEvent event) { //chiamato ogni volta che si crea il contesto

		ServletContext context = event.getServletContext();
		
		DataSource ds = null; //Si crea la connessione
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env"); //cerco java_:comp/env per cercare il database

			ds = (DataSource) envCtx.lookup("jdbc/VotoDB"); //definito in web.xml, lo prendiamo

		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}

		context.setAttribute("DataSource", ds); //inseriamo il DataSource nel context per averla disponibile ovunque
	}

	public void contextDestroyed(ServletContextEvent event) {
		ServletContext context = event.getServletContext();

		context.removeAttribute("DataSource");
	}
}
