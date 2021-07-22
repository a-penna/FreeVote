<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci partito in una coalizione, operazioni admin, partito, coalizione, inserisci partito, inserisci">
		<meta name="description" content="Inserisci partito in una coalizione">
		<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
		<title>FreeVote &dash; Inserisci Partito in Coalizione</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
		<!-- jQuery library --> 
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
		<!-- Popper JS --> 
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
		<!-- Latest compiled JavaScript --> 
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script>
	        function validate(obj) {	
	            var valid = true;	
				
	            var name = document.getElementsByName("nome")[0];
	            if(name.value.trim() == "") {
	                valid = false;
	                name.classList.add("is-invalid");
	                name.focus();
	            } else {
	            	name.classList.remove("is-invalid");
	            }
	            
	            var nomeCoalizione = document.getElementsByName("coalizione")[0];
	            if(nomeCoalizione.value.trim() == "") {
	                valid = false;
	                nomeCoalizione.classList.add("is-invalid");
	                nomeCoalizione.focus();
	            } else {
	            	nomeCoalizione.classList.remove("is-invalid");
	            }
	            
	            if(valid) obj.submit();
	        }
	        
	        function firstFocus() {	
	            var name = document.getElementsByName("nome")[0];
	            name.focus();
	        }
	        
	        window.onload = firstFocus;
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
					<p>Inserisci i dati nel seguente form per inserire un partito in una coalizione&period; Sia il partito che la coalizione devono essere gi&agrave; registrati sulla piattaforma&period;<p>
					<form action="<%=response.encodeURL(request.getContextPath() + "/InserisciPartitoCoalizione")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
					        <fieldset>
								<div class="form-group">
						        	<label for="nome">Nome Partito&colon;</label>
						       	    <input id="nome" class="form-control" type="text" name="nome" placeholder="Nome partito">
			                    <div class="invalid-feedback">Inserire il nome del partito&excl;</div> 
								</div>
								<div class="form-group">
						        	<label for="coalizione">Nome Coalizione&colon;</label>
						            <input id="coalizione" class="form-control" type="text" name="coalizione" placeholder="Nome coalizione"> 
			                   		<div class="invalid-feedback">Inserisci il nome della coalizione&excl;</div>
						        </div>
					        </fieldset>
					        <button type="submit" class="btn btn-primary">Inserisci</button>
					</form> 
				</div>
			</div>
		</div>
	</body>
</html> 