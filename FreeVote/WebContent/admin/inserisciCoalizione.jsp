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
       	    <input id="nome" type="text" name="nomeCoalizione" placeholder="Nome della coalizione" required> 
            <br>
			<div id = "partiti">
				<label>Nome del primo partito&colon; <input type="text" name="nomePartito" placeholder="Nome del primo partito" required> </label>   <!--Inserimento più partiti con javascript da inserire -->
				<label>Nome del secondo partito&colon; <input type="text" name="nomePartito" placeholder="Nome del secondo partito" required> </label>
				<input type="button" value="&plus;" onclick="addPartito()">
			</div>
			<br> 
        </fieldset>
        <input id="submit" type="submit" value="Crea">
	</form> 

</body>
</html> 