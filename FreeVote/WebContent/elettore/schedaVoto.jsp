<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");

	if (partiti == null) {
  	    response.sendRedirect(response.encodeRedirectURL("/FreeVote/InfoVoto"));
   	    return;
	}

    SchedaVoto scheda = (SchedaVoto) request.getAttribute("scheda");
    if (scheda == null) {
        response.sendRedirect(response.encodeRedirectURL("/FreeVote/InfoVoto"));
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
    <a href="/FreeVote/GestisciVoto?action=vota">Conferma</a>
  
    <label><input type="checkbox">Esprimi una preferenza politica</label>
        
    <br>
    <%
    Iterator<?> it = partiti.iterator();
    while(it.hasNext()) {
        PartitoBean partito = (PartitoBean)it.next(); 
        if (!partito.getNome().equals("Scheda Bianca")) {
            %>
    		<img src="/FreeVote/PhotoControl?type=partito&id=<%=partito.getNome()%>" onerror="this.src='./imgs/nologo.png'">   
            <label><a href="/FreeVote/Partito?nome=<%=partito.getNome()%>"><%=partito.getNome()%></a>
            <a href="/FreeVote/GestisciVoto?partitoScelto=<%=partito.getNome()%>">Scegli</a>
            <br>
            <%   	}
        }     
     %> 
    <label><input type="checkbox">Esprimi una preferenza per il referendum</label>
    <br>
    <a href="/FreeVote/GestisciVoto?preferenza=Si">S&igrave;</a>
    <a href="/FreeVote/GestisciVoto?preferenza=No">No</a>
    <a href="/FreeVote/GestisciVoto?preferenza=Mi_Astengo">Mi Astengo</a>

    </form>
 	
</body>
</html>