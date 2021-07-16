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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css">						
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
	
</head>
<body class="bg-light">

	<%@ include file="header.jsp"%>
<header class="head-banner">
	<img src="/FreeVote/imgs/illustrazione freevote 1.jpg" class="img-fluid" alt="Responsive image">
</header>

<section class="sezione-icone bg-light text-center">
	<div class="container">
		<div class="row">
			<div class="col-lg-4">
				<div class="mb-5">
					<i class="bi bi-shield-check"></i>
					<h3>Sicuro</h3>
					<p class="lead mb-0">Il nostro sito web è sicuro ed efficace, rispetta la privacy ed è amministrato nel modo più trasparente possibile</p>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="mb-5">
					<i class="bi bi-arrow-down-circle-fill"></i>
					<h3>Facile da usare</h3>
					<p class="lead mb-0">Grazie alla grafica interattiva e alla dinamicità il sito risulta di semplice utilizzo</p>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="mb-5">
					<i class="bi bi-clock"></i>
					<h3>Online 24/7h</h3>
					<p class="lead mb-0">Il sito web resterà sempre attivo per consultare i risultati anche dopo la fine delle votazioni</p>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="sezione-immagini">
	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<div class="col-lg-6 order-lg-2 immagine" style="background-color: #000;"></div>
			<div class="col-lg-6 order-lg-1"><p>Paragrafo Partiti</p></div>
		</div>
		<div class="row no-gutters">
			<div class="col-lg-6 immagine" style="background-color: #000;"></div>
			<div class="col-lg-6"><p>Paragrafo Referendum</p></div>
		</div>
		<div class="row no-gutters">
			<div class="col-lg-6 order-lg-2 immagine" style="background-color: #000;"></div>
			<div class="col-lg-6 order-lg-1"><p>Paragrafo Risultati</p></div>
		</div>
	</div>
	</section> 
    <br>
    <div class="container py-4" align="center">
    <a href="<%=response.encodeURL("/FreeVote/Elettore")%>" class="btn btn-success btn-lg">Vota</a>
    </div>
    <%@ include file="footer.jsp"%>
</body>


</html>