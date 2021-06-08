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
	<title>FreeVote - Referendum</title>
</head>
<body>
	<%@ include file="header.html"%>
	
	<p>Di seguito la lista di tutte le mozioni che hanno portato all&apos;attuale referendum&comma; 
	cliccando sull&apos;id sar&agrave; possibile visualizzare il testo intero della mozione corrispondente&colon; </p>
	
	<% 
	Iterator<?> it  = mozioni.iterator();
	while(it.hasNext()) { 
		MozioneBean mozione = (MozioneBean)it.next();%>
		<a href="Mozione?id=<%=mozione.getID()%>"><%=mozione.getID()%></a>
		<br/> 
	<% } %>
	
</body>
</html>