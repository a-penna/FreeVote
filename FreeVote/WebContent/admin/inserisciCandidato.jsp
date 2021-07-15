<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazione admin, inserisci candidato, candidato, inserisci">
	<meta name="description" content="Inserisci candidato">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Candidato</title>
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

            var name = document.getElementsByName("nome")[0];
            if(!checkNomeCognome(name)) {
                valid = false;
                name.classList.remove("is-valid");
                name.classList.add("is-invalid");
            } else {
            	 name.classList.remove("is-invalid");
            	 name.classList.add("is-valid");
            }
            
            var surname = document.getElementsByName("cognome")[0];
            if(!checkNomeCognome(surname)) {
                valid = false;
                surname.classList.remove("is-valid");
                surname.classList.add("is-invalid");
            } else {
            	surname.classList.remove("is-invalid");
           	 	surname.classList.add("is-valid");
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

	<body class="bg-light">
	<%@ include file="/admin/admin-header.jsp"%>
        <div class="container-fluid py-5">
        	<div class="row">
				<div class="col-md-2">
					<%@ include file="/admin/politicheMenu.jsp" %>
				</div>
				<div class="col-md-10">
					<p>Inserisci i dati nel seguente form per inserire un nuovo candidato all&apos;interno di un partito gi&agrave; registrato sulla piattaforma&colon;<p>
					<form name="form" action="<%=response.encodeURL("/FreeVote/InserisciCandidato")%>" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)"> 
		                 <fieldset>
		                    <legend>Informazioni sul candidato&colon; </legend>
		                    <div class="form-group">
		                        <label for="nome">Nome&colon;</label>
								<%
									if (request.getAttribute("erroreNome") != null) {
										%><input type="text" class="form-control is-invalid" id="nome" placeholder="Inserisci Nome" value="<%=request.getAttribute("nome")%>" name="nome" required><% 
									} else if (request.getAttribute("nome") != null) {
										%><input type="text" class="form-control is-valid" id="nome" placeholder="Inserisci Nome" value="<%=request.getAttribute("nome")%>" name="nome" required><% 
									} else {
										%><input type="text" class="form-control" id="nome" placeholder="Inserisci Nome" name="nome" required><% 
									}
								%>
		                        <div class="valid-feedback">Corretto</div>
		                        <div class="invalid-feedback">Nome non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="cognome">Cognome&colon;</label>
		                        <%
									if (request.getAttribute("erroreCognome") != null) {
										%><input type="text" class="form-control is-invalid" id="cognome" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognome")%>" name="cognome" required><% 
									} else if (request.getAttribute("cognome") != null) {
										%><input type="text" class="form-control is-valid" id="cognome" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognome")%>" name="cognome" required><% 
									} else {
										%><input type="text" class="form-control" id="cognome" placeholder="Inserisci Cognome" name="cognome" required><% 
									}
								%>
		                        <div class="valid-feedback">Corretto</div>
		                        <div class="invalid-feedback">Cognome non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="cf">Codice Fiscale&colon;</label>
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
		                        <div class="invalid-feedback">Codice fiscale non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="curriculum">Curriculum&colon;</label>
		                    <%  if (request.getAttribute("curriculum") != null) {
									%><textarea class="form-control" rows="10" cols="48" id="curriculum" placeholder="Inserisci qui il curriculum" name="curriculum" required><%=request.getAttribute("curriculum")%></textarea><% 
								} else {
									%><textarea class="form-control" rows="10" cols="48" id="curriculum" placeholder="Inserisci qui il curriculum" name="curriculum" required></textarea><% 
								}
							%>   
		                      
		                    </div>
		                    <div class="form-group">
		                        <label for="foto">Carica Foto(Max&period; size&equals;10MB)&colon;</label>
		                        <input id="foto" type="file" name="foto">  
		                    </div>
		                 </fieldset>
		                 <fieldset>
			                 <legend>Nome del partito in cui inserire il candidato&colon; </legend>
			                 <div class="form-group">
				                 <label for="partito">Nome&colon;</label>
				                 <%  if (request.getAttribute("partito") != null) {
									%><input id="partito" class="form-control" type="text" name="partito" placeholder="Nome partito" value="<%=request.getAttribute("partito")%>" required><% 
								} else {
									%><input id="partito" class="form-control" type="text" name="partito" placeholder="Nome partito" required><% 
								}
							%> 
			                 </div>
		                 </fieldset>
		               <button type="submit" class="btn btn-dark">Inserisci</button>
		            </form>
		        </div>
		    </div>
        </div>

</body>
</html> 