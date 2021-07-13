<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>
   
<% 
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");

    if (partiti == null) {
        response.sendRedirect(response.encodeRedirectURL("./Risultati"));
        return;
    }
    Collection<?> coalizioni = (Collection<?>) request.getAttribute("coalizioni");

    if (coalizioni == null) {
        response.sendRedirect(response.encodeRedirectURL("./Risultati"));
        return;
    }
%>    


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni">
	<meta name="description" content="Risultati votazioni">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Risultati Generali</title>
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
	<div class="container-fluid pt-4"> 
    <br/>
    <h1 align="center">Risultati&colon;</h1>
        <%
        Iterator<?> it = partiti.iterator();
        Iterator<?> it2 = coalizioni.iterator();
        while(it.hasNext() && it2.hasNext()) {
        	CoalizioneBean coalizione= (CoalizioneBean)it2.next();
            PartitoBean partito = (PartitoBean)it.next();    
            if (!partito.getNome().equals("Scheda Bianca")) {  
    %>
            	<img src="PhotoControl?type=partito&id=<%=partito.getNome()%>" onerror="this.src='./imgs/nologo.png'">
    			<% if (!coalizione.getNome().equals("")) { %>
            		<p><%=partito.getNome()%> &lsqb;<%=coalizione.getNome()%>&rsqb; Voti: <%=partito.getn_votazioni_ricevute()%></p>
            	<%} else { %>
            		<p><%=partito.getNome()%> Voti: <%=partito.getn_votazioni_ricevute()%></p>
            		<br>
            	<% } 
            	
      	}
        }
    %>
    </div>
</body>
</html>
