<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<a href="<%=response.encodeURL("/FreeVote/admin/interfacciaAdmin.jsp")%>">FreeVote Admin</a> 
	<a href="<%=response.encodeURL("/FreeVote/home.jsp")%>">FreeVote Home</a>  <!--LOGO-->
	<br/>
	<a href="<%=response.encodeURL("/FreeVote/admin/gestionePolitiche.jsp")%>">Gestisci Politiche</a>
	<a href="<%=response.encodeURL("")%>">Gestisci Referendum</a>
	<a href="<%=response.encodeURL("/FreeVote/admin/eliminaElettore.jsp")%>">Elimina un elettore</a>
	<a href="<%=response.encodeURL("/FreeVote/Logout")%>">Logout </a>