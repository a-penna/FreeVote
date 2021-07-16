<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	PartitoBean partito = (PartitoBean)request.getAttribute("partito");
  	
 	if(partito == null || (partito.getn_votazioni_ricevute() == -1)) {
 		response.sendRedirect(response.encodeRedirectURL("./PartitiControl"));
 		return;
 	}
 	
 	Collection<?> candidati = (Collection<?>)request.getAttribute("candidati");
 	
 	CoalizioneBean coalizione = (CoalizioneBean)request.getAttribute("coalizione");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, partito, <%=partito.getNome()%>">
	<meta name="description" content="Pagina Partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; <%=partito.getNome()%> </title>
	<link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css">						
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="container py-5">  
		<h1 align="center"><%=partito.getNome()%></h1>
		
		<% if (!coalizione.getNome().equals("")) { %>
			<h2 align="center">&lsqb;<%=coalizione.getNome()%>&rsqb;</h2>
		<%} %>
		
		<img src="PhotoControl?type=partito&id=<%=partito.getNome()%>" class = "center" onerror="this.src='./imgs/nologo.png'" alt="foto">
	    <% boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
		
		if(loggedIn) { %>
			<br>
			 <form class="form" action="<%=response.encodeURL("/FreeVote/GestisciVoto")%>" method="post">
			            <input type="hidden" name="action"  value="aggiornaPartito">
			            <input type="hidden" name="partitoScelto"  value="<%=partito.getNome()%>">
				      <input type="submit" class="btn btn-dark" value="Aggiungi alla scheda">
			</form>
		<% }%>
	    <br>
		<p><%=partito.getDescrizione()%></p>
		<br>
		<h3>Candidati&colon;</h3> <%
		
			Iterator<?> it  = candidati.iterator();
			while(it.hasNext()) {
				CandidatoBean candidato = (CandidatoBean) it.next();
				%> 
					<span class="container py-5">
					<img src="PhotoControl?type=candidato&id=<%=candidato.getCf()%>" onerror="this.src='./imgs/nophoto.png'">
					<a href="Candidato?cf=<%=candidato.getCf()%>"><%=candidato.getNome()%> <%=candidato.getCognome()%></a>
					</span> <%
			}
		%>
		</div>

</body>
</html>