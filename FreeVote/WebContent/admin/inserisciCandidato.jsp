<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci candidato, candidato">
	<meta name="description" content="Inserisci candidato">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Candidato</title>
	
</head>            

	<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per inserire un nuovo candidato all&apos;interno di un partito gi&agrave; registrato sulla piattaforma&colon;<p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciCandidato")%>" method="post" enctype="multipart/form-data"> 
        <fieldset>
        <legend>Informazioni sul candidato&colon; </legend>
            <label for="nome">Nome&colon;</label>
            <input id="nome" type="text" name="nome" placeholder="Nome candidato"> 
            <label for="cognome">Cognome&colon;</label>
            <input id="cognome" type="text" name="cognome" placeholder="Cognome candidato"> 
            <br>
            <label for="cf">Codice fiscale&colon;</label>
            <input id="cf" type="text" name="cf" placeholder="Codice Fiscale">
            <br>
            <label for="curriculum">Curriculum&colon;</label>
            <textarea id="curriculum" name="curriculum" rows="10" cols="48" placeholder="Inserisci qui il curriculum"></textarea>
            <br>
            <label for="foto">Carica Foto&colon;</label>
               <input id="foto" type="file" name="foto">  
            <br>
        </fieldset>
        <fieldset>
        <legend>Nome del partito in cui inserire il candidato&colon; </legend>
        	<label for="partito">Nome&colon;</label>
       	    <input id="partito" type="text" name="partito" placeholder="Nome partito"> 
        </fieldset>
        <input id="submit" type="submit" name="submit">
	</form> 

</body>
</html> 