<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, admin, inserisci, inserisci partito, partito">
	<meta name="description" content="Inserisci partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Partito</title>
	<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
    <script>
        function validate(obj) {	
            var valid = true;	

            var nomeLeader = document.getElementsByName("nomeLeader")[0];
            if(!checkNomeCognome(nomeLeader)) {
                valid = false;
                document.getElementById("nomeError").innerHTML = "Nome non valido!";
            } else {
                document.getElementById("nomeError").innerHTML = "";
            }
            
            var cognomeLeader = document.getElementsByName("cognomeLeader")[0];
            if(!checkNomeCognome(cognomeLeader)) {
                valid = false;
                document.getElementById("cognomeError").innerHTML = "Cognome non valido!";
            } else {
                document.getElementById("cognomeError").innerHTML = "";
            }

            var cf = document.getElementsByName("cf")[0];
            if(!checkCf(cf)) {
                valid = false;
                document.getElementById("cfError").innerHTML = "Codice fiscale non valido!";
            } else {
                document.getElementById("cfError").innerHTML = "";
            }
            
            if(valid) obj.submit();
        }
    </script>
</head>            

<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per registare un nuovo partito&colon; <p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciPartito")%>" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)"> 
        <fieldset>
        <legend>Informazioni sul partito&colon; </legend>
        	<label for="nome">Nome&colon;</label>
       	    <input id="nome" type="text" name="nome" placeholder="Nome partito" required> 
			<br>
        	<label for="descrizione">Descrizione&colon;</label>
        	<textarea id="descrizione" name="descrizione" rows="10" cols="48" placeholder="Inserisci qui la descrizione" required></textarea>
			<br>
        	<label for="logo">Carica Logo&colon;</label>
       	    <input id="logo" type="file" name="logo"> 
        	<br>
        </fieldset>
        <fieldset>
        <legend>Informazioni sul leader&colon; </legend>
        	<label for="nomeLeader">Nome&colon;</label>
        	<input id="nomeLeader" type="text" name="nomeLeader" placeholder="Nome" required> 
			<p id="nomeError"></p> 
        	<label for="cognomeLeader">Cognome&colon;</label>
        	<input id="cognomeLeader" type="text" name="cognomeLeader" placeholder="Cognome" required> 
        	<p id="cognomeError"></p>
        	<label for="cf">Codice fiscale&colon;</label>
        	<input id="cf" type="text" name="cf" placeholder="Cf" required>
        	<p id="cfError"></p>
        	<label for="curriculum">Curriculum&colon;</label>
        	<textarea id="curriculum" name="curriculum" rows="10" cols="48" placeholder="Inserisci qui il curriculum"></textarea>
        	<br>
        	<label for="foto">Carica Foto&colon;</label>
       	    <input id="foto" type="file" name="foto">  
        	<br>
        </fieldset>
        <input type="submit" value="Inserisci">
	</form> 

</body>
</html> 