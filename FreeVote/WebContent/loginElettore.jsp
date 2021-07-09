<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
	
	if(loggedIn) {
		response.sendRedirect(response.encodeRedirectURL("/FreeVote/elettore/schedaVoto.jsp"));
 		return;
	}	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Votazione, login, login elettore, elettore, autenticazione">
	<meta name="description" content="Login Elettore">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		
		$(document).ready(function() {
			$('#regione').change(function() {
				var reg = $(this).val();
				$.ajax({
					url:"ListaComuni?regione=" + reg,
					method:"GET",
				})
				.done(function(msg) {
					$("#comune").html("<option disabled selected>Seleziona Comune</option>");
					var comuni = msg.listaComuni;  
					var c;
					for (c in comuni) {
						var opt = document.createElement("option");
							opt.value = comuni[c];
							$("#comune").append("<option value=" + comuni[c] + ">" + comuni[c] + "</option>");
						}
					})
					.fail(function(xhr, textStatus) {
						alert("Errore");
					});	
					
				});
			});
			
			</script> 
			<title>FreeVote &dash; Login Elettore</title>
</head>            

<body>
	<%@ include file="/header.jsp"%>
    
    <% 
    boolean loggedAsAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;  
    
    if (loggedAsAdmin)  { 
		%><h3>Si prega di effettuare il logout da admin prima di procedere con la normale autenticazione da elettore</h3><%
	} else {
		Collection<?> regioni = (Collection<?>) request.getAttribute("listaRegioni");
    	if (regioni == null) {
        	response.sendRedirect(response.encodeURL("/FreeVote/Elettore"));
        	return;
    	}
	%>
	
	<div class="container-fluid pt-4">  
	    <form action="Elettore" method="post"> 
	        <fieldset>
	            <legend>Inserisci credenziali&colon; </legend>
	            <label for="codice">Codice&colon;</label>
	            <input id="codice" type="text" name="codice" placeholder="inserisci codice"> 
	            <br>   
	            <label for="password">Password&colon;</label>
	            <input id="password" type="password" name="password" placeholder="inserisci codice"> 
	            <br>
	            <label for="eta">Età</label>
	            <input type="number" id="eta" name="eta" min="18" max="130">
	            <br>
	            <input type="radio" id="Maschio" name="sesso" value="M">
	            <label for="male">Maschio</label><br>
	            <input type="radio" id="Femmina" name="sesso" value="F">
	            <label for="female">Femmina</label><br>
	            
	            <label for="regione">Regioni&colon; </label>
	            <select name="regione" id="regione">
	            	<option disabled selected>Seleziona Regione</option>
					<%
					Iterator<?> it = regioni.iterator();
					while(it.hasNext()) {
						String regione = (String)it.next(); 
					%>
					<option value="<%=regione%>"><%=regione%></option>
					<%  } 
					%>
				</select> 
					            
	            <label for="comune">Comuni&colon; </label>
				<select name="comune" id="comune">
					<option disabled selected>Seleziona Comune</option>
		
				</select>

				<br>
				<label for="cap">Cap&colon;</label>
				<input id="cap" type="text" name="cap" placeholder="CAP"> 
				<br>
				<input type="submit" value="Login"/>
			</fieldset>
	    </form> 
	</div>
<%} %>
</body>
</html> 