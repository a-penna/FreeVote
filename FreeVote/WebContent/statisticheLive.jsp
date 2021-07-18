<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	String nVotantiPol = (String)request.getAttribute("nVotantiPol");
	
	if(nVotantiPol == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Statistiche"));
		return; 
	}
	
	String nBianche = (String)request.getAttribute("nBianche");
	
	if(nBianche == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Statistiche"));
		return; 
	}
	
	String nVotantiRef = (String)request.getAttribute("nVotantiRef");
	
	if(nVotantiRef == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Statistiche"));
		return; 
	}
	
	String nonVotanti = (String)request.getAttribute("nonVotanti");
	
	if(nonVotanti == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Statistiche"));
		return; 
	}
	
	String nAstenuti = (String)request.getAttribute("nAstenuti");

	if(nAstenuti == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Statistiche"));
		return; 
	}
	
	Collection<?> affluenza = (Collection<?>)request.getAttribute("affluenza");

	if(affluenza == null) {
		response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/Statistiche"));
		return; 
	}	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, statistiche live, live, risultati live">
	<meta name="description" content="Statistiche Live">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Statistiche Live</title>
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
	
	<div class="container pt-5 text-center">
	<h5><b>DATI STATISTICI</b></h5>
	    <br>
		<div class="card text-white bg-primary mb-3">
  			<div class="card-header">AFFLUENZA ELETTORI NEI DIVERSI GIORNI DELLE VOTAZIONI</div>
  			<div class="card-body bg-light">	    
				<table class="table table-striped table-bordered text-center">
						<tbody>
						<% 	Iterator<?> it = affluenza.iterator();	
										while(it.hasNext()) { 
											String perc = (String)it.next();
											String[] tableEl = perc.split(" ");
						%> 
						    	<tr class="table-primary">
						      	   <th scope="row">Data</th>
						      	   <th scope="row">&percnt;Votanti</th>
						    	</tr>
						    	<tr>
						      	   <td><%=tableEl[0]%></td>
						           <td><%=tableEl[1]%></td>
						    	</tr>
						<%
															}
					    %>
						</tbody>
				</table>
			</div>
	 	</div>
	 </div>

	<div class="container pt-5">
  	    <div class="card text-white bg-warning mb-3">
  			<div class="card-header">ELEZIONI POLITICHE</div>
  			<div class="card-body bg-light">	    
				<table class="table table-stripered table-bordered text-center">
						<tbody>
							    <tr class="table-warning">
							       <th><p>Numero voti espressi</p></th>
							       <th><p>Numero schede Bianche</p></th>
					   	        </tr>
							    <tr>
								   <td><%=nVotantiPol%></td>
								   <td><%=nBianche%></td>
							    </tr>
						</tbody>
				</table>
			</div>
		</div>
	 </div>


	<div class="container pt-5">
		<div class="card text-white bg-success mb-3">
  			<div class="card-header">REFERENDUM</div>
  			<div class="card-body bg-light">	    
				<table class="table table-striped table-bordered text-center">
						<tbody>
								<tr class="table-success">
      							   <th><p>Numero preferenze espresse</p></th>
      							   <th><p>Numero astenuti</p></th>
    							</tr>
    							<tr>
      							   <td><%=nVotantiRef%></td>
      							   <td><%=nAstenuti%></td>
    							</tr>
      					</tbody>
				</table>
			</div>
		 </div>
	 </div>
		
	<div class="container pt-5">
		<div class="card text-white bg-danger mb-3">
  			<div class="card-header">ALTRE STATISTICHE</div>
  			<div class="card-body bg-light"">	    
				<table class="table table-striped table-bordered text-center">
						<tbody>
								<tr class="table-danger">
      							   <th><p>Numero totale non votanti</p></th>
    							</tr>
    							<tr>
      							   <td><%=nonVotanti%></td>
    							</tr>
      					</tbody>
				</table>
			</div>
		 </div>
	 </div>
			  
</body>
</html>



