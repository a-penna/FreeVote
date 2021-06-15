<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> comuni = (Collection<?>) request.getAttribute("listaComuni");
    if (comuni == null) {
        response.sendRedirect(response.encodeURL("/FreeVote/Elettore"));
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, Votazione">
	<meta name="description" content="Votazioni">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Votazioni</title>
</head>            

<body>
	<%@ include file="header.html"%>
    
    <form action="Elettore" method="post"> 
        <fieldset>
            <legend>Inserisci credenziali&colon; </legend>
            <label for="codice">Codice&colon;</label>
            <input id="codice" type="text" name="codice" placeholder="inserisci codice"> 
            <br>   
            <label for="password">Password&colon;</label>
            <input id="password" type="password" name="password" placeholder="inserisci codice"> 
            <br>
            <input type="reset" value="Reset"/>
            <input type="submit" value="Login"/>
            <br>
            <input type="number" id="eta" name="età" min="18" max="130">
            <label for="Età">Età</label>
            <br>
            <input type="radio" id="Maschio" name="sesso" value="Maschio">
            <label for="male">Maschio</label><br>
            <input type="radio" id="Femmina" name="sesso" value="Femmina">
            <label for="female">Femmina</label><br>
            
            <label for="comune">Comune&colon; </label>
            <select name="comune">
            <%
            Iterator<?> it = comuni.iterator();
            while(it.hasNext()) {
                ComuneBean bean = (ComuneBean)it.next(); 
            %>
            <option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
            <%  } 
            %>
        </select> 
        <br>
        <input type="submit" value="Login"/>
    </fieldset>
    </form> 

</body>
</html> 