<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci mozione, mozione">
	<meta name="description" content="Inserisci Mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Mozione</title>
</head>            
<body>

	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per registare una nuova mozione: <p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciMozione")%>" method="post"> 
        <fieldset>
        <legend>Informazioni sulla mozione&colon; </legend> <!-- Testo,Nome completo autore-->
        	<label for="nomeCompleto">Nome e cognome dell&apos;autore&colon;</label> 
       	    <input id="nomeCompleto" type="text" name="nomeCompleto" placeholder="Nome e cognome autore"> 
            <br>
        	<label for="testo">Testo della mozione&colon;</label>
        	<textarea id="testo" name="testo" rows="10" cols="48" placeholder="Inserisci qui il testo della mozione"> 
        	</textarea>
			<br>
        </fieldset>
        <input id="submit" type="submit" name="submit">
	</form> 

</body>
</html> 