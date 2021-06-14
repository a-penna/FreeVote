<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, gestionePolitiche">
	<meta name="description" content="Gestione Politiche menù">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash;Menu-gestione-politiche</title>
</head>            

<body>
	<%@ include file="admin-header.jsp"%> <!-- Da Completare -->
    
    <h3>Seleziona l'operazione da effettuare&colon;</h3>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/inserisciPartito.jsp")%>">Inserisci un nuovo partito</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/eliminaPartito.jsp")%>">Elimina un partito</a>
    <br>
    <a href="">Elimina un partito da una coalizione</a>
    <br>
    <a href="">Elimina una coalizione</a>
    <br>
    <a href="">Aggiungi un candidato ad un partito</a>
    <br>
    <a href="">Rimuovi un candidato da un partito</a>
    

</body>
</html>