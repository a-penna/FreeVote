<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> coalizioni = (Collection<?>)request.getAttribute("coalizioni");
	if(coalizioni == null) {
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/RisultatiCoalizione"));
		return; 
	}

    Collection<?> votazioni = (Collection<?>)request.getAttribute("nVotazioni");
    if(votazioni == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/RisultatiCoalizione"));
		return; 
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati per coalizione, votazioni, risultati coalizione, coalizione">
	<meta name="description" content="Risultati per coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Risultati Per Coalizione</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body class="bg-light">
	<%@ include file="header.jsp"%>
	
	<div class="container py-5">
	<div class="card text-white bg-dark mb-3">
  		<div class="card-header text-center">Risultati ordinati per coalizione</div>
  			<div class="card-body bg-light">
  				<table class="table table-bordered text-center">
						<tbody>
								 <tr class="table-secondary">
						      	   <th scope="row">Coalizione</th>
						      	   <th scope="row">Numero totale voti</th>
						    	 </tr>
						<%
				        Iterator<?> it = coalizioni.iterator();
				        Iterator<?> it2 = votazioni.iterator();
				        while (it.hasNext() && it2.hasNext()) {
				            CoalizioneBean c = (CoalizioneBean) it.next();
				            String v = (String) it2.next();
		            	%>
						    	<tr>
						      	   <td><%=c.getNome()%></td>
						           <td><%=v%></td>
						    	</tr>
						<%
				       		 }								
					    %>
						</tbody>
				</table>
  			</div>
	</div>
	</div>
</body>
</html>