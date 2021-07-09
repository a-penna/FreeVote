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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css">						
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        <div class="container">
            <form action="Elettore" action="<%=response.encodeURL("/FreeVote/InserisciCandidato")%>" class="needs-validation" novalidate method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)">
                <fieldset>
                    <legend>Informazioni sul candidato&colon; </legend>
                    <div class="form-group">
                        <label for="nome">Nome&colon;</label>
                        <input type="text" class="form-control" id="nome" placeholder="Inserisci Nome" name="nome" required>
                        <div class="valid-feedback">Corretto</div>
                        <div class="invalid-feedback">Nome non valido&excl;</div>
                    </div>
                    <div class="form-group">
                        <label for="cognome">Cognome&colon;</label>
                        <input type="text" class="form-control" id="cognome" placeholder="Inserisci Cognome" name="cognome" required>
                        <div class="valid-feedback">Corretto</div>
                        <div class="invalid-feedback">Cognome non valido&excl;</div>
                    </div>
                    <div class="form-group">
                        <label for="cf">Codice Fiscale&colon;</label>
                        <input type="text" class="form-control" onkeyup="toUpperCase()" id="cf" placeholder="Codice Fiscale" name="cf" required>
                        <div class="valid-feedback">Corretto</div>
                        <div class="invalid-feedback">Codice fiscale non valido&excl;</div>
                    </div>
                    <div class="form-group">
                        <label for="curriculum">Curriculum&colon;</label>
                        <textarea class="form-control" rows="10" cols="48" id="curriculum" placeholder="Inserisci qui il curriculum" name="curriculum" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="foto">Carica Foto&colon;</label>
                        <input id="foto" type="file" name="foto">  
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Nome del partito in cui inserire il candidato&colon; </legend>
                    <label for="partito">Nome&colon;</label>
                        <input id="partito" type="text" name="partito" placeholder="Nome partito" required> 
                </fieldset>
                <button type="submit" class="btn btn-primary">Inserisci</button>
            </form>
        </div>

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