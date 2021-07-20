<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, inserisci, admin, inserisci mozione, mozione">
	<meta name="description" content="Inserisci Mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Mozione</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!--jQuery library--> 
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

            var nomeCompleto = document.getElementsByName("nomeCompleto")[0];
            if(!checkNomeCognome(nomeCompleto)) {
                valid = false;
                nomeCompleto.classList.remove("is-valid");
                nomeCompleto.classList.add("is-invalid");
            } else {
            	nomeCompleto.classList.remove("is-invalid");
            	nomeCompleto.classList.add("is-valid");
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
				<%@ include file="/admin/referendumMenu.jsp" %>
			</div>
			<div class="col-md-10">
				<p>Inserisci i dati nel seguente form per registare una nuova mozione: <p>
			
				<form action="<%=response.encodeURL(request.getContextPath() + "/InserisciMozione")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
				    <fieldset>
				        <legend>Informazioni sulla mozione&colon; </legend>
						<div class="form-group">
				        	<label for="nomeCompleto">Nome e cognome dell&apos;autore&colon;</label> 
				        	<%
								if (request.getAttribute("erroreNomeCompleto") != null) {
									%><input type="text" class="form-control is-invalid" id="nomeCompleto" placeholder="Nome e cognome Autore" value="<%=request.getAttribute("nomeCompleto")%>" name="nomeCompleto" required><% 
								} else if (request.getAttribute("nomeCompleto") != null) {
									%><input type="text" class="form-control is-valid" id="nomeCompleto" placeholder="Nome e cognome Autore" value="<%=request.getAttribute("nomeCompleto")%>" name="nomeCompleto" required><% 
								} else {
									%><input type="text" class="form-control" id="nomeCompleto" placeholder="Nome e cognome Autore" name="nomeCompleto" required><% 
								}
							%>
		                        <div class="valid-feedback">Corretto</div>
		                        <div class="invalid-feedback">Nome non valido&excl;</div>
		              	</div>
		              	<div class="form-group">
				        	<label for="testo">Testo della mozione&colon;</label>
				        	<%
								if (request.getAttribute("erroreTesto") != null) {
									%><textarea id="testo" class="form-control is-invalid" name="testo" rows="10" cols="48" placeholder="Inserisci qui il testo della mozione" required></textarea><% 
								} else if (request.getAttribute("testo") != null) {
									%><textarea id="testo" class="form-control" name="testo" rows="10" cols="48" placeholder="Inserisci qui il testo della mozione" required><%=request.getAttribute("testo")%></textarea><% 
								} else {
									%><textarea id="testo" class="form-control" name="testo" rows="10" cols="48" placeholder="Inserisci qui il testo della mozione" required></textarea><% 
								}
							%>
							<div class="invalid-feedback">Inserisci il testo della mozione&excl;</div>
						</div>
						<br>
				        <button type="submit" class="btn btn-primary">Crea</button>
				     </fieldset>
				</form> 
			</div>
		</div>
	</div>

</body>
</html> 