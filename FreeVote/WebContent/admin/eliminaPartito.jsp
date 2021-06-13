<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, elimina eartito">
<meta name="description" content="Elimina partito">
<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
<title>FreeVote &dash; Elimina Partito</title>
</head>            

<body>
<%@ include file="/admin/admin-header.html"%>

<form action="/FreeVote/EliminaPartito" method="post"> 
    <fieldset>
        <legend>Inserisci credenziali&colon; </legend>
        <label for="nome">Nome&colon;</label>
        <input id="nome" type="text" name="nome" placeholder="inserisci nome"> 
        <br>
        <input id="submit" type="submit" name="submit">
   </fieldset>
</form> 

</body>
</html> 