<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");

    if (partiti == null) {
        response.sendRedirect(response.encodeRedirectURL("./PartitoControl"));
        return;
    }
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, partiti">
	<meta name="description" content="Piattaforma voto, lista partiti">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Partiti</title>
</head>            

<body>
	<%@ include file="header.jsp"%>
    <br>
    <h1>Lista partiti&colon;</h1>
    <br>
    <%
        Iterator<?> it = partiti.iterator();
        while(it.hasNext()) {
            PartitoBean partito = (PartitoBean)it.next(); 
            if (!partito.getNome().equals("Scheda Bianca")) {
    %>
    			<img src="PhotoControl?type=partito&id=<%=partito.getNome()%>" onerror="this.src='./imgs/nologo.png'">
            	<a href="Partito?nome=<%=partito.getNome()%>"><%=partito.getNome()%></a>
            	<br>
    <%   	}
        }
    %>
    
</body>
</html>