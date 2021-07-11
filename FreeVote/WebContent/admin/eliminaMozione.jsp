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
		<p>Inserisci i dati nel seguente form per eliminare una mozione già presente: <p>
	
		<form action="<%=response.encodeURL("/FreeVote/EliminaMozione")%>" method="POST"> 
			<div class="form-group">
		        <fieldset>
		        <legend>Inserisci l'ID della mozione da rimuovere&colon; </legend> <!-- Testo, Nome completo autore-->
					<select class="form-select" name="id" required>
						<option disabled selected>ID della mozione&colon;</option>
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
		        <br>
		        <button type="submit" class="btn btn-primary">Elimina</button>
	        </div>
		</form> 
	</div>

</body>
</html> 