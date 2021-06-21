<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Elimina Candidato">
<meta name="description" content="Elimina candidato">
<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
<title>FreeVote &dash; Elimina Candidato</title>
</head>            

<body>
<%@ include file="/admin/admin-header.jsp"%>
<p>Inserire i dati del candidato da eliminare&colon;</p>
<form action="<%=response.encodeURL("/FreeVote/EliminazioneCandidato")%>" method="post"> 
        <label for="cf">Codice Fiscale&colon;</label>
        <input id="cf" type="text" name="cf" placeholder="codice fiscale"> 
        <br>
        <input id="submit" type="submit" name="submit">
</form> 

</body>
</html> 