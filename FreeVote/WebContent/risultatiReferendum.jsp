<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	String si = (String)request.getAttribute("si");
	if(si == null) {
		response.sendRedirect(response.encodeRedirectURL("/FreeVote/RisultatiReferendum"));
		return; 
	}
	String no = (String)request.getAttribute("no");
	String astenuti = (String)request.getAttribute("astenuti");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni, risultati referendum">
	<meta name="description" content="Risultati votazioni referendum">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Risultati Referendum</title>
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
    <br>
    <h3>Di seguito i risultati del referendum&colon;</h3>
	
	<p>Numero di S&igrave;&colon; <%=si%></p>
	<p>Numero di No&colon; <%=no%></p>
	<p>Numero di Astenuti&colon; <%=astenuti%></p>
</body>
</html>