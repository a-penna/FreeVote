<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, gestionePolitiche">
	<meta name="description" content="Gestione Politiche menù">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Men&ugrave; gestione politiche</title>
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