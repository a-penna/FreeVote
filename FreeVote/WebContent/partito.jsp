<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	PartitoBean partito = (PartitoBean)request.getAttribute("partito");
  	
 	if(partito == null || (partito.getn_votazioni_ricevute() == -1)) {
 		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/PartitiControl"));
 		return;
 	}
 	
 	Collection<?> candidati = (Collection<?>)request.getAttribute("candidati");
 	
 	CoalizioneBean coalizione = (CoalizioneBean)request.getAttribute("coalizione");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, info partito, partito, <%=partito.getNome()%>">
	<meta name="description" content="Pagina Partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; <%=partito.getNome()%> </title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="bg-light">
	<%@ include file="header.jsp"%>
	<div class="container py-5">  
		<h1 align="center"><%=partito.getNome()%></h1>
		
		<% if (!coalizione.getNome().equals("")) { %>
			<h2 align="center">&lsqb;<%=coalizione.getNome()%>&rsqb;</h2>
		<%} %>
		<br>
		<img src="PhotoControl?type=partito&id=<%=partito.getNome()%>" class ="mx-auto d-block rounded" height="225" width="225" onerror="this.src='./imgs/nologo.png'" alt="foto">
	    <% boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
		
		if(loggedIn) { %>
			<br>
			 <form class="form" action="<%=response.encodeURL(request.getContextPath() + "/GestisciVoto")%>" method="post">
			            <input type="hidden" name="action"  value="aggiornaPartito">
			            <input type="hidden" name="partitoScelto"  value="<%=partito.getNome()%>">
				      <input type="submit" class="btn btn-info mx-auto d-block" value="Aggiungi alla scheda">
			</form>
		<% }%>
	    <br>
		<p class="h5 text-justify font-weight-normal py-4"><%=partito.getDescrizione()%></p>
		<br>
		<hr>
		<br>
		<br>
		<h3>Candidati&colon;</h3> 
		<div class="row py-3"><%
			Iterator<?> it  = candidati.iterator();
			while(it.hasNext()) {
				CandidatoBean candidato = (CandidatoBean) it.next();
				%> 
				    		<div class="col-lg-4 py-4">
								<img src="PhotoControl?type=candidato&id=<%=candidato.getCf()%>" class="rounded-circle mx-auto d-block" height="225" width="225" onerror="this.src='./imgs/nophoto.png'">
								<a href="<%=response.encodeURL(request.getContextPath() + "/Candidato?cf=" + candidato.getCf())%>"><%=candidato.getNome()%> <%=candidato.getCognome()%></a>
							</div>
					 <%
			}
		%>
		</div>
	</div>

</body>
</html>