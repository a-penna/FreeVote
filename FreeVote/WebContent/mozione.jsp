<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
 	MozioneBean mozione = (MozioneBean)request.getAttribute("mozione");
  	
 	if(mozione == null) {
 		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Referendum"));
 		return;
 	}
 	
 	Collection<?> autori = (Collection<?>)request.getAttribute("autori");
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Referendum, mozioni, mozione, ">
	<meta name="description" content="Testo mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; Mozione <%=mozione.getID()%> </title>
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
	<section class="mozione text-center">
		<div class="container">
		<h1>Testo della mozione <%=mozione.getID()%></h1>
		<br>
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
		</div>
	</section>
</body>
</html>