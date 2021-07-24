<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, gestione politiche, politiche, votazioni, admin">
	<meta name="description" content="Menù Gestione Politiche">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Men&ugrave; Gestione Politiche</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
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
	    <h6>Seleziona l'operazione da effettuare&colon;</h6>
	    <div class="list-group">
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciPartito.jsp")%>" class="list-group-item list-group-item-action"> Inserisci un nuovo partito</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaPartito.jsp")%>" class="list-group-item list-group-item-action">Elimina un partito</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciPartitoCoalizione.jsp")%>" class="list-group-item list-group-item-action">Inserisci un partito in una coalizione</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaPartitoCoalizione.jsp")%>" class="list-group-item list-group-item-action">Elimina un partito da una coalizione</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciCoalizione.jsp")%>" class="list-group-item list-group-item-action">Crea una coalizione</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaCoalizione.jsp")%>" class="list-group-item list-group-item-action">Elimina una coalizione</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciCandidato.jsp")%>" class="list-group-item list-group-item-action">Aggiungi un candidato ad un partito</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaCandidato.jsp")%>" class="list-group-item list-group-item-action">Rimuovi un candidato da un partito</a>
		</div>
	</div>
</body>
</html>