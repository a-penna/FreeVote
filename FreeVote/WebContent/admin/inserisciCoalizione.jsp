<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, inserisci coalizione, coalizione, operazioni admin, inserisci">
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
			count++;
			
			var label = document.createElement("label");
			label.htmlFor = "nomePartito";
			label.appendChild(document.createTextNode("Nome del partito:"));
			divv.appendChild(label);
			
			var element = document.createElement("input");
			element.type = "text";
			element.name = "nomePartito";
			element.placeholder = "Nome del partito";
			element.required = "required";
			divv.appendChild(element);
			
			var input = document.createElement("input");
			input.type = "button";
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
	<p>Inserisci i dati nel seguente form per registare una nuova coalizione: <p>

	<form action="<%=response.encodeURL("/FreeVote/InserisciCoalizione")%>" method="get"> 
        <fieldset>
        <legend>Informazioni sulla coalizione&colon; </legend> 
        	<label for="nome">Nome Coalizione&colon;</label>  
       	    <input id="nome" type="text" class="form-control" name="nomeCoalizione" placeholder="Nome della coalizione" required> 
            <br>
			<div id = "partiti">
				<label>Nome del primo partito&colon; <input type="text" class="form-control" name="nomePartito" placeholder="Nome del primo partito" required> </label>   <!--Inserimento più partiti con javascript da inserire -->
				<label>Nome del secondo partito&colon; <input type="text" class="form-control" name="nomePartito" placeholder="Nome del secondo partito" required> </label>
				<input type="button" value="&plus;" onclick="addPartito()">
			</div>
			<br> 
        </fieldset>
        <button type="submit" class="btn btn-primary">Crea</button>
	</form> 

</body>
</html> 