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
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, elimina partito da una coalizione, partito, coalizione, operazioni admin, admin, elimina">
	<meta name="description" content="Elimina partito da una coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Partito da una Coalizione</title>
	<link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>            

<body>
	<%@ include file="/admin/admin-header.jsp"%>
	<div class="container py-4">
		<p>Selezionare un partito per scollegarlo dalla sua coalizione&comma; nel caso in cui non ne abbia una l'operazione fallir&agrave;&period;</p>
		<form action="<%=response.encodeURL("/FreeVote/EliminaPartitoCoalizione")%>" method="post"> 
			    <fieldset>
				<div class="form-group">
			        <select name="nome" class="form-select" required>
			        	<option disabled selected>Partito&colon;</option>
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
			    	<button type="submit" class="btn btn-primary">Elimina</button>
				</div>
				</fieldset>
		</form> 
	</div>
</body>
</html> 