<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, gestioneReferendum">
	<meta name="description" content="Gestione Referendum menù">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash;Disabilita referendum</title>
</head>            

<body>
	<%@ include file="admin-header.jsp"%> <!-- Da Completare -->
    
    <form action="<%=response.encodeURL("/FreeVote/GestioneReferendum")%>" method="get">
     <input id="submit" type="submit" name="abilita" placeholder="Abilita"> 
            <br>
            <input id="submit" type="submit" name="disabilita" placeholder="Disabilita">
            <br>
    
    
    
    
    
    </form>
  
    

    

</body>
</html>