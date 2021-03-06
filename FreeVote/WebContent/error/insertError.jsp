<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">
	<title>FreeVote &dash; Errore</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="bg-danger">
	<%@ include file="/header.jsp"%>
	<div class="container py-5">
		<div class="alert alert-danger text-center" role="alert">
		  <h1 class="alert-heading">ERRORE&excl;</h1>
		  <p> Errore nell&apos;inserimento dei dati all'interno del database</p>
		  <hr>
		   <p class="mb-0">Probabilmente i dati sono formattati in modo errato</p>
		</div>
	</div>
	<div class="container">
		<img class="mx-auto d-block img-fluid" src="<%=request.getContextPath()%>/imgs/voteX.png" height="450" width="425">
	</div>
	<br>
</body>
</html>