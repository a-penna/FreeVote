<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> partiti = (Collection<?>) request.getAttribute("listaPartiti");
    if (partiti == null) {
        response.sendRedirect(response.encodeURL("/FreeVote/EliminaPartito"));
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, admin, elimina, partito elimina partito">
	<meta name="description" content="Elimina partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Partito</title>
</head>            

<body>
<%@ include file="/admin/admin-header.jsp"%>

<form action="<%=response.encodeURL("/FreeVote/EliminaPartito")%>" method="post"> 
    <fieldset>
        <legend>Inserisci informazioni sul partito&colon; </legend>
        <label for="nome">Nome&colon;</label>
        <select name="nome" required>
	            <%
	            Iterator<?> it = partiti.iterator();
	            while(it.hasNext()) {
					PartitoBean bean = (PartitoBean)it.next();
					if (!bean.getNome().equals("Scheda Bianca")) { %>
	            		<option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
	            <%	}  
				} 
	            %>
	     </select> 
        <input id="submit" type="submit" value="Elimina">
   </fieldset>
</form> 

</body>
</html> 