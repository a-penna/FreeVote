<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, admin, inserisci, inserisci partito, partito">
	<meta name="description" content="Inserisci partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Partito</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
    <script>
        function validate(obj) {	
            var valid = true;	

            var nomeLeader = document.getElementsByName("nomeLeader")[0];
            if(!checkNomeCognome(nomeLeader)) {
                valid = false;
                nomeLeader.classList.remove("is-valid");
                nomeLeader.classList.add("is-invalid");
            } else {
            	 nomeLeader.classList.remove("is-invalid");
            	 nomeLeader.classList.add("is-valid");
            }
            
            var cognomeLeader = document.getElementsByName("cognomeLeader")[0];
            if(!checkNomeCognome(cognomeLeader)) {
                valid = false;
                cognomeLeader.classList.remove("is-valid");
                cognomeLeader.classList.add("is-invalid");
            } else {
            	 cognomeLeader.classList.remove("is-invalid");
            	 cognomeLeader.classList.add("is-valid");
            }

            var cf = document.getElementsByName("cf")[0];
            if(!checkCf(cf)) {
                valid = false;
                cf.classList.remove("is-valid");
                cf.classList.add("is-invalid");
            } else {
            	 cf.classList.remove("is-invalid");
            	 cf.classList.add("is-valid");
            }
            
            if(valid) obj.submit();
        }
    </script>
</head>            

<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<div class="container py-4">
		<p>Inserisci i dati nel seguente form per registare un nuovo partito&colon; <p>
		<form action="<%=response.encodeURL("/FreeVote/InserisciPartito")%>" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)"> 
		        <fieldset>
		        	<legend>Informazioni sul partito&colon; </legend>
					<div class="form-group">
			        	<label for="nome">Nome&colon;</label>
			       	    <input id="nome" type="text" class="form-control" name="nome" placeholder="Nome partito" required> 
		    		</div>
		    		<div class="form-group">
			        	<label for="descrizione">Descrizione&colon;</label>
			        	<textarea id="descrizione" class="form-control" name="descrizione" rows="10" cols="48" placeholder="Inserisci qui la descrizione" required></textarea>
					</div>
					<div class="form-group">
			        	<label for="logo">Carica Logo&colon;</label>
			       	    <input id="logo" type="file" name="logo"> 
			        	<br>
			        </div>
		        </fieldset>
		        <fieldset>
		        	<legend>Informazioni sul leader&colon; </legend>
		        	<div class="form-group">
			        	<label for="nomeLeader">Nome&colon;</label>
				        <%
							if (request.getAttribute("erroreNome") != null) {
								%><input type="text" class="form-control is-invalid" id="nomeLeader" placeholder="Inserisci Nome" value="<%=request.getAttribute("nomeLeader")%>" name="nomeLeader" required><% 
							} else if (request.getAttribute("nomeLeader") != null) {
								%><input type="text" class="form-control is-valid" id="nomeLeader" placeholder="Inserisci Nome" value="<%=request.getAttribute("nomeLeader")%>" name="nomeLeader" required><% 
							} else {
								%><input type="text" class="form-control" id="nomeLeader" placeholder="Inserisci Nome" name="nomeLeader" required><% 
							}
						%>
			        	<div class="valid-feedback">Corretto</div>
	                    <div class="invalid-feedback">Nome non valido&excl;</div>
	                </div>
                    <div class="form-group">
			        	<label for="cognomeLeader">Cognome&colon;</label>
                        <%
							if (request.getAttribute("erroreCognome") != null) {
								%><input type="text" class="form-control is-invalid" id="cognomeLeader" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognomeLeader")%>" name="cognomeLeader" required><% 
							} else if (request.getAttribute("cognomeLeader") != null) {
								%><input type="text" class="form-control is-valid" id="cognomeleader" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognomeLeader")%>" name="cognome" required><% 
							} else {
								%><input type="text" class="form-control" id="cognomeLeader" placeholder="Inserisci Cognome" name="cognomeLeader" required><% 
							}
						%>
			        	<div class="valid-feedback">Corretto</div>
	                    <div class="invalid-feedback">Cognome non valido&excl;</div>
                    </div>
                    <div class="form-group">
			        	<label for="cf">Codice fiscale&colon;</label>
			        	<%
							if (request.getAttribute("erroreCf") != null) {
								%><input type="text" class="form-control is-invalid" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" value="<%=request.getAttribute("cf")%>" name="cf" required><% 
							} else if (request.getAttribute("cf") != null) {
								%><input type="text" class="form-control is-valid" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" value="<%=request.getAttribute("cf")%>" name="cf" required><% 
							} else {
								%><input type="text" class="form-control" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" name="cf" required><% 
							}
						%>
			        	<div class="valid-feedback">Corretto</div>
	                    <div class="invalid-feedback">Codice Fiscale non valido&excl;</div>
                    </div>
                    <div class="form-group">
			        	<label for="curriculum">Curriculum&colon;</label>
			        	<textarea id="curriculum" name="curriculum" class="form-control" rows="10" cols="48" placeholder="Inserisci qui il curriculum"></textarea>
			        	<br>
		        	</div>
		        	<div class="form-group">
			        	<label for="foto">Carica Foto&colon;</label>
			       	    <input id="foto" type="file" name="foto">  
			        </div>
		        </fieldset>
		        <button type="submit" class="btn btn-primary">Inserisci</button>
		</form>
	</div> 

</body>
</html> 