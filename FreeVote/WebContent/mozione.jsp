<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	MozioneBean mozione = (MozioneBean)request.getAttribute("mozione");
  	
 	if(mozione == null || mozione.getID() == -1) {
 		response.sendRedirect(response.encodeRedirectURL("./Referendum"));
 		return;
 	}
 	
 	Collection<?> autori = (Collection<?>)request.getAttribute("autori");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Referendum, mozioni">
	<meta name="description" content="Testo mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; Mozione <%=mozione.getID()%> </title>
</head>
<body>
	<%@ include file="header.html"%>
	<h1>Testo della mozione <%=mozione.getID()%></h1>
	<p><%=mozione.getTesto()%></p>
	<br>
	<i>Autori&colon; <%
	
		Iterator<?> it  = autori.iterator();
		if (it.hasNext()) {
			AutoreBean autore = (AutoreBean) it.next();
			out.print(autore.getNomeCompleto());
		}
		
		while(it.hasNext()) {
			AutoreBean autore = (AutoreBean) it.next();
			out.print("&comma; " + autore.getNomeCompleto());
		}
		
	%></i>

</body>
</html>