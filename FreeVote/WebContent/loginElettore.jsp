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
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Votazione, login, login elettore, elettore, autenticazione, autenticazione elettore">
	<meta name="description" content="Login Elettore">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Login Elettore</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/script.js"></script>
	<!-- Latest compiled and minified CSS --> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
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

	        var login = document.getElementsByName("codice")[0];
            var pass = document.getElementsByName("password")[0];
            if((login.value.trim() == "") || (pass.value.trim() == "")) {
                valid = false;
                login.classList.add("is-invalid");
                login.focus();
                pass.classList.add("is-invalid");
            } else {
            	login.classList.remove("is-invalid");
            	pass.classList.remove("is-invalid");
            }
            
	        var age = document.getElementsByName("eta")[0];
	        if(!checkEta(age)) {
	            valid = false;
	            age.classList.add("is-invalid");
	            age.focus();
	        } else {
	        	 age.classList.remove("is-invalid");
	        }
            
            var genderM = document.getElementsByName("sesso")[0];
            var genderF = document.getElementsByName("sesso")[1];
            if(!genderM.checked && !genderF.checked) {
                valid = false;
                genderM.classList.add("is-invalid");
                genderM.focus();
                genderF.classList.add("is-invalid");
            } else {
            	genderM.classList.remove("is-invalid");
            	genderF.classList.remove("is-invalid");
            }
	        
	        var reg = document.getElementsByName("regione")[0];
            if (reg.value == "Seleziona Regione") {
            	valid = false;
            	reg.classList.add("is-invalid");
            	reg.focus();
            } else {
            	 reg.classList.remove("is-invalid");
            }
	        
	        var com = document.getElementsByName("comune")[0];
            if (com.value == "Seleziona Comune") {
            	valid = false;
            	com.classList.add("is-invalid");
            } else {
            	 com.classList.remove("is-invalid");
            }
	        
	        var c = document.getElementsByName("cap")[0];
	        if(!checkCAP(c)) {
	            valid = false;
	            c.classList.add("is-invalid");
	            c.focus();
	        } else {
	        	 c.classList.remove("is-invalid");
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
					var comuni = msg.listaComuni;  //listacomuni è un array json
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
    	<div class="card bg-light mb-3">
  			<div class="card-header text-white bg-dark">Login</div>
  			<div class="card-body">
    			<h4 class="card-title">Inserisci credenziali&colon;</h4>
		    <form action="Elettore" method="post" onsubmit="event.preventDefault(); validate(this)"> 
		        <fieldset>
					<div class="form-group">
			            <label for="codice">Codice&colon;</label>
						 <div class="input-group">
					        <div class="input-group-prepend">
					          <span class="input-group-text" id="inputGroupPrepend1">
					          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
									<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>									
								</svg>
							  </span>
					        </div>
			           		<%
								if (request.getAttribute("erroreCredenziali") != null) {
									%><input type="text" class="form-control is-invalid" id="codice" placeholder="Inserisci codice" value="<%=request.getAttribute("codice")%>" name="codice"><% 
								} else if (request.getAttribute("codice") != null) {
									%><input type="text" class="form-control" id="codice" placeholder="Inserisci codice" value="<%=request.getAttribute("codice")%>" name="codice"><% 
								} else {
									%><input type="text" class="form-control" id="codice" placeholder="Inserisci codice" name="codice"><% 
								}
							%>
					 </div>
			        </div>   
		            <div class="form-group">
			            <label for="password">Password&colon;</label>
			            	<div class="input-group">
					        <div class="input-group-prepend">
					          	<span class="input-group-text" id="inputGroupPrepend2">
					          		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
										<path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
									</svg>
								</span>
					        </div>
			            	<%
								if (request.getAttribute("erroreCredenziali") != null) {
									%><input type="password" class="form-control is-invalid" id="password" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password"><% 
								} else if (request.getAttribute("password") != null) {
									%><input type="password" class="form-control" id="password" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password"><% 
								} else {
									%><input type="password" class="form-control" id="password" placeholder="Inserisci password" name="password"><% 
								}
							%>
		                    <div class="invalid-feedback">Nome utente o password errati&excl;</div> 
			        	</div>
			        </div>
		            <div class="form-group">
			            <label for="eta">Età&colon;</label>
			            <div class="input-group">
					        <div class="input-group-prepend">
					          <span class="input-group-text" id="inputGroupPrepend3">
					          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-numeric-up" viewBox="0 0 16 16">
								  <path d="M12.438 1.668V7H11.39V2.684h-.051l-1.211.859v-.969l1.262-.906h1.046z"/>
								  <path fill-rule="evenodd" d="M11.36 14.098c-1.137 0-1.708-.657-1.762-1.278h1.004c.058.223.343.45.773.45.824 0 1.164-.829 1.133-1.856h-.059c-.148.39-.57.742-1.261.742-.91 0-1.72-.613-1.72-1.758 0-1.148.848-1.835 1.973-1.835 1.09 0 2.063.636 2.063 2.687 0 1.867-.723 2.848-2.145 2.848zm.062-2.735c.504 0 .933-.336.933-.972 0-.633-.398-1.008-.94-1.008-.52 0-.927.375-.927 1 0 .64.418.98.934.98z"/>
								  <path d="M4.5 13.5a.5.5 0 0 1-1 0V3.707L2.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L4.5 3.707V13.5z"/>
								</svg>
							  </span>
					        </div>
				    <%
				   		if (request.getAttribute("erroreEta") != null) {
							%><input type="number" class="form-control is-invalid" id="eta" name="eta" placeholder="Et&agrave;" min="18" max="130" value="<%=request.getAttribute("eta")%>"><% 
						} else if (request.getAttribute("eta") != null) {
							%><input type="number" class="form-control" id="eta" name="eta" min="18" max="130" placeholder="Et&agrave;" value="<%=request.getAttribute("eta")%>"><% 
						} else {
							%><input type="number" class="form-control" id="eta" name="eta" placeholder="Et&agrave;" min="18" max="130"><% 
						}
					%>
				    <div class="invalid-feedback">Et&agrave; non valida&excl; Ricorda che il sistema ammette solo un&apos;et&agrave; compresa tra 18 e 130</div>
			        </div>
			        </div>
		               <%
		               	String sesso = (String)request.getAttribute("sesso");
						if (sesso != null && sesso.equals("M")) {
							%>
		            		<div class="custom-control custom-radio">
			           		  <input type="radio" class="custom-control-input" id="maschio" name="sesso" value="M" checked>
							  <label for="maschio" class="custom-control-label">Maschio</label><br>
			           		</div>
			           		<div class="custom-control custom-radio mb-3"> 
			           		  <input type="radio" class="custom-control-input" id="femmina" name="sesso" value="F">
			            	  <label for="femmina" class="custom-control-label">Femmina</label><br>
			            	</div>
							<% 
						} else if (sesso != null && sesso.equals("F")) { %>
							<div class="custom-control custom-radio">
			           		 	<input type="radio" class="custom-control-input" id="maschio" name="sesso" value="M">
								<label for="maschio" class="custom-control-label">Maschio</label><br>
			           		 </div>
			           		 <div class="custom-control custom-radio mb-3">
			           		 	<input type="radio" class="custom-control-input mb-3" id="femmina" name="sesso" value="F" checked>
			            	  	<label for="femmina" class="custom-control-label">Femmina</label><br>
							 </div>
						<% 
						} else {
						%>  
							<div class="custom-control custom-radio">
					        	<input type="radio" id="maschio" class="custom-control-input" name="sesso" value="M">
					        	<label for="maschio" class="custom-control-label">Maschio</label><br>
					        </div>
					        <div class="custom-control custom-radio mb-3">
					        	<input type="radio" id="femmina" class="custom-control-input" name="sesso" value="F">
					        	<label for="femmina" class="custom-control-label">Femmina</label><br>
					            <div class="invalid-feedback">Selezionare il sesso&excl;</div> 
					        </div>	<%
						}
					%>
		            <div class="form-group">
			            <label for="regione">Regioni&colon; </label>
			            <div class="input-group">
					        <div class="input-group-prepend">
					          <span class="input-group-text" id="inputGroupPrepend4">
					          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pin-map-fill" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M3.1 11.2a.5.5 0 0 1 .4-.2H6a.5.5 0 0 1 0 1H3.75L1.5 15h13l-2.25-3H10a.5.5 0 0 1 0-1h2.5a.5.5 0 0 1 .4.2l3 4a.5.5 0 0 1-.4.8H.5a.5.5 0 0 1-.4-.8l3-4z"/>
								  <path fill-rule="evenodd" d="M4 4a4 4 0 1 1 4.5 3.969V13.5a.5.5 0 0 1-1 0V7.97A4 4 0 0 1 4 3.999z"/>
								</svg>
							  </span>
					        </div>
		            	 <%
							if (request.getAttribute("error") != null) { %>
								<select name="regione" class="custom-select is-invalid" id="regione">
					            	<option disabled selected>Seleziona Regione</option>
									<!--prendiamo ogni regione dalla collection e costruiamo la select--> 
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
			        	 %>		<select name="regione" class="custom-select" id="regione">
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
					</div> 
					<div class="form-group">
			            <label for="comune">Comuni&colon; </label>
			            <div class="input-group">
					        <div class="input-group-prepend">
					          <span class="input-group-text" id="inputGroupPrepend5">
					          	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cursor-fill" viewBox="0 0 16 16">
								  <path d="M14.082 2.182a.5.5 0 0 1 .103.557L8.528 15.467a.5.5 0 0 1-.917-.007L5.57 10.694.803 8.652a.5.5 0 0 1-.006-.916l12.728-5.657a.5.5 0 0 1 .556.103z"/>
								</svg>
							  </span>
					        </div>
			              <%
							if (request.getAttribute("error") != null) { %>
								<select name="comune" id="comune" class="custom-select is-invalid">
									<option disabled selected>Seleziona Comune</option>
								</select>
								
						 <%	} else {
			        	 %>		
								<select name="comune" id="comune" class="custom-select">
									<option disabled selected>Seleziona Comune</option>
								</select>	        	
				        <% } %>
						<div class="invalid-feedback">Controlla il tuo comune&excl;</div>
						</div>
					</div>
					<div class="form-group">
						<label for="cap">CAP&colon;</label>
							<%
								if (request.getAttribute("erroreCap") != null) {
									%><input type="text" class="form-control is-invalid" id="cap" placeholder="CAP" value="<%=request.getAttribute("cap")%>" name="cap"><% 
								} else if (request.getAttribute("codice") != null) {
									%><input type="text" class="form-control" id="cap" placeholder="CAP" value="<%=request.getAttribute("cap")%>" name="cap"><% 
								} else {
									%><input type="text" class="form-control" id="cap" placeholder="CAP" name="cap"><% 
								}
							%> 
							 <div class="invalid-feedback">Il CAP inserito non corrisponde con il comune indicato&excl;</div> 
					</div>
					<input type="submit" class="btn btn-dark" value="Login"/>
				</fieldset>
		    </form> 
		</div>
 	</div>
<%} %>
  </div>
</body>
</html> 