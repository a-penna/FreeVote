<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, login">
	<meta name="description" content="Login Admin">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote - Login Admin</title>
</head>            

<body>
	<%@ include file="header.html"%>
    
    <form action="LoginAdmin" method="post"> 
        <fieldset>
             <legend>Inserisci credenziali: </legend>
             <label for="username">Username</label>
             <input id="username" type="text" name="username" placeholder="inserisci username"> 
             <br>   
             <label for="password">Password</label>
             <input id="password" type="password" name="password" placeholder="inserisci password"> 
             <br>
             <input type="submit" value="Login"/>
             <input type="reset" value="Reset"/>
    </fieldset>
    </form> 


</body>
</html>