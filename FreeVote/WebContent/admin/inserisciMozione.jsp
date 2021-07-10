<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, inserisci, admin, inserisci mozione, mozione">
	<meta name="description" content="Inserisci Mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Mozione</title>
	<link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
    <script>
        function validate(obj) {	
            var valid = true;	

            var nomeCompleto = document.getElementsByName("nomeCompleto")[0];
            if(!checkNomeCognome(nomeCompleto)) {
                valid = false;
                document.getElementById("nomeError").innerHTML = "Nome non valido!";
            } else {
                document.getElementById("nomeError").innerHTML = "";
            }
            
            if(valid) obj.submit();
        }
    </script>
</head>            
<body>

	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per registare una nuova mozione: <p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciMozione")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
        <fieldset>
        <legend>Informazioni sulla mozione&colon; </legend> <!-- Testo,Nome completo autore-->
        	<label for="nomeCompleto">Nome e cognome dell&apos;autore&colon;</label> 
       	    <input id="nomeCompleto" type="text" name="nomeCompleto" placeholder="Nome e cognome autore" required> 
            <p id="nomeError"></p>
        	<label for="testo">Testo della mozione&colon;</label>
        	<textarea id="testo" name="testo" rows="10" cols="48" placeholder="Inserisci qui il testo della mozione" required></textarea>
			<br>
        </fieldset>
        <input type="submit" value="Crea">
	</form> 

</body>
</html> 