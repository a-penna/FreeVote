<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
        <%
        Iterator<?> it = partiti.iterator();
        while(it.hasNext()) {
            PartitoBean partito = (PartitoBean)it.next(); 
          
    %>
            	<a href="Partito?nome=<%=partito.getNome()%>"><%=partito.getNome()%></a>
            	<br>
    <%   	}
        }
    %>
</body>
</html>
