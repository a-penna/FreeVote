<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazione admin, inserisci candidato, candidato, inserisci">
	<meta name="description" content="Inserisci candidato">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Candidato</title>
	<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
    <script>

        function validate(obj) {	
            var valid = true;	

            var name = document.getElementsByName("nome")[0];
            if(!checkNomeCognome(name)) {
                valid = false;
                document.getElementById("nomeError").innerHTML = "Nome non valido&excl;";
            } else {
                document.getElementById("nomeError").innerHTML = "";
            }
            
            var surname = document.getElementsByName("cognome")[0];
            if(!checkNomeCognome(surname)) {
                valid = false;
                document.getElementById("cognomeError").innerHTML = "Cognome non valido&excl;";
            } else {
                document.getElementById("cognomeError").innerHTML = "";
            }

            var cf = document.getElementsByName("cf")[0];
            if(!checkCf(cf)) {
                valid = false;
                document.getElementById("cfError").innerHTML = "Codice fiscale non valido&excl;";
            } else {
                document.getElementById("cfError").innerHTML = "";
            }
            
            if(valid) obj.submit();
        }
    </script>
    
</head>            

	<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per inserire un nuovo candidato all&apos;interno di un partito gi&agrave; registrato sulla piattaforma&colon;<p>

	<form name="form" action="<%=response.encodeURL("/FreeVote/InserisciCandidato")%>" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)"> 
        <fieldset>
        <legend>Informazioni sul candidato&colon; </legend>
            <label for="nome">Nome&colon;</label>
            <input id="nome" type="text" name="nome" placeholder="Nome candidato" required> 
            <p id="nomeError"></p>
            <label for="cognome">Cognome&colon;</label>
            <input id="cognome" type="text" name="cognome" placeholder="Cognome candidato" required> 
            <p id="cognomeError"></p>        
            <label for="cf">Codice fiscale&colon;</label>
            <input id="cf" type="text" name="cf" placeholder="Codice Fiscale" onkeyup="toUpperCaseCf()" required>
            <p id="cfError"></p>
            <label for="curriculum">Curriculum&colon;</label>
            <textarea id="curriculum" name="curriculum" rows="10" cols="48" placeholder="Inserisci qui il curriculum" required></textarea>
            <br>
            <label for="foto">Carica Foto&colon;</label>
               <input id="foto" type="file" name="foto">  
            <br>
        </fieldset>
        <fieldset>
        <legend>Nome del partito in cui inserire il candidato&colon; </legend>
        	<label for="partito">Nome&colon;</label>
       	    <input id="partito" type="text" name="partito" placeholder="Nome partito" required> 
        </fieldset>
        <input type="submit" value="Inserisci">
	</form> 

</body>
</html> 