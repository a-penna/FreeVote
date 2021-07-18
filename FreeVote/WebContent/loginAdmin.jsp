<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
	boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;

	if(loggedIn) {
		response.sendRedirect(response.encodeRedirectURL("admin/interfacciaAdmin.jsp"));
	 	return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, login admin, admin, amministratore, autenticazione, autenticazione admin">
	<meta name="description" content="Login Admin">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Login Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
</head>            

<body class="bg-dark text-black">
	<%@ include file="header.jsp"%>
		<div class="container py-5">
		<div class="card text-white bg-secondary mb-3" style="max-width: 25rem;">
  <div class="card-header text-center">
    Amministratore
  </div>
  <div class="card-body text-left">
    <h4 class="card-title text-left">Login</h4>
	    <% boolean loggedAsElettore = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;  
	    
	    if (loggedAsElettore)  { 
			%><h3>Si prega di effettuare il logout da elettore prima di procedere con la normale autenticazione da admin</h3><%
		} else { %>
		    <form action="Administrator" method="post"> 
		        <fieldset>
		             <div class="form-group">
		             	<label for="username">Username&colon;</label>
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <span class="input-group-text" id="inputGroupPrepend1"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
																				  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>									
																				  </svg></span>
				        </div>
				            <%
								if (request.getAttribute("erroreUser") != null) {
									%><input type="text" class="form-control is-invalid" id="username" aria-describedby="inputGroupPrepend1" placeholder="Inserisci username" value="<%=request.getAttribute("username")%>" name="username" required><% 
								} else if (request.getAttribute("username") != null) {
									%><input type="text" class="form-control is-valid" id="username" aria-describedby="inputGroupPrepend1" placeholder="Inserisci username" value="<%=request.getAttribute("username")%>" name="username" required><% 
								} else {
									%><input type="text" class="form-control" id="username" aria-describedby="inputGroupPrepend1" placeholder="Inserisci username" name="username" required><% 
								}
							%>
	                        <div class="valid-feedback">Corretto&excl;</div>
	                        <div class="invalid-feedback">Username errato&excl;</div> 
				      </div>
			         </div>
			         <div class="form-group">
			         <label for="password">Password&colon;</label>
				      <div class="input-group">
				        <div class="input-group-prepend">
				          <span class="input-group-text" id="inputGroupPrepend2"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
																				  <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
																				</svg></span>
				        </div>
			           		<%
								if (request.getAttribute("errorePass") != null) {
									%><input type="password" class="form-control is-invalid" id="password"  aria-describedby="inputGroupPrepend2" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password" required><% 
								} else if (request.getAttribute("password") != null) {
									%><input type="password" class="form-control" id="password" placeholder="Inserisci password"  aria-describedby="inputGroupPrepend2" value="<%=request.getAttribute("password")%>" name="password" required><% 
								} else {
									%><input type="password" class="form-control" id="password" placeholder="Inserisci password"  aria-describedby="inputGroupPrepend2" name="password" required><% 
								}
							%>
	                        <div class="valid-feedback">Corretto&excl;</div>
	                        <div class="invalid-feedback">Password errata&excl;</div> 
	                     </div>
		             </div>
		             <input type="submit" class="btn btn-dark" value="Login"/>
		    	</fieldset>
		    </form> 
		</div>
		             <div class="card-footer text-muted">
		             <br>
		             </div>
	 </div>
  </div>
<% 	} %>
</body>
</html>