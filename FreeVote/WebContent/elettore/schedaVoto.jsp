<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
    SchedaVoto scheda = (SchedaVoto) request.getAttribute("scheda");
    if (scheda == null) {
        response.sendRedirect(response.encodeRedirectURL("/FreeVote/GestisciVoto"));
   	    return;
    }
    
	Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");
	if (partiti == null) {
  	    response.sendRedirect(response.encodeRedirectURL("/FreeVote/GestisciVoto"));
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
    <br/>
    <h3>SCHEDA</h3>
    <% 
    VotazionePoliticaBean vp = scheda.getVP();
    VotazioneReferendumBean vr = scheda.getVR();
    
    if (vp != null) { %>
       <h2>Partito scelto&colon;</h2> 
        <%=vp.getPartito()%>
 <% } 
    if (vr != null) { %>
        <h2>Per il referendum hai scelto&colon;</h2> 
        <%=vr.getPreferenza()%>
 <% }
    if (vp == null && vr == null) { %>
        <h2>La tua scheda elettorale &egrave; vuota&excl;</h2>
 <% }
    %>
    <br>
    <a href="/FreeVote/GestisciVoto?action=clear">Reset</a>
    <a href="/FreeVote/GestisciVoto?action=vota">Conferma</a>
  	<br>
    <label><input id="esprimiPol" type="checkbox">Esprimi una preferenza politica</label>
    <div id="politica" style="display:none">    
	    <br>
	    <%
	    Iterator<?> it = partiti.iterator();
	    while(it.hasNext()) {
	        PartitoBean partito = (PartitoBean)it.next(); 
	        if (!partito.getNome().equals("Scheda Bianca")) {
	            %>
	    		<img src="/FreeVote/PhotoControl?type=partito&id=<%=partito.getNome()%>" onerror="this.src='./imgs/nologo.png'">   
	            <a href="/FreeVote/Partito?nome=<%=partito.getNome()%>"><%=partito.getNome()%></a>
	            <a href="/FreeVote/GestisciVoto?action=aggiornaPartito&partitoScelto=<%=partito.getNome()%>">Scegli</a>
	            <br>
	            <%   	}
	        }     
	     %> 
	</div>
	    <br>
	    <label><input id="esprimiRef" type="checkbox">Esprimi una preferenza per il referendum</label>
	    <br>
	<div id="referendum" style="display:none">
	    <a href="/FreeVote/GestisciVoto?action=aggiornaPreferenza&preferenza=Si">S&igrave;</a>
	    <a href="/FreeVote/GestisciVoto?action=aggiornaPreferenza&preferenza=No">No</a>
	</div>

 	
</body>
</html>