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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/script.js"></script>
    <script>
        function validate(obj) {	
            var valid = true;	

            var nomePartito = document.getElementsByName("nome")[0];
            if(!checkNomePartitoCoalizione(nomePartito)) {
                valid = false;
                nomePartito.classList.add("is-invalid");
                nomePartito.focus();
            } else {
            	nomePartito.classList.remove("is-invalid");
            	nomePartito.classList.add("is-valid");
            }
            
            var descrizionePartito = document.getElementsByName("descrizione")[0];
            if((descrizionePartito.value.trim() == "")) {
                valid = false;
                descrizionePartito.classList.add("is-invalid");
                descrizionePartito.focus();
            } else {
            	descrizionePartito.classList.remove("is-invalid");
            	descrizionePartito.classList.add("is-valid");
            }
            
            var nomeLeader = document.getElementsByName("nomeLeader")[0];
            if(!checkNomeCognome(nomeLeader)) {
                valid = false;
                nomeLeader.classList.remove("is-valid");
                nomeLeader.classList.add("is-invalid");
                nomeLeader.focus()
            } else {
            	 nomeLeader.classList.remove("is-invalid");
            	 nomeLeader.classList.add("is-valid");
            }
            
            var cognomeLeader = document.getElementsByName("cognomeLeader")[0];
            if(!checkNomeCognome(cognomeLeader)) {
                valid = false;
                cognomeLeader.classList.remove("is-valid");
                cognomeLeader.classList.add("is-invalid");
                cognomeLeader.focus();
            } else {
            	 cognomeLeader.classList.remove("is-invalid");
            	 cognomeLeader.classList.add("is-valid");
            }

            var codiceF = document.getElementsByName("cf")[0];
            if(!checkCf(codiceF)) {
                valid = false;
                codiceF.classList.remove("is-valid");
                codiceF.classList.add("is-invalid");
                codiceF.focus();
            } else {
            	 codiceF.classList.remove("is-invalid");
            	 codiceF.classList.add("is-valid");
            }
            
            var curriculumL = document.getElementsByName("curriculum")[0];
            if((curriculumL.value.trim() == "")) {
                valid = false;
                curriculumL.classList.add("is-invalid");
                curriculumL.focus();
            } else {
            	curriculumL.classList.remove("is-invalid");
            	curriculumL.classList.add("is-valid");
            }
            
            if(valid) obj.submit();
        }
        
        function firstFocus() {	
            var name = document.getElementsByName("nome")[0];
            name.focus();
        }
        
        window.onload = firstFocus;
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
				<p>Inserisci i dati nel seguente form per registare un nuovo partito&colon; <p>
				<form action="<%=response.encodeURL(request.getContextPath() + "/InserisciPartito")%>" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)"> 
				        <fieldset>
				        	<legend>Informazioni sul partito&colon; </legend>
							<div class="form-group">
					        	<label for="nome">Nome&colon;</label>
								<%
									if (request.getAttribute("errorePartito") != null) {
										%> <input id="nome" type="text" class="form-control is-invalid" value="<%=request.getAttribute("nome")%>" name="nome" placeholder="Nome partito"> <%
									} else if (request.getAttribute("nome") != null) { 
										%> <input id="nome" type="text" class="form-control is-valid" value="<%=request.getAttribute("nome")%>" name="nome" placeholder="Nome partito"> <%
									} else {
										%><input id="nome" type="text" class="form-control" name="nome" placeholder="Nome partito"><% 
									}
								%>
								<div class="valid-feedback">Corretto</div>
			                    <div class="invalid-feedback">Nome non valido, utilizzare solo lettere e numeri&excl;</div>
				    		</div>
				    		<div class="form-group">
					        	<label for="descrizione">Descrizione&colon;</label>
					        	<%
									if (request.getAttribute("erroreDescrizione") != null) {
										%> <textarea id="descrizione" class="form-control is-invalid" name="descrizione" rows="10" cols="48" placeholder="Inserisci qui la descrizione"></textarea> <%
									} else if (request.getAttribute("descrizione") != null) {
										%><textarea id="descrizione" class="form-control is-valid" name="descrizione" rows="10" cols="48" placeholder="Inserisci qui la descrizione"><%=request.getAttribute("descrizione")%></textarea><%
									} else {
										%><textarea id="descrizione" class="form-control" name="descrizione" rows="10" cols="48" placeholder="Inserisci qui la descrizione"></textarea><% 
									}
								%>
					        	<div class="valid-feedback">Corretto</div>
			                    <div class="invalid-feedback">Inserisci la descrizione&excl;</div>
							</div>
							<div class="form-group">
					        	<label for="logo">Carica Logo&lpar;Max&period; size&equals;10MB&rpar;&colon;</label>
					       	    <input id="logo" type="file" accept="image/*" name="logo"> 
					        	<br>
					        </div>
				        </fieldset>
				        <fieldset>
				        	<legend>Informazioni sul leader&colon; </legend>
				        	<div class="form-group">
					        	<label for="nomeLeader">Nome&colon;</label>
						        <%
									if (request.getAttribute("erroreNome") != null) {
										%><input type="text" class="form-control is-invalid" id="nomeLeader" placeholder="Inserisci Nome" value="<%=request.getAttribute("nomeLeader")%>" name="nomeLeader"><% 
									} else if (request.getAttribute("nomeLeader") != null) {
										%><input type="text" class="form-control is-valid" id="nomeLeader" placeholder="Inserisci Nome" value="<%=request.getAttribute("nomeLeader")%>" name="nomeLeader"><% 
									} else {
										%><input type="text" class="form-control" id="nomeLeader" placeholder="Inserisci Nome" name="nomeLeader"><% 
									}
								%>
					        	<div class="valid-feedback">Corretto</div>
			                    <div class="invalid-feedback">Nome non valido&excl;</div>
			                </div>
		                    <div class="form-group">
					        	<label for="cognomeLeader">Cognome&colon;</label>
		                        <%
									if (request.getAttribute("erroreCognome") != null) {
										%><input type="text" class="form-control is-invalid" id="cognomeLeader" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognomeLeader")%>" name="cognomeLeader"><% 
									} else if (request.getAttribute("cognomeLeader") != null) {
										%><input type="text" class="form-control is-valid" id="cognomeleader" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognomeLeader")%>" name="cognomeLeader"><% 
									} else {
										%><input type="text" class="form-control" id="cognomeLeader" placeholder="Inserisci Cognome" name="cognomeLeader"><% 
									}
								%>
					        	<div class="valid-feedback">Corretto</div>
			                    <div class="invalid-feedback">Cognome non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
					        	<label for="cf">Codice fiscale&colon;</label>
					        	<%
									if (request.getAttribute("erroreCf") != null) {
										%><input type="text" class="form-control is-invalid" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" value="<%=request.getAttribute("cf")%>" name="cf"><% 
									} else if (request.getAttribute("cf") != null) {
										%><input type="text" class="form-control is-valid" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" value="<%=request.getAttribute("cf")%>" name="cf"><% 
									} else {
										%><input type="text" class="form-control" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" name="cf"><% 
									}
								%>
					        	<div class="valid-feedback">Corretto</div>
			                    <div class="invalid-feedback">Codice Fiscale non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
					        	<label for="curriculum">Curriculum&colon;</label>
					        	<%
									if (request.getAttribute("erroreCurriculum") != null) {
										%><textarea id="curriculum" name="curriculum" class="form-control is-invalid" rows="10" cols="48" placeholder="Inserisci qui il curriculum"></textarea><%
									} else if (request.getAttribute("curriculum") != null) {
										%><textarea id="curriculum" name="curriculum" class="form-control is-valid" rows="10" cols="48" placeholder="Inserisci qui il curriculum"><%=request.getAttribute("curriculum")%></textarea><% 
									} else {
										%><textarea id="curriculum" name="curriculum" class="form-control" rows="10" cols="48" placeholder="Inserisci qui il curriculum"></textarea><% 
									}
								%>
					        	<div class="valid-feedback">Corretto</div>
			                    <div class="invalid-feedback">Inserisci il curriculum&excl;</div>
					        	<br>
				        	</div>
				        	<div class="form-group">
					        	<label for="foto">Carica Foto&lpar;Max&period; size&equals;10MB&rpar;&colon;</label>
					       	    <input id="foto" type="file" accept="image/*" name="foto">  
					        </div>
				        </fieldset>
				        <button type="submit" class="btn btn-primary">Inserisci</button>
				</form>
		</div>
	</div>
	</div> 

</body>
</html> 