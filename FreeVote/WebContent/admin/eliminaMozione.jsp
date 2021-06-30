<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> mozioni = (Collection<?>) request.getAttribute("mozioni");
    if (mozioni == null) {
        response.sendRedirect(response.encodeURL("/FreeVote/EliminaMozione"));
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, admin, elimina, elimina mozione, mozione">
	<meta name="description" content="Elimina Mozione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Mozione</title>
</head>            
<body>

	<%@ include file="/admin/admin-header.jsp"%>
	<p>Inserisci i dati nel seguente form per eliminare una mozione già presente: <p>

	<form action="<%=response.encodeURL("/FreeVote/EliminaMozione")%>" method="get"> 
        <fieldset>
        <legend>Inserisci l'ID della mozione da rimuovere&colon; </legend> <!-- Testo, Nome completo autore-->
        	<label for="id">ID della mozione&colon;</label> 
			<select name="id" required>
	            <%
	            Iterator<?> it = mozioni.iterator();
	            while(it.hasNext()) {
	                MozioneBean bean = (MozioneBean)it.next(); 
	            %>
	            <option value="<%=bean.getID()%>"><%=bean.getID()%></option>
	            <%  } 
	            %>
	     </select> 
           
        </fieldset>
        <input type="submit" value="Elimina">
	</form> 

</body>
</html> 