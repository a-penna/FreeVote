<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, gestioneReferendum">
	<meta name="description" content="Gestione Referendum menù">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash;Menu gestione referendum</title>
   
</head>            

<body>
	<%@ include file="admin-header.jsp"%> <!-- Da Completare -->
    
    <h3>Seleziona l'operazione da effettuare&colon;</h3>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/InserisciMozione")%>">Aggiungi una mozione</a>
    <br>
    <a href="<%=response.encodeURL("/FreeVote/admin/eliminaMozione.jsp")%>">Rimuovi una mozione</a>
    <br>

</body>
</html>