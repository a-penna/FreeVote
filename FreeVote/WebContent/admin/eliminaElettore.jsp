 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, admin, elimina, elettore, Elimina Elettore">
	<meta name="description" content="Elimina elettore">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Elimina Elettore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>            

<body class="bg-light">
	<%@ include file="/admin/admin-header.jsp"%>
    <div class="container-fluid py-5">
	    <form action="<%=response.encodeURL("/FreeVote/EliminazioneElettore")%>" method="post"> 
	    	<div class="form-group">
		        <fieldset>
		            <legend>Inserisci credenziali&colon; </legend>
		            <label for="codice">Codice&colon;</label>
		            <input id="codice" type="text" class="form-control" name="codice" placeholder="inserisci codice" required> 
		            <br>
		            <button type="submit" class="btn btn-primary">Elimina</button>
		       </fieldset>
	    	</div>
		</form> 
    </div>

</body>
</html> 