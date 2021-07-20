<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> mozioni = (Collection<?>) request.getAttribute("mozioni");
    if (mozioni == null) {
        response.sendRedirect(response.encodeURL(request.getContextPath() + "/EliminaMozione"));
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
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        function validate(obj) {	
            var valid = true;	
			
            var idMozione = document.getElementsByName("id")[0];
            if((idMozione.value == "Seleziona ID")) {
                valid = false;
                idMozione.classList.add("is-invalid");
                idMozione.focus();
            } 
            
            if(valid) obj.submit();
        }
    </script> 
</head>            
<body class="bg-light">

	<%@ include file="/admin/admin-header.jsp"%>
	<div class="container-fluid py-5">
	    <div class="row">
			<div class="col-md-2">
				<%@ include file="/admin/referendumMenu.jsp" %>
			</div>
			<div class="col-md-10">
				<p>Inserisci i dati nel seguente form per eliminare una mozione gi&agrave; presente&colon; <p>
				<form action="<%=response.encodeURL(request.getContextPath() + "/EliminaMozione")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
				        <fieldset>
				        <legend>Inserisci l'ID della mozione da rimuovere&colon; </legend> 
						<div class="form-group">
								<select class="custom-select" name="id">
									<option disabled selected>Seleziona ID</option>
						            <%
						            Iterator<?> it = mozioni.iterator();
						            while(it.hasNext()) {
						                MozioneBean bean = (MozioneBean)it.next(); 
						            %>
						            <option value="<%=bean.getID()%>"><%=bean.getID()%></option>
						            <%  } 
						            %>
						     	</select>    
							<div class="invalid-feedback">Seleziona un&apos;ID&excl;</div>
						</div>
				        </fieldset>
				        <button type="submit" class="btn btn-primary">Elimina</button>
				</form> 
			</div>
		</div>
	</div>

</body>
</html> 