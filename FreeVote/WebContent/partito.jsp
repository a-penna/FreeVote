<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	PartitoBean partito = (PartitoBean)request.getAttribute("partito");
  	
 	if(partito == null || (partito.getn_votazioni_ricevute() == -1)) {
 		response.sendRedirect(response.encodeRedirectURL("./PartitiControl"));
 		return;
 	}
 	
 	Collection<?> candidati = (Collection<?>)request.getAttribute("candidati");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, partito, <%=partito.getNome()%>">
	<meta name="description" content="Pagina Partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; <%=partito.getNome()%> </title>
</head>
<body>
	<%@ include file="header.html"%>
	<h1><%=partito.getNome()%></h1>
	<img src="PhotoControl?type=partito&id=<%=partito.getNome()%>" onerror="this.src='./imgs/nologo.png'">
    <br>
	<p><%=partito.getDescrizione()%></p>
	<br>
	<p>Candidati&colon;</p> <%
	
		Iterator<?> it  = candidati.iterator();
		while(it.hasNext()) {
			CandidatoBean candidato = (CandidatoBean) it.next();
			%> 
				<img src="PhotoControl?type=candidato&id=<%=candidato.getCf()%>" onerror="this.src='./imgs/nophoto.png'">
				<a href="Candidato?cf=<%=candidato.getCf()%>"><%=candidato.getNome()%> <%=candidato.getCognome()%></a> <%
		}
	%>

</body>
</html>