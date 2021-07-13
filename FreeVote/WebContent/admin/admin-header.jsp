<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class= "container-fluid pb-5">
	<nav class="navbar">
			<ul>
			<li><a href="<%=response.encodeURL("/FreeVote/admin/interfacciaAdmin.jsp")%>">FreeVote Admin</a></li>
			<li><a href="<%=response.encodeURL("/FreeVote/home.jsp")%>">FreeVote Home</a></li>  <!--LOGO-->
			<li><a href="<%=response.encodeURL("/FreeVote/admin/gestionePolitiche.jsp")%>">Gestisci Politiche</a></li>
			<li><a href="<%=response.encodeURL("/FreeVote/admin/gestioneReferendum.jsp")%>">Gestisci Referendum</a></li>
			<li><a href="<%=response.encodeURL("/FreeVote/admin/eliminaElettore.jsp")%>">Elimina un elettore</a></li>
			<li><a href="<%=response.encodeURL("/FreeVote/Logout")%>">Logout </a></li>
		</ul>
	</nav>
</div>

