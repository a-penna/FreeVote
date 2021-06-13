 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Elimina Elettore">
	<meta name="description" content="Elimina elettore">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Elimina Elettore</title>
</head>            

<body>
	<%@ include file="/admin/admin-header.jsp"%>
    
    <form action="<%=response.encodeURL("/FreeVote/EliminazioneElettore")%>" method="post"> 
        <fieldset>
            <legend>Inserisci credenziali&colon; </legend>
            <label for="codice">Codice&colon;</label>
            <input id="codice" type="text" name="codice" placeholder="inserisci codice"> 
            <br>
            <input id="submit" type="submit" name="submit">
       </fieldset>
    </form> 

</body>
</html> 