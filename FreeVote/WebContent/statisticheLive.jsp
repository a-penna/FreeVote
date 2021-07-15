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
    <link rel="stylesheet" type="text/css" href="/FreeVote/css/style.css">						
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
</head>
<body>
	<%@ include file="header.jsp"%>
	
	<div class="container pt-5">
	    <h5>Di seguito i dati su&colon;</h5>
	    <br>
	    <h4>Elezioni Politiche</h4>
	      
		<p class=""> Numero voti espressi&lpar;schede bianche escluse&rpar; &colon; <%=nVotantiPol%></p>
		  
		<p> Numero di schede bianche &colon; <%=nBianche%></p>
		</div>
		
	   <div class="container pt-5">
	   <h4>Referendum</h4>
	      
	    <p> Numero di preferenze espresse &colon; <%=nVotantiRef%></p>
		  
		<p> Numero di astenuti &colon; <%=nAstenuti%></p>
		  
	  	</div>
	  	
	  	<div class="container pt-5">
		<h4> Altre statistiche &colon;</h4>
		<p> Numero totale di non votanti (Persone che non si sono connesse alla piattaforma per votare) &colon; <%=nonVotanti%> </p>
	  	</div>
	  	
	  	<div class="container  pt-5">
	  	<h4>Affluenza elettori nei diversi giorni delle votazioni &colon;</h4> 
	    <table class="table">
	    	<tr>
	 			<th scope="col">Data</th>
	 			<th scope="col">&percnt;Votanti</th>
			</tr>
			<% 	Iterator it = affluenza.iterator();	
				while(it.hasNext()) { 
					String perc = (String)it.next();
					String[] tableEl = perc.split(" ");
			%> 
			<tr>
	 			<td scope="row"><%=tableEl[0]%></td>
	 			<td scope="row"><%=tableEl[1]%></td>
	    	</tr>
		<%
				}
	    %>
	    </table>
	 </div> 
</body>
</html>



