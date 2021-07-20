<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, gestione referendum, admin, referendum, gestione">
	<meta name="description" content="Menù Gestione Referendum">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Men&ugrave; Gestione Referendum</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
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
	<%@ include file="admin-header.jsp"%>
    <div class="container-fluid py-5">
	    <h3>Seleziona l'operazione da effettuare&colon;</h3>
	    <div class="list-group">
		  <a href="<%=response.encodeURL(request.getContextPath() + "/InserisciMozione")%>" class="list-group-item list-group-item-action">Aggiungi una mozione</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaMozione.jsp")%>" class="list-group-item list-group-item-action">Rimuovi una mozione</a>
		</div>
	</div>
</body>
</html>