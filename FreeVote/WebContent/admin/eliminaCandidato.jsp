
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, elimina, candidato, Elimina Candidato">
<meta name="description" content="Elimina candidato">
<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
<title>FreeVote &dash; Elimina Candidato</title>
<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
<link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
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
	<p>Inserire i dati del candidato da eliminare&colon;</p>
	<form action="<%=response.encodeURL("/FreeVote/EliminazioneCandidato")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
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
		<button type="submit" class="btn btn-primary">Elimina</button>
	</form> 
</div>

</body>
</html> 