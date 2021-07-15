<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
	
	if(loggedIn) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/elettore/schedaVoto.jsp"));
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
	<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
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
	    function validate(obj) {	
	        var valid = true;	

	        var regione = document.getElementsByName("regione")[0];
            if (regione.value == "Seleziona Regione") {
            	valid = false;
            	regione.classList.add("is-invalid");
            } else {
            	 regione.classList.remove("is-invalid");
            }
	        
	        var comune = document.getElementsByName("comune")[0];
            if (comune.value == "Seleziona Comune") {
            	valid = false;
            	comune.classList.add("is-invalid");
            } else {
            	 comune.classList.remove("is-invalid");
            }
            
	        var eta = document.getElementsByName("eta")[0];
	        if(!checkEta(eta)) {
	            valid = false;
	            eta.classList.add("is-invalid");
	        } else {
	        	 eta.classList.remove("is-invalid");
	        }
	        
	        var cap = document.getElementsByName("cap")[0];
	        if(!checkCAP(cap)) {
	            valid = false;
	            cap.classList.add("is-invalid");
	        } else {
	        	 cap.classList.remove("is-invalid");
	        }
	
	        if(valid) obj.submit();
	    }
    
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
	
	<div class="container py-5">  
    
    <% 
    boolean loggedAsAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;  
    
    if (loggedAsAdmin)  { 
		%><h3>Si prega di effettuare il logout da admin prima di procedere con la normale autenticazione da elettore</h3><%
	} else {
		Collection<?> regioni = (Collection<?>) request.getAttribute("listaRegioni");
    	if (regioni == null) {
        	response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Elettore"));
        	return;
    	}
	%>
	    <form action="Elettore" method="post" onsubmit="event.preventDefault(); validate(this)"> 
	        <fieldset>
	            <legend>Inserisci credenziali&colon; </legend>
				<div class="form-group">
		            <label for="codice">Codice&colon;</label>
		           		<%
							if (request.getAttribute("erroreCredenziali") != null) {
								%><input type="text" class="form-control is-invalid" id="codice" placeholder="Inserisci codice" value="<%=request.getAttribute("codice")%>" name="codice" required><% 
							} else if (request.getAttribute("codice") != null) {
								%><input type="text" class="form-control" id="codice" placeholder="Inserisci codice" value="<%=request.getAttribute("codice")%>" name="codice" required><% 
							} else {
								%><input type="text" class="form-control" id="codice" placeholder="Inserisci codice" name="codice" required><% 
							}
						%>
		        </div>   
	            <div class="form-group">
		            <label for="password">Password&colon;</label>
		            	<%
							if (request.getAttribute("erroreCredenziali") != null) {
								%><input type="password" class="form-control is-invalid" id="password" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password" required><% 
							} else if (request.getAttribute("password") != null) {
								%><input type="password" class="form-control" id="password" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password" required><% 
							} else {
								%><input type="password" class="form-control" id="password" placeholder="Inserisci password" name="password" required><% 
							}
						%>
	                    <div class="invalid-feedback">Nome utente o password errati&excl;</div> 
		        </div>
	            <div class="form-group">
		            <label for="eta">Età&colon;</label>
			    <%
			   		if (request.getAttribute("erroreEta") != null) {
						%><input type="number" class="form-control is-invalid" id="eta" name="eta" placeholder="Et&agrave;" min="18" max="130" value="<%=request.getAttribute("eta")%>" required><% 
					} else if (request.getAttribute("eta") != null) {
						%><input type="number" class="form-control" id="eta" name="eta" min="18" max="130" placeholder="Et&agrave;" value="<%=request.getAttribute("eta")%>" required><% 
					} else {
						%><input type="number" class="form-control" id="eta" name="eta" placeholder="Et&agrave;" min="18" max="130" required><% 
					}
				%>
			    <div class="invalid-feedback">Et&agrave; non corretta&excl; Ricorda che il sistema ammette solo un&apos;et&agrave; compresa tra 18 e 130</div>
		        </div>
	            <div class="form-group">
	               <%
	               	String sesso = (String)request.getAttribute("sesso");
					if (sesso != null && sesso.equals("M")) {
						%>
		           		  <input type="radio" id="maschio" name="sesso" value="M" required checked>
						  <label for="maschio">Maschio</label><br>
		           		  <input type="radio" id="femmina" name="sesso" value="F" required>
		            	  <label for="femmina">Femmina</label><br>
						<% 
					} else if (sesso != null && sesso.equals("F")) { %>
		           		 	<input type="radio" id="maschio" name="sesso" value="M" required>
							<label for="maschio">Maschio</label><br>
		           		 	<input type="radio" id="femmina" name="sesso" value="F" required checked>
		            	  	<label for="femmina">Femmina</label><br>
					<% 
					} else {
					%>  
				        <input type="radio" id="maschio" name="sesso" value="M" required>
				        <label for="maschio">Maschio</label><br>
				        <input type="radio" id="femmina" name="sesso" value="F" required>
				        <label for="femmina">Femmina</label><br> <%
					}
				%>
		            
		        </div>
	            <div class="form-group">
		            <label for="regione">Regioni&colon; </label>
	            	 <%
						if (request.getAttribute("error") != null) { %>
							<select name="regione" class="custom-select is-invalid" id="regione" required>
				            	<option disabled selected>Seleziona Regione</option>
								<%
								Iterator<?> it = regioni.iterator();
								while(it.hasNext()) {
									String regione = (String)it.next(); 
									%>
									<option value="<%=regione%>"><%=regione%></option>
								<%
								}
								%>
							</select>
					 <%	} else {
		        	 %>		<select name="regione" class="custom-select" id="regione" required>
				            	<option disabled selected>Seleziona Regione</option>
								<%
								Iterator<?> it = regioni.iterator();
								while(it.hasNext()) {
									String regione = (String)it.next(); 
									%>
									<option value="<%=regione%>"><%=regione%></option>
								<%
								}
								%>
							</select>
			        	
			        <% } %>
		            
					<div class="invalid-feedback">Controlla la tua regione&excl;</div>
				</div> 
				<div class="form-group">
		            <label for="comune">Comuni&colon; </label>
		              <%
						if (request.getAttribute("error") != null) { %>
							<select name="comune" id="comune" class="custom-select is-invalid" required>
								<option disabled selected>Seleziona Comune</option>
							</select>
							
					 <%	} else {
		        	 %>		
							<select name="comune" id="comune" class="custom-select" required>
								<option disabled selected>Seleziona Comune</option>
							</select>	        	
			        <% } %>
					<div class="invalid-feedback">Controlla il tuo comune&excl;</div>
				</div>
				<div class="form-group">
					<label for="cap">CAP&colon;</label>
						<%
							if (request.getAttribute("erroreCap") != null) {
								%><input type="text" class="form-control is-invalid" id="cap" placeholder="CAP" value="<%=request.getAttribute("cap")%>" name="cap" required><% 
							} else if (request.getAttribute("codice") != null) {
								%><input type="text" class="form-control" id="cap" placeholder="CAP" value="<%=request.getAttribute("cap")%>" name="cap" required><% 
							} else {
								%><input type="text" class="form-control" id="cap" placeholder="CAP" name="cap" required><% 
							}
						%> 
						 <div class="invalid-feedback">Il CAP inserito non corrisponde con il comune indicato&excl;</div> 
				</div>
				<input type="submit" class="btn btn-primary" value="Login"/>
			</fieldset>
	    </form> 
	</div>
<%} %>
</body>
</html> 