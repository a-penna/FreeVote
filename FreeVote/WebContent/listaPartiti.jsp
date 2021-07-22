<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");

    if (partiti == null) {
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/PartitiControl"));
        return;
    }
    
    Collection<?> coalizioni = (Collection<?>) request.getAttribute("coalizioni");

    if (coalizioni == null) {
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/PartitiControl"));
        return;
    }
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, partiti">
	<meta name="description" content="Piattaforma voto, lista partiti">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Partiti</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
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
	
    
    <div class="container py-5"> 
		<div class="row">
			<div class="col-md">
			    <h2 class="display-5 text-center pt-5">Lista partiti</h2>
			</div>
		</div>
				<br>
				<table class="table text-center">
						<thead class="bg-secondary text-white">
						    <tr>
						      <th scope="col">Partito</th>
						      <th class="text-center" scope="col">Nome Partito</th>
						      <th class="text-center" scope="col">Nome Coalizione</th>
						    </tr>
						  </thead>
						  <tbody>
					  <%
					        Iterator<?> it = partiti.iterator();
					    	Iterator<?> it2 = coalizioni.iterator();
					        while(it.hasNext() && it2.hasNext()) {
					            PartitoBean partito = (PartitoBean)it.next(); 
					            CoalizioneBean coalizione= (CoalizioneBean)it2.next(); 
					            if (!partito.getNome().equals("Scheda Bianca")) {
					  %>		
						  <tr>
								<th scope="row">
								<img class="rounded-corners" src="PhotoControl?type=partito&id=<%=partito.getNome()%>" height=50 width=50 onerror="this.src='./imgs/nologo.png'">
								</th>
								<% if (!coalizione.getNome().equals("")) { %>
								           <td><a href="<%=response.encodeURL(request.getContextPath() + "/Partito?nome=" + partito.getNome())%>"><%=partito.getNome()%></a></td>
										   <td><%=coalizione.getNome()%></td>
							   <%} else { %>
							   			  <td><a href="<%=response.encodeURL(request.getContextPath() + "/Partito?nome=" + partito.getNome())%>"><%=partito.getNome()%></a></td>
										  <td>&dash;</td>
							  <% } %>
						  </tr>
					
					 <%   	}
			        	}
			    	 %>
						</tbody>
						</table>
				</div>
    

</body>
</html>