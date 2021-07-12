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
	<link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script>
		var count = 3;
		
		function addPartito()  {
			var container = document.getElementById("partiti");
		
			var divv = document.createElement("div");
			divv.id = "id"+count;
			divv.classList.add("form-row");
			count++;
			
			var label = document.createElement("label");
			label.htmlFor = "nomePartito";
			label.appendChild(document.createTextNode("Nome del partito:"));
			divv.appendChild(label);
			
			var element = document.createElement("input");
			element.type = "text";
			element.classList.add("form-control");
			element.name = "nomePartito";
			element.placeholder = "Nome del partito";
			element.required = "required";
			divv.appendChild(element);
			
		    var input = document.createElement("input");
	        input.type = "button";
			input.classList.add("btn");
			input.classList.add("btn-primary");
			input.classList.add("mb-2");
	        input.value = "-";
	        input.addEventListener("click", function() {removePartito(divv.id)});
	        divv.appendChild(input);
			
			container.appendChild(divv);
		}
		 
		function removePartito(idd) {
			var element = document.getElementById(idd);
			element.parentNode.removeChild(element);
		}
	</script>

</head>            
<body>

	<%@ include file="/admin/admin-header.jsp"%>
	<div class="container py-4">
		<p>Inserisci i dati nel seguente form per registare una nuova coalizione: <p>
		<form action="<%=response.encodeURL("/FreeVote/InserisciCoalizione")%>" method="get">
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
								<div class="col-xl-10">
									<label for="partito2">Nome del secondo partito&colon;</label>
									<input type="text" id="partito2" class="form-control" name="nomePartito" placeholder="Nome del secondo partito" required>
								</div>
								<div class="col-xl-2">
						 			<input type="button" class="btn btn-primary" value="&plus;" onclick="addPartito()"> 
						 		</div>
							</div>
						</div>
		        </fieldset>
		        <button type="submit" class="btn btn-primary">Crea</button>    
		</form> 
	</div>

</body>
</html> 