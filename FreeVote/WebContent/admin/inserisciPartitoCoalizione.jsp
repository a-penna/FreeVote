
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci partito in una coalizione, operazioni admin, partito, coalizione, inserisci partito">
	<meta name="description" content="Inserisci partito in una coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Partito in Coalizione</title>
	
</head>            

	<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per inserire un partito in una coalizione&period; Sia il partito che la coalizione devono essere gi&agrave; presenti nel database&period;<p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciPartitoCoalizione")%>" method="post"> 
        <fieldset>
        	<label for="nome">Nome Partito&colon;</label>
       	    <input id="nome" type="text" name="nome" placeholder="Nome partito" required> 
            <br>
        	<label for="coalizione">Nome Coalizione&colon;</label>
            <input id="coalizione" type="coalizione" name="coalizione" placeholder="Nome coalizione" required> 
        	<br>
        </fieldset>
        
        <input id="submit" type="submit" value="Inserisci">
	</form> 

</body>
</html> 