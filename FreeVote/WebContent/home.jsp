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
	<img src="/FreeVote/imgs/illustrazione-banner.jpeg" class="img-fluid" alt="responsive image">
</header>

<section class="sezione-icone bg-light text-center">
	<div class="container">
		<div class="row py-5">
			<div class="col-lg-4">
				<div class="mb-5">
					<i class="bi bi-shield-check"></i>
					<h3>Sicuro</h3>
					<p class="lead mb-0">FreeVote &egrave; sicuro ed efficace, rispetta la privacy ed &egrave; amministrato nel modo pi&ugrave; trasparente possibile</p>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="mb-5">
					<i class="bi bi-arrow-down-circle-fill"></i>
					<h3>Facile da usare</h3>
					<p class="lead mb-0">Grazie alla grafica interattiva e alla dinamicit&agrave; il sito risulta di semplice utilizzo</p>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="mb-5">
					<i class="bi bi-clock"></i>
					<h3>Online 24/7</h3>
					<p class="lead mb-0">FreeVote rester&agrave; sempre attivo per consultare i risultati anche dopo la fine delle votazioni</p>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="sezione-immagini">
	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<div class="col-lg-6 order-lg-2 immagine" style="background-image: url('./imgs/partito.jpg');background-size: cover;background-position:center;">
			</div>
			<div class="col-lg-6 order-lg-1">
				<div class="bg-light mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center">
       				 <div class="my-3 p-3">
          				<h2 class="display-5">Partiti</h2>
         				 <p class="lead">Permette all'elettore di visionare le informazioni di base sui partiti e sui candidati che ne fanno parte.
         				 Sarà possibile valutare le proposte elettorali avanzate dai vari partiti, al fine di effettuare
         				 una votazione più consapevole</p>
        			</div>
      	   		</div>
      		</div>
		</div>
		<div class="row no-gutters">
			<div class="col-lg-6 immagine" style="background-image: url('./imgs/referendum.jpg');background-size: cover;background-position:center;"></div>
			<div class="col-lg-6 order-lg-1">
				<div class="bg-light mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center">
       				 <div class="my-3 p-3">
          				<h2 class="display-5">Referendum</h2>
         				 <p class="lead">All'interno di questa sezione l'elettore avrà la possibilità di visionare il testo
         				 della mozione per il referendum costituzionale confermativo/abrogativo in atto, favorendo
         				 una scelta mirata</p>
        			</div>
      	   		</div>
      		</div>
		</div>
		<div class="row no-gutters">
			<div class="col-lg-6 order-lg-2 immagine" style="background-image: url('./imgs/risultati1.jpg');background-size: cover;background-position:center;"></div>
			<div class="col-lg-6 order-lg-1">
				<div class="bg-light mr-md-3 pt-3 px-3 pt-md-5 px-md-5 text-center">
       				 <div class="my-3 p-3">
          				<h2 class="display-5">Risultati</h2>
         				 <p class="lead">Una volta terminata la votazione, i risultati vengono immediatamente recepiti.
         				 L'elettore portà visualizzare i risultati in tempo reale insieme a vari report sull'attività di voto</p>
        			</div>
      	   		</div>
      		</div>
		</div>
	</div>
	</section> 
    <br>
    <%@ include file="footer.jsp"%>
</body>


</html>