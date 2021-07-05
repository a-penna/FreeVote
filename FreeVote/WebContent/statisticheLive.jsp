<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 

	
	
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, statistiche live">
	<meta name="description" content="Statistiche Live">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Statistiche in tempo reale</title>
	<script src="jquery.js"></script>


	<!--  	<script>
		$(document).ready(function() {
			
			$('#btn_refresh').click(function() {
				var bianche = //Prendere dal database
				var astenuti = //Prendere dal database
				var votanti = //Prendere dal database
				if($.trim(bianche) != '' && $.trim(astenuti) != '' && $.trim(votanti) != '') {
					
					$.ajax({
						url:"statistiche.jsp",
						method:"GET",
						data:
						
					})
					
				}
			}
			
		}


    </script> -->
</head>
<body>
	<%@ include file="header.jsp"%>
    <h3>Statistiche aggiornate in tempo reale&colon;</h3>
	  <form name="refresh" method="get">
      
	  <p> Numero di schede bianche : <p>
      
      <br>
      <p> Numero astenuti : <p>
	  <br>
	  <p> Numero votanti : <p>
	  <br>
	  <div class="form-group">
	  <input type="button" name="btn_refresh" id="btn_refresh"> 
	  </div>
	  </form>
	  
	  
</body>
</html>



