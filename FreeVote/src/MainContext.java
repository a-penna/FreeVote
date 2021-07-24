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
		
		DataSource ds = null; 
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env"); //cerchiamo servizi java offerti dall'environment tomcat

			ds = (DataSource) envCtx.lookup("jdbc/VotoDB"); //lookup del DataSource definito in web.xml

		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}

		context.setAttribute("DataSource", ds); //inseriamo il DataSource nel context per averlo disponibile ovunque
	}

	public void contextDestroyed(ServletContextEvent event) {
		ServletContext context = event.getServletContext();

		context.removeAttribute("DataSource");
	}
}
