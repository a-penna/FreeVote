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
<!--<script>
        function validate(obj) {	
            var valid = true;	

            var cf = document.getElementsByName("cf")[0];
            if(!checkCf(cf)) {
                valid = false;
                document.getElementById("cfError").innerHTML = "Codice fiscale non valido&excl;";
            } else {
                document.getElementById("cfError").innerHTML = "";
            }
            
            if(valid) obj.submit();
        }
    </script> -->
</head>            

<body>
<%@ include file="/admin/admin-header.jsp"%>
<p>Inserire i dati del candidato da eliminare&colon;</p>
<form action="<%=response.encodeURL("/FreeVote/EliminazioneCandidato")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
        <label for="cf">Codice Fiscale&colon;</label>
        <input id="cf" type="text" name="cf" placeholder="codice fiscale" required>
        <%if (request.getAttribute("cfInvalido") != null) { %>                   
            <p id="cfError">non valido&excl;</p>
        <%} else { %>
            <p id="cfError"></p>
        <%}%>
        <input type="submit" value="Elimina">
</form> 

</body>
</html> 