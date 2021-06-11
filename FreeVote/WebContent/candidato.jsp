<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	CandidatoBean candidato = (CandidatoBean)request.getAttribute("candidato");
  	
 	if(candidato == null) {
 		response.sendRedirect(response.encodeRedirectURL("./PartitiControl"));
 		return;
 	}
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, candidato, <%=candidato.getPartito()%>, <%=candidato.getNome()%>">
	<meta name="description" content="Pagina Candidato">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; <%=candidato.getNome()%> <%=candidato.getCognome()%> </title>
</head>
<body>
	<%@ include file="header.html"%>
	<h1><%=candidato.getNome()%> <%=candidato.getCognome()%></h1> 
    <a href="Partito?nome=<%=candidato.getPartito()%>"><%=candidato.getPartito()%></a>
	<img src="PhotoControl?type=candidato&id=<%=candidato.getCf()%>" onerror="this.src='./imgs/nophoto.png'">
    <br>
	<p><%=candidato.getCurriculum()%></p>
	<br>
</body>
</html>