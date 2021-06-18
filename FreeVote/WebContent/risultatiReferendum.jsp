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