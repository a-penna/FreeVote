<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci coalizione, coalizione, operazioni admin, inserisci, admin">
	<meta name="description" content="Inserisci Coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Coalizione</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css"href="<%=request.getContextPath()%>/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
		$(document).ready(function() {
			var count = 3;
			$("#add").click(function(){
				$("#partiti").append('<div class="row form-group align-items-end" id="div'+ count +'"> \n\
										<div class="col-10"> \n\
											<label for="partito'+ count +'">Nome del partito&colon;</label> \n\
												<input type="text" id="partito'+ count +'" class="form-control" name="nomePartito" placeholder="Nome del partito" required> \n\
										</div> \n\
										<div class="col-2"> \n\
	 										<input type="button" id="'+count+'" class="btn btn-dark rimuovi_btn" value="-"> \n\
	 									</div> \n\
									</div>');
				count++;
			});
			
			$(document).on('click', '.rimuovi_btn', function(){
				var identificatore = $(this).attr("id");
				$("#div"+ identificatore +"").remove();
			});
		});
	</script>

</head>            
<body class="bg-light">

	<%@ include file="/admin/admin-header.jsp"%>
	<div class="container-fluid py-5">
		<div class="row">
			<div class="col-md-2">
				<%@ include file="/admin/politicheMenu.jsp" %>
			</div>
			<div class="col-md-10">
				<p>Inserisci i dati nel seguente form per registare una nuova coalizione &lpar;<strong>Ricorda che i partiti scelti devono essere gi&agrave; registrati sulla piattaforma&excl;</strong>&rpar;
				 <p>
				<form action="<%=response.encodeURL(request.getContextPath() + "/InserisciCoalizione")%>" method="post">
				        <fieldset>
				        	<legend>Informazioni sulla coalizione&colon; </legend> 
							<div class="form-group"> 
					        	<label for="nome">Nome Coalizione&colon;</label>  
					       	    <input id="nome" type="text" class="form-control" name="nomeCoalizione" placeholder="Nome della coalizione" required> 
					 		</div>
								<div id = "partiti">
									<div class="form-group">
										<label for="partito1">Nome del primo partito&colon;</label>
										<input type="text" id="partito1" class="form-control" name="nomePartito" placeholder="Nome del primo partito" required>
									</div>
									<div class="row form-group align-items-end">
										<div class="col-10">
											<label for="partito2">Nome del secondo partito&colon;</label>
											<input type="text" id="partito2" class="form-control" name="nomePartito" placeholder="Nome del secondo partito" required>
										</div>
										<div class="col-2">
								 			<input type="button" id="add" class="btn btn-dark" value="&plus;"> 
								 		</div>
									</div>
								</div>
								<% if(request.getAttribute("error") != null) { %>
									<div class="alert alert-danger alert-dismissible fade show" role="alert">
									  <strong>Errore&excl;</strong> Non &egrave; stato possibile completare l'operazione con i dati inseriti, riprovare&excl;
									  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
									    <span aria-hidden="true">&times;</span>
									  </button>
									</div>
								<% } %>
				        </fieldset>
				        <button type="submit" class="btn btn-primary">Crea</button>    
				</form> 
			</div>
		</div>
	</div>

</body>
</html> 