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
</head>            

<body>
	<%@ include file="header.jsp"%>
    <br/>
    <h1>Risultati&colon;</h1>
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
</body>
</html>
