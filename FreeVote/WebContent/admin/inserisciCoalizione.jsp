<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci coalizione, coalizione">
	<meta name="description" content="Inserisci Coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Coalizione</title>
</head>            
<body>

	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per registare una nuova coalizione: <p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciCoalizione")%>" method="get"> 
        <fieldset>
        <legend>Informazioni sulla coalizione&colon; </legend> 
        	<label for="nome">Nome Coalizione&colon;</label>  
       	    <input id="nome" type="text" name="nomeCoalizione" placeholder="Nome della coalizione"> 
            <br>
        	<label for="nomePartito1">Nome del primo partito&colon;</label>   <!--Inserimento più partiti con javascript da inserire -->
			<input id="nomePartito1" type="text" name="nomePartito1" placeholder="Nome del primo partito"> 
            <label for="nomePartito2">Nome del secondo partito&colon;</label>
            <input id="nomePartito2" type="text" name="nomePartito2" placeholder="Nome del secondo partito"> 
			<br>
        </fieldset>
        <input id="submit" type="submit" name="submit">
	</form> 

</body>
</html> 