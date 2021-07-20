<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> partiti = (Collection<?>) request.getAttribute("listaPartiti");
    if (partiti == null) {
        response.sendRedirect(response.encodeURL(request.getContextPath() + "/EliminaPartitoCoalizione"));
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
			
            var nome = document.getElementsByName("nome")[0];
            if((nome.value == "Seleziona Partito")) {
                valid = false;
                nome.classList.add("is-invalid");
                nome.focus();
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
				<%@ include file="/admin/politicheMenu.jsp" %>
			</div>
			<div class="col-md-10">
				<p>Selezionare un partito per scollegarlo dalla sua coalizione&comma; nel caso in cui non ne abbia una l'operazione fallir&agrave;&period;</p>
				<form action="<%=response.encodeURL(request.getContextPath() + "/EliminaPartitoCoalizione")%>" method="post" onsubmit="event.preventDefault(); validate(this)"> 
					    <fieldset>
						<div class="form-group">
					        <select name="nome" class="custom-select">
					        	<option disabled selected>Seleziona Partito</option>
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
						     <div class="invalid-feedback">Seleziona il partito da eliminare&excl;</div>
						</div>
					    	<button type="submit" class="btn btn-primary">Elimina</button>
						</fieldset>
				</form> 
			</div>
		</div>
	</div>
</body>
</html> 