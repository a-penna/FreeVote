<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>
   
 <%
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");
     
    if(partiti == null) {
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
    <title>FreeVote - Risultati Generali</title>
</head>            

<body>
	<%@ include file="header.html"%>
    <br/>
    <h1>Risultati&colon;</h1>
        <%
        Iterator<?> it = partiti.iterator();
        while(it.hasNext()) {
            PartitoBean partito = (PartitoBean)it.next();    
            if (!partito.getNome().equals("Scheda Bianca")) {  
    %>
            	<p> <a href="Partito?nome=<%=partito.getNome()%>"><%=partito.getNome()%></a>
                <%=partito.getn_votazioni_ricevute()%> </p>
            	<br>
    <%   }
    }
    %>
</body>
</html>
