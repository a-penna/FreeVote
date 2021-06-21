<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<div class= "container">
		<nav class="navbar">
			<ul>
				<li><a href="<%=response.encodeURL("/FreeVote/home.jsp")%>">HOME</a>  <!--LOGO--></li>
	<% boolean isAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;

	   if(isAdmin) { %>
				<li><a href="<%=response.encodeURL("/FreeVote/admin/interfacciaAdmin.jsp")%>">INTERFACCIA ADMIN</a></li> <%
		} 
	%>
			  	<li><a href="<%=response.encodeURL("/FreeVote/PartitiControl")%>">Partiti</a></li>
				<li><a href="<%=response.encodeURL("/FreeVote/Referendum")%>">Referendum</a></li>
				<li><a href="#">Risultati Live</a></li><!--A TENDINA-->
				<li><a href="#">Statistiche Live</a></li>
	<% boolean isElettore = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
		if (isElettore) { %>
				<li><a href="<%=response.encodeURL("/FreeVote/elettore/schedaVoto.jsp")%>">Vai alla scheda</a></li> <%
		} %>
				<li><a href="<%=response.encodeURL("/FreeVote/infoEContatti.jsp")%>">Info e contatti</a></li>

		<%if (isElettore || isAdmin) {
					%>
					<li><a href="<%=response.encodeURL("/FreeVote/Logout")%>">Logout</a></li> <%
		}
		%>
				
			</ul>
		</nav>
	</div>
	
	
	<!--POLITICHE
	<a href="<%=response.encodeURL("/FreeVote/Risultati")%>">Risultati Generali</a> 
	<a href="<%=response.encodeURL("/FreeVote/risultatiPerEta.jsp")%>">Risultati per fascia d'et&agrave;</a>
	<a href="<%=response.encodeURL("/FreeVote/risultatiRegioni.jsp")%>">Risultati per Regione</a>
	REFERENDUM
	<a href="<%=response.encodeURL("/FreeVote/risultatiReferendum.jsp")%>">Risultati Generali Referendum</a>-->
