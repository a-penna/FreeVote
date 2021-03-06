<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	String si = (String)request.getAttribute("si");
	if(si == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/RisultatiReferendum"));
		return; 
	}
	String no = (String)request.getAttribute("no");
	String astenuti = (String)request.getAttribute("astenuti");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni, risultati referendum, referendum">
	<meta name="description" content="Risultati votazioni referendum">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Risultati Referendum</title>
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

	<div class="container text-center py-5">
	<div class="card text-white bg-dark mb-3">
  		<div class="card-header text-center">Risultati Referendum</div>
  			<div class="card-body bg-light">
				<table class="table table-bordered">
					<tbody>
				  	<tr class="table-secondary">
				      <th scope="col"></th>
				      <th scope="col">S&igrave;</th>
				      <th scope="col">No</th>
				      <th scope="col">Astenuti</th>
				  	</tr>
				    <tr>
				      <th scope="row">Numero</th>
				      <td><%=si%></td>
				      <td><%=no%></td>
				      <td><%=astenuti%></td>
				    </tr>
				  </tbody>
				</table>
			</div>
</body>
</html>