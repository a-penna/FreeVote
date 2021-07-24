<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
    SchedaVoto scheda = (SchedaVoto) request.getAttribute("scheda");
    if (scheda == null) {
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/GestisciVoto"));
   	    return;
    }
    
	Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");
	if (partiti == null) {
  	    response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/GestisciVoto"));
   	    return;
	}
	
%>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, votazioni, scheda voto, scheda elettorale, scheda">
	<meta name="description" content="Scheda voto">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Scheda Elettorale</title>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
		$(document).ready(function(){
		  $("#esprimiPol").change(function(){
		  	if (this.checked) {
		  		$("#politica").slideDown();
			} else {
		    	$("#politica").slideUp();
			}

		  });
		  $("#esprimiRef").change(function(){
			  if (this.checked) {
					$("#referendum").slideDown();
			  } else {
			    	$("#referendum").slideUp();
			  }
		  });
		});
</script>
</head>            

<body>
	<%@ include file="/header.jsp"%>
	<div class="container py-5">
	    <br/>
	    <div class="jumbotron">
		  <h1 class="display-4">SCHEDA</h1>
		    <% 
		    VotazionePoliticaBean vp = scheda.getVP();
		    VotazioneReferendumBean vr = scheda.getVR();
		    
		    if (vp != null) { %>
		       <p class="lead">Partito scelto&colon;</p> 
		       <p class="text-success"><%=vp.getPartito()%></p>
		 <% } 
		    if (vr != null) { %>
		        <p class="lead">Per il referendum hai scelto&colon;</p> 
		        <p class="text-success"><%=vr.getPreferenza()%><p>
		 <% }
		    if (vp == null && vr == null) { %>
		        <p class="lead">La tua scheda elettorale &egrave; vuota&excl;</p>
		 <% }
		    %>
		  <hr class="my-4">
		  <p class="lead">
		  <a class="btn btn-dark" href="<%=response.encodeURL("/FreeVote/GestisciVoto?action=clear")%>" role="button">Reset</a>
		  <a class="btn btn-dark" role="button" data-toggle="modal" data-target="#confermaModal">Conferma</a>
		  </p>
		</div>
	    <br>
		
		<div class="modal fade" id="confermaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Stai per effettuare la tua votazione&excl;</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        Ricorda che&comma; dopo aver votato&comma; il tuo codice sar&agrave; inutilizzabile e non potrai tornare indietro&excl;
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annulla</button>
		        <a href="<%=response.encodeURL("/FreeVote/GestisciVoto?action=vota")%>" class="btn btn-info">Vota</a>
		      </div>
		    </div>
		  </div>
		</div>
		<div class="form-check">
			<input type="checkbox" class="form-check-input" id="esprimiPol">
		  	<label class="form-check-label" for="esprimiPol">Esprimi una preferenza politica</label>
	   	</div>
	    <div id="politica" style="display:none">   
	    	<br> 
		    <%
		    Iterator<?> it = partiti.iterator();
		    while(it.hasNext()) {
		        PartitoBean partito = (PartitoBean)it.next(); 
		        if (!partito.getNome().equals("Scheda Bianca")) {
		            %>

		            <form class="form-inline" action="<%=response.encodeURL("/FreeVote/GestisciVoto")%>" method="post">
			    		
			          <div class="container">
						  <div class="row">
						    <div class="col-lg-4">
						      <img class="rounded-circle mx-auto d-block" src="/FreeVote/PhotoControl?type=partito&id=<%=partito.getNome()%>" height="150" width="150" onerror="this.src='./imgs/nologo.png'">
						    </div>
						    <div class="col-lg-4 align-self-center">
						      <a class="mx-auto d-block" href="<%=response.encodeURL(request.getContextPath() + "/Partito?nome=" + partito.getNome())%>"><%=partito.getNome()%></a>
						    </div>
					            <input type="hidden" name="action"  value="aggiornaPartito"> <!-- hidden form per aggiornare la scheda voto con il partito scelto -->
					            <input type="hidden" name="partitoScelto"  value="<%=partito.getNome()%>">
						    <div class="col-lg-4 align-self-center">
						      <button type="submit" class="btn btn-block btn-dark">Scegli</button>
						    </div>
						  </div>
						</div>
			            <br>
		            </form>
		            <br>
		            <%   	}
		        }     
		     %> 
		     <br>
		</div>
		<div class="form-check">
		    <input type="checkbox" class="form-check-input" id="esprimiRef">
    		<label class="form-check-label" for="esprimiRef">Esprimi una preferenza per il referendum</label>
		</div>
		<br>
		<div id="referendum" style="display:none">
				<form action="<%=response.encodeURL("/FreeVote/GestisciVoto")%>" method="post">
			    		<div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="si" value="Si" name="preferenza" class="custom-control-input">
						  <label class="custom-control-label" for="si">S&igrave;</label>
						</div>
						<div class="custom-control custom-radio custom-control-inline">
						  <input type="radio" id="no" value="No" name="preferenza" class="custom-control-input">
						  <label class="custom-control-label" for="no">No</label>
						</div>
			            <input type="hidden" name="action" value="aggiornaPreferenza"> <!-- hidden form per aggiornare la scheda voto con la preferenza scelta -->
			            <br>
			            <br>
			            <button type="submit" class="btn btn-dark">Aggiungi preferenza alla scheda</button>
			            <br>
		         </form>
		</div>
	</div>
 	
</body>
</html>