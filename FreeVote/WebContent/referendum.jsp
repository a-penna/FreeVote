<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>
    
<%
 	Collection<?> mozioni = (Collection<?>) request.getAttribute("mozioni");
  	
 	if(mozioni == null) {
 		response.sendRedirect(response.encodeRedirectURL("./Referendum")); 
 		return;
 	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Referendum, mozioni">
	<meta name="description" content="Lista mozioni corrispondenti al referendum in corso">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; Referendum</title>
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
<body class="bg-light">
	<%@ include file="header.jsp"%>
	
	<section class="referendum text-center">
		<div class="container">
			<p>Di seguito la lista di tutte le mozioni che hanno portato all&apos;attuale referendum&comma; 
			cliccando sull&apos;id sar&agrave; possibile visualizzare il testo intero della mozione corrispondente&colon;</p>
		
			<% 
			Iterator<?> it  = mozioni.iterator();
			while(it.hasNext()) { 
				MozioneBean mozione = (MozioneBean)it.next();%>
				<a href="Mozione?id=<%=mozione.getID()%>" class="btn btn-primary btn-lg btn-dark btn-block">Mozione <%=mozione.getID()%></a>
				<br/> 
			<% } %>
		</div>
	</section>
</body>
</html>