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
<body class="bg-light">
	<%@ include file="header.jsp"%>
	
	<div class="container pt-5">
	<h5>Di seguito i dati su&colon;</h5>
	    <br>
	<table class="table table-striped table-bordered text-center">
  <thead>
    <tr>
    <th scope="col"></th>
      <th scope="col"><p>Elezioni Politiche</p></th>
    </tr>
  </thead>
<tbody>
    <tr>
      <th scope="row"># Voti espressi</th>
      <td><%=nVotantiPol%></td>
    </tr>
    <tr>
      <th scope="row"># Schede Bianche</th>
      <td><%=nBianche%></td>
    </tr>
  </tbody>
</table>

	<div class="container pt-5">
	<table class="table table-striped table-bordered text-center">
  <thead>
    <tr>
    <th scope="col"></th>
      <th scope="col"><p>Referendum</p></th>
    </tr>
  </thead>
<tbody>
    <tr>
      <th scope="row"># Preferenze espresse</th>
      <td><%=nVotantiRef%></td>
    </tr>
    <tr>
      <th scope="row"># Astenuti</th>
      <td><%=nAstenuti%></td>
    </tr>
  </tbody>
</table>

	<div class="container pt-5">
	<table class="table table-striped table-bordered text-center">
  <thead>
    <tr>
    <th scope="col"></th>
      <th scope="col"><p>Altre Statistiche</p></th>
    </tr>
  </thead>
<tbody>
    <tr>
      <th scope="row"># Totale non votanti</th>
      <td><%=nonVotanti%></td>
    </tr>
  </tbody>
</table>

	<div class="container pt-5">
	<table class="table table-striped table-bordered text-center">
  <thead>
    <tr>
      <th scope="col">Affluenza elettori nei diversi giorni delle votazioni</th>
    </tr>
  </thead>
<tbody>
<% 	Iterator it = affluenza.iterator();	
				while(it.hasNext()) { 
					String perc = (String)it.next();
					String[] tableEl = perc.split(" ");
			%> 
    <tr>
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
</body>
</html>



