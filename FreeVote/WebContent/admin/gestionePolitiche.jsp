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
	<%@ include file="admin-header.jsp"%> <!-- Da Completare -->
    
    <h3>Seleziona l'operazione da effettuare&colon;</h3>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/inserisciPartito.jsp")%>">Inserisci un nuovo partito</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/eliminaPartito.jsp")%>">Elimina un partito</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/inserisciPartitoCoalizione.jsp")%>">Inserisci un partito in una coalizione</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/eliminaPartitoCoalizione.jsp")%>">Elimina un partito da una coalizione</a> 
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/inserisciCoalizione.jsp")%>">Crea una coalizione</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/eliminaCoalizione.jsp")%>">Elimina una coalizione</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/inserisciCandidato.jsp")%>">Aggiungi un candidato ad un partito</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/eliminaCandidato.jsp")%>">Rimuovi un candidato da un partito</a>
    

</body>
</html>