<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> partiti = (Collection<?>) request.getAttribute("listaPartiti");
    if (partiti == null) {
        response.sendRedirect(response.encodeURL("/FreeVote/EliminaPartitoCoalizione"));
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, elimina partito da una coalizione, partito, coalizione">
	<meta name="description" content="Elimina partito da una coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Partito da una Coalizione</title>
</head>            

<body>
<%@ include file="/admin/admin-header.jsp"%>

<p>Selezionare un partito per scollegarlo dalla sua coalizione&comma; nel caso in cui non ne abbia una l'operazione non avr&agrave; effetto&period;</p>
<form action="<%=response.encodeURL("/FreeVote/EliminaPartitoCoalizione")%>" method="post"> 
    <fieldset>
        <label for="nome">Partito&colon;</label>
        <select name="nome">
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