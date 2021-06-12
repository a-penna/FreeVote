<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");
     
    if(partiti == null) {
        response.sendRedirect(response.encodeRedirectURL("./EtaControl")); 
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni, risultati per et&agrave;">
	<meta name="description" content="Risultati votazioni per et&agrave;">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Risultati per et&agrave;</title>
</head>            

<body>
	<%@ include file="header.html"%>
    <br/>
    <p>Scegliendo il nome di un partito ed inserendo una particolare fascia d'et&agrave; potrai visualizzare, in percentuale,
    quante votazioni quel partito ha ricevuto in quella specifica fascia d'et&agrave; </p>

    

    <form action="Elettore" method="post"> 
        <select name="partito" size="5">
            <%
            Iterator<?> it = partiti.iterator();
            while(it.hasNext()) {
                PartitoBean partito = (PartitoBean)it.next();    
                if (!partito.getNome().equals("Scheda Bianca")) {  
            %>
            <option value="<%=partito.getNome()%>"><%=partito.getNome()%></option>
            <%  } 
            }
            %>
        </select> <br>

        <label for="eta">Et&agrave; minima</label>
        <input type="number" id="eta" name="minima" min="18" max="120">

        <label for="eta">Et&agrave; massima</label>
        <input type="number" id="eta" name="massima" min="18" max="120">


    </form> 
 
</body>
</html>