<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, elimina eartito">
	<meta name="description" content="Elimina partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Partito</title>
</head>            

	<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per registare un nuovo partito: <p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciPartito")%>" method="post" enctype="multipart/form-data"> 
        <fieldset>
        <legend>Informazioni sul partito&colon; </legend>
        	<label for="nome">Nome&colon;</label>
       	    <input id="nome" type="text" name="nome" placeholder="Nome partito"> 
            <br>
        	<label for="descrizione">Descrizione&colon;</label>
        	<textarea id="descrizione" name="descrizione" rows="10" cols="48" placeholder="Inserisci qui la descrizione"> 
        	</textarea>
			<br>
        	<label for="logo">Carica Logo&colon;</label>
       	    <input id="logo" type="file" name="logo"> 
        	<br>
        </fieldset>
        <fieldset>
        <legend>Informazioni sul leader&colon; </legend>
        	<label for="nomeLeader">Nome&colon;</label>
        	<input id="nomeLeader" type="text" name="nomeLeader" placeholder="Nome"> 
        	<label for="cognomeLeader">Cognome&colon;</label>
        	<input id="cognomeLeader" type="text" name="cognomeLeader" placeholder="Cognome"> 
        	<br>
        	<label for="cf">Codice fiscale&colon;</label>
        	<input id="cf" type="text" name="cf" placeholder="Cf">
        	<br>
        	<label for="curriculum">Curriculum&colon;</label>
        	<textarea id="curriculum" name="curriculum" rows="10" cols="48" placeholder="Inserisci qui il curriculum"> 
        	</textarea>
        	<br>
        	<label for="foto">Carica Foto&colon;</label>
       	    <input id="foto" type="file" name="foto">  
        	<br>
        </fieldset>
        <input id="submit" type="submit" name="submit">
	</form> 

</body>
</html> 