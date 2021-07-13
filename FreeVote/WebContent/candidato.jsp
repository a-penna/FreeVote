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
	 <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css">						
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<title>FreeVote &dash; <%=candidato.getNome()%> <%=candidato.getCognome()%> </title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div class="container py-4">
	<h1><%=candidato.getNome()%> <%=candidato.getCognome()%></h1> 
    <a href="Partito?nome=<%=candidato.getPartito()%>"><%=candidato.getPartito()%></a>
	<img src="PhotoControl?type=candidato&id=<%=candidato.getCf()%>" onerror="this.src='./imgs/nophoto.png'">
    <br>
	<p><%=candidato.getCurriculum()%></p>
	<br>
	</div>
</body>
</html>