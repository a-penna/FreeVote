<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	boolean loggedIn = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
	
	if(loggedIn) {
		response.sendRedirect(response.encodeRedirectURL("/FreeVote/elettore/schedaVoto.jsp"));
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
	<%@ include file="/header.jsp"%>
    
    <% 
    boolean loggedAsAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;  
    
    if (loggedAsAdmin)  { 
		%><h3>Si prega di effettuare il logout da admin prima di procedere con la normale autenticazione da elettore</h3><%
	} else {
		Collection<?> comuni = (Collection<?>) request.getAttribute("listaComuni");
    	if (comuni == null) {
        	response.sendRedirect(response.encodeURL("/FreeVote/Elettore"));
        	return;
    	}
	%>
	    <form action="Elettore" method="post"> 
	        <fieldset>
	            <legend>Inserisci credenziali&colon; </legend>
	            <label for="codice">Codice&colon;</label>
	            <input id="codice" type="text" name="codice" placeholder="inserisci codice"> 
	            <br>   
	            <label for="password">Password&colon;</label>
	            <input id="password" type="password" name="password" placeholder="inserisci codice"> 
	            <br>
	            <label for="eta">Età</label>
	            <input type="number" id="eta" name="eta" min="18" max="130">
	            <br>
	            <input type="radio" id="Maschio" name="sesso" value="M">
	            <label for="male">Maschio</label><br>
	            <input type="radio" id="Femmina" name="sesso" value="F">
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
	        <label for="cap">Cap&colon;</label>
	        <input id="cap" type="text" name="cap" placeholder="CAP"> 
	        <br>
	        <input type="submit" value="Login"/>
	    </fieldset>
	    </form> 
<%} %>
</body>
</html> 