<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online">
	<meta name="description" content="Piattaforma voto">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">
    <title>FreeVote &dash; HomePage</title>
    <!-- <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css"> -->
    
</head>            

<body>
	<%@ include file="header.jsp"%>
    <br/>
    <a href="<%=response.encodeURL("/FreeVote/Elettore")%>">Vota</a>
      <section id="home">
      <h1>Welcome To Our Site</h1>
      <p> "Descrizione" </p>
      </section>
      <section id="partiti">
      <h1>Partiti</h1>
      <p> "Descrizione" </p>
      </section>
      <section id="referendum">
      <h1>Referendum</h1>
      <p> "Descrizione" </p>
      </section>
      <section id="risultati">
      <h1>Risultati</h1>
      <p> "Descrizione" </p>
      </section>
      <section id="info">
      <h1>Info e Contatti</h1>
      <p> "Descrizione" </p>
      </section>
      <section id="statistiche">
      <h1>Statistiche Live</h1>
      <p> "Descrizione" </p>
      </section>

</body>
</html>

