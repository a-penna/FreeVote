<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	PartitoBean partito = (PartitoBean)request.getAttribute("partito");
  	
 	if(partito == null) {
 		response.sendRedirect(response.encodeRedirectURL("./PartitoControl"));
 		return;
 	}
 	
 	Collection<?> candidati = (Collection<?>)request.getAttribute("candidati");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, partito, <%=partito.getNome()%>">
	<meta name="description" content="Testo Partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote - <%=partito.getNome()%> </title>
</head>
<body>
	<%@ include file="header.html"%>
	<h1><%=partito.getNome()%></h1>
    <br>
	<p><%=partito.getDescrizione()%></p>
	<br>
	<p>Candidati&colon;</p> <%
	
		Iterator<?> it  = candidati.iterator();
		while(it.hasNext()) {
			CandidatoBean candidato = (CandidatoBean) it.next();
			%> <a href="Candidato?cf=<%=candidato.getCf()%>"><%=candidato.getNome()%> <%=candidato.getCognome()%></a> <%
		}
	%>

</body>
</html>