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
	<title>FreeVote &dash; Login Elettore</title>
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
	
	<div class="container py-4">  
	    <form action="Elettore" method="post"> 
	        <fieldset>
	            <legend>Inserisci credenziali&colon; </legend>
				<div class="form-group">
		            <label for="codice">Codice&colon;</label>
		            <input id="codice" type="text" class="form-control" name="codice" placeholder="inserisci codice" required> 
		        </div>   
	            <div class="form-group">
		            <label for="password">Password&colon;</label>
		            <input id="password" type="password" class="form-control" name="password" placeholder="inserisci password" required> 
		        </div>
	            <div class="form-group">
		            <label for="eta">Età&colon;</label>
		            <input type="number" id="eta" name="eta" class="form-control" placeholder="Et&agrave;" min="18" max="130" required>
		        </div>
	            <div class="form-group">
		            <input type="radio" id="Maschio" name="sesso" value="M" required>
		            <label for="male">Maschio</label><br>
		            <input type="radio" id="Femmina" name="sesso" value="F" required>
		            <label for="female">Femmina</label><br>
		        </div>
	            <div class="form-group">
		            <label for="regione">Regioni&colon; </label>
		            <select name="regione" class="form-control" id="regione" required>
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
				</div> 
				<div class="form-group">
		            <label for="comune">Comuni&colon; </label>
					<select name="comune" id="comune" class="form-control" required>
						<option disabled selected>Seleziona Comune</option>
					</select>
				</div>
				<div class="form-group">
					<label for="cap">Cap&colon;</label>
					<input id="cap" type="text" class="form-control" name="cap" placeholder="CAP" required> 
				</div>
				<input type="submit" class="btn btn-primary" value="Login"/>
			</fieldset>
	    </form> 
	</div>
<%} %>
</body>
</html> 