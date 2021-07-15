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
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazione admin, admin, elimina, coalizione, elimina coalizione">
	<meta name="description" content="Elimina coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Elimina Coalizione</title>
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
				<h4>Scegliere il nome della coalizione per procedere&comma; ricorda che 
				saranno cancellati tutti i dati della coalizione ma non quelli dei singoli partiti che la compongono</h4>
				<form action="<%=response.encodeURL("/FreeVote/EliminaCoalizione")%>" method="post"> 
					<div class="form-group">
			        <select class="form-control" name="coalizione" required>
			        		<option disabled selected>Scegli Coalizione&colon;</option>
				            <%
				            Iterator<?> it = coalizioni.iterator();
				            while(it.hasNext()) {
				                CoalizioneBean bean = (CoalizioneBean)it.next(); 
				            %>
				            <option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
				            <%  }
							%>
				     </select> 
				     </div>
			        <button type="submit" class="btn btn-primary">Elimina</button>
				</form> 
			</div>
	</div>
</div>

</body>
</html> 