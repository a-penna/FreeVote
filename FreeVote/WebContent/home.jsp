<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online">
	<meta name="description" content="Piattaforma voto">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; HomePage</title>
    <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
</head>            

<body>
	<%@ include file="header.jsp"%>
    <br/>
    <a href="<%=response.encodeURL("/FreeVote/Elettore")%>">Vota</a>
    <div class= "container">
      <nav class="navbar">
      	<ul>
      		<li><a href="#home">HOME</a></li>
            <li><a href="#partiti">PARTITI</a></li>
      		<li><a href="#referendum">REFERENDUM</a></li>
      		<li><a href="#risultati">RISULTATI</a></li>
      		<li><a href="#info">INFO E CONTATTI</a></li>
      		<li><a href="#statistiche">STATISTICHE LIVE</a></li>
      	</ul>
      </nav>
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
     </div>

</body>
</html>

