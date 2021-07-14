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
</head>            

<body>
	<%@ include file="header.jsp"%>
		<div class="container py-5">  
	    <% boolean loggedAsElettore = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;  
	    
	    if (loggedAsElettore)  { 
			%><h3>Si prega di effettuare il logout da elettore prima di procedere con la normale autenticazione da admin</h3><%
		} else { %>
		    <form action="Administrator" method="post"> 
		        <fieldset>
		             <legend>Inserisci credenziali&colon; </legend>
		             <div class="form-group">
			             <label for="username">Username&colon;</label>
				            <%
								if (request.getAttribute("erroreUser") != null) {
									%><input type="text" class="form-control is-invalid" id="username" placeholder="Inserisci username" value="<%=request.getAttribute("username")%>" name="username" required><% 
								} else if (request.getAttribute("username") != null) {
									%><input type="text" class="form-control is-valid" id="username" placeholder="Inserisci username" value="<%=request.getAttribute("username")%>" name="username" required><% 
								} else {
									%><input type="text" class="form-control" id="username" placeholder="Inserisci username" name="username" required><% 
								}
							%>
	                        <div class="valid-feedback">Corretto&excl;</div>
	                        <div class="invalid-feedback">Username errato&excl;</div> 
			         </div>
			         <div class="form-group">
			             <label for="password">Password&colon;</label>
			           		<%
								if (request.getAttribute("errorePass") != null) {
									%><input type="password" class="form-control is-invalid" id="password" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password" required><% 
								} else if (request.getAttribute("password") != null) {
									%><input type="password" class="form-control" id="password" placeholder="Inserisci password" value="<%=request.getAttribute("password")%>" name="password" required><% 
								} else {
									%><input type="password" class="form-control" id="password" placeholder="Inserisci password" name="password" required><% 
								}
							%>
	                        <div class="valid-feedback">Corretto&excl;</div>
	                        <div class="invalid-feedback">Password errata&excl;</div> 
		             </div>
		             <input type="submit" class="btn btn-primary" value="Login"/>
		    	</fieldset>
		    </form> 
		</div>

<% 	} %>
</body>
</html>