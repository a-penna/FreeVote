<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, elimina mozione, mozione">
	<meta name="description" content="Elimina Mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Mozione</title>
</head>            
<body>

	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per eliminare una mozione già presente: <p>

	<form action="<%=response.encodeURL("/FreeVote/EliminaMozione")%>" method="get"> 
        <fieldset>
        <legend>Inserisci l'ID della mozione da rimuovere&colon; </legend> <!-- Testo,Nome completo autore-->
        	<label for="id">ID della mozione&colon;</label> 
       	    <input id="id" type="text" name="id" placeholder="ID della mozione"> 
           
        </fieldset>
        <input id="submit" type="submit" name="submit">
	</form> 

</body>
</html> 