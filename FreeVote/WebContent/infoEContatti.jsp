<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, info, info e contatti, contatti, email, sviluppatori, devs">
	<meta name="description" content="Info e Contatti">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">  
	<title>FreeVote &dash; Info e Contatti</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="bg-light">
	<%@ include file="header.jsp"%>
	<br>
	
	<section class="autori text-center bg-light">
	<div class="container-fluid">
	<div class="row">
			<div class="col-lg-3">
				<div class="email mx-auto mb-5 mb-lg-0">
						<br>
						<img class="img-fluid roundend-circle mb-3" src="<%=request.getContextPath()%>/imgs/sabato.jpeg" height="225" width="225" alt="Foto autore">
						<h5>Sabato Bene</h5>
						<p class="font-weight-light mb-0">s.bene@studenti.unisa.it</p>
				</div>	
			</div>
			<div class="col-lg-3">
				<div class="email mx-auto mb-5 mb-lg-0">
					<img class="img-fluid roundend-circle mb-3" src="<%=request.getContextPath()%>/imgs/lidia.jpeg" height="225" width="225" alt="Foto autore">
					<h5>Lidia Cozzolino</h5>
					<p class="font-weight-light mb-0">l.cozzolino13@studenti.unisa.it</p>
				</div>	
			</div>
			<div class="col-lg-3">
				<div class="email mx-auto mb-5 mb-lg-0">
					<img class="img-fluid roundend-circle mb-3" src="<%=request.getContextPath()%>/imgs/riccardo.jpeg" height="225" width="225" alt="Foto autore">
					<h5>Riccardo Napoli</h5>
					<p class="font-weight-light mb-0">r.napoli37@studenti.unisa.it</p>
				</div>	
			</div>
			<div class="col-lg-3">
				<div class="email mx-auto mb-5 mb-lg-0">
					<img class="img-fluid roundend-circle mb-3" src="<%=request.getContextPath()%>/imgs/alessandro.jpeg" height="225" width="225" alt="Foto autore">
					<h5>Alessandro Penna</h5>
					<p class="font-weight-light mb-0">a.penna12@studenti.unisa.it</p>
				</div>	
			</div>
		</div>
</div>					
</section>
</body>
</html>