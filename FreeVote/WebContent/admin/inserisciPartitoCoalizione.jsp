
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci partito in una coalizione, operazioni admin, partito, coalizione, inserisci partito, inserisci">
		<meta name="description" content="Inserisci partito in una coalizione">
		<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
		<title>FreeVote &dash; Inserisci Partito in Coalizione</title>
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
	<body>
		<%@ include file="/admin/admin-header.jsp"%>
		<div class="container py-4">
			<p>Inserisci i dati nel seguente form per inserire un partito in una coalizione&period; Sia il partito che la coalizione devono essere gi&agrave; presenti nel database&period;<p>
			<form action="<%=response.encodeURL("/FreeVote/InserisciPartitoCoalizione")%>" method="post"> 
			        <fieldset>
						<div class="form-group">
				        	<label for="nome">Nome Partito&colon;</label>
				       	    <input id="nome" class="form-control" type="text" name="nome" placeholder="Nome partito" required> 
						</div>
						<div class="form-group">
				        	<label for="coalizione">Nome Coalizione&colon;</label>
				            <input id="coalizione" class="form-control" type="text" name="coalizione" placeholder="Nome coalizione" required> 
				        </div>
			        </fieldset>
			        <button type="submit" class="btn btn-primary">Inserisci</button>
			</form> 
		</div>
	</body>
</html> 