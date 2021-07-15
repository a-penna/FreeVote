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
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazioni admin, admin, elimina, partito, elimina partito">
	<meta name="description" content="Elimina partito">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Partito</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
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

<body class="bg-light">
	<%@ include file="/admin/admin-header.jsp"%>
	<div class="container-fluid py-5">
		<div class="row">
			<div class="col-md-2">
				<%@ include file="/admin/politicheMenu.jsp" %>
			</div>
			<div class="col-md-10">
				<form action="<%=response.encodeURL("/FreeVote/EliminaPartito")%>" method="post"> 
					    <fieldset>
					        <legend>Inserisci informazioni sul partito&colon; </legend>
							<div class="form-group">
						        <select class="form-control" name="nome" required>
						        		<option disabled selected>Nome&colon;</option>
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
				   			</div>
					        <button type="submit" class="btn btn-primary">Elimina</button>
					   </fieldset>
				</form> 
			</div>
		</div>
	</div>
</body>
</html> 