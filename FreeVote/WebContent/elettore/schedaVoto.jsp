<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");

	if (partiti == null) {
  	  response.sendRedirect(response.encodeRedirectURL("/FreeVote/InfoVoto"));
   	 return;
	}
%>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, votazioni, scheda voto, scheda elettorale, scheda">
	<meta name="description" content="Risultati votazioni per et&agrave;">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Scheda Elettorale</title>
</head>            

<body>
	<%@ include file="/header.jsp"%>
    <br/>
    <h3>SCHEDA</h3>
    <form action="GestisciVoto" method="post">
 	<%
        Iterator<?> it = partiti.iterator();
        while(it.hasNext()) {
            PartitoBean partito = (PartitoBean)it.next(); 
            if (!partito.getNome().equals("Scheda Bianca")) {
    %>
    			<img src="/FreeVote/PhotoControl?type=partito&id=<%=partito.getNome()%>" onerror="this.src='./imgs/nologo.png'">
            	<input type="radio" id="<%=partito.getNome()%>" name="<%=partito.getNome()%>" value="<%=partito.getNome()%>">
            	<label for="<%=partito.getNome()%>"><a href="/FreeVote/Partito?nome=<%=partito.getNome()%>"><%=partito.getNome()%></a></label>
            	
            	<br>
    <%   	}
        }
        
        
    %>
    <button type="submit">Vota</button>
    </form>
 	
 	
 	
 	
</body>
</html>