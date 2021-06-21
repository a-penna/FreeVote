<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> coalizioni = (Collection<?>) request.getAttribute("listaCoalizioni");
    if (coalizioni == null) {
        response.sendRedirect(response.encodeURL("/FreeVote/EliminaCoalizione"));
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, elimina coalizione">
	<meta name="description" content="Elimina coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Coalizione</title>

</head>            

<body>
<%@ include file="/admin/admin-header.jsp"%>

	<h3>Scegliere il nome della coalizione per procedere&comma; ricorda che 
	saranno cancellati tutti i dati della coalizione ma non quelli dei singoli partiti che la compongono</h3>
	<form action="<%=response.encodeURL("/FreeVote/EliminaCoalizione")%>" method="post"> 
        <label for="coalizione">Scegli Coalizione&colon;</label>
        <select name="coalizione">
	            <%
	            Iterator<?> it = coalizioni.iterator();
	            while(it.hasNext()) {
	                CoalizioneBean bean = (CoalizioneBean)it.next(); 
	            %>
	            <option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
	            <%  } 
	            %>
	     </select> 
        <input id="submit" type="submit" value="Elimina">
	</form> 

</body>
</html> 