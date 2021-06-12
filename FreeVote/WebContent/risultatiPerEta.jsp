<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");
     
    if(partiti == null) {
        response.sendRedirect(response.encodeRedirectURL("./EtaControl")); 
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni, risultati per et&agrave;">
	<meta name="description" content="Risultati votazioni per et&agrave;">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Risultati per et&agrave;</title>
</head>            

<body>
	<%@ include file="header.html"%>
    <br/>
    <p>Scegliendo il nome di un partito ed inserendo una particolare fascia d'et&agrave; potrai visualizzare, in percentuale,
    quante votazioni quel partito ha ricevuto in quella specifica fascia d'et&agrave; </p>

    <form action="EtaControl" method="post"> 
    	<label for="partito">Partito&colon; </label>
        <select name="partito">
            <%
            Iterator<?> it = partiti.iterator();
            while(it.hasNext()) {
                PartitoBean partito = (PartitoBean)it.next();    
                if (!partito.getNome().equals("Scheda Bianca")) {  
            %>
            <option value="<%=partito.getNome()%>"><%=partito.getNome()%></option>
            <%  } 
            }
            %>
        </select> 
        <br>
        <label for="eta">Et&agrave; minima&colon; </label>
        <input type="number" id="eta" name="minima" min="18" max="120">

        <label for="eta">Et&agrave; massima&colon; </label>
        <input type="number" id="eta" name="massima" min="18" max="120">

		<%
		  String percentuale = (String) request.getAttribute("percentuale");
		  if (percentuale != null) { %>
			  %> <p><%=request.getParameter("partito")%> ha ricevuto dalla fascia d'et&agrave;
			   <%=request.getAttribute("minimo")%>&sol;<%=request.getAttribute("massimo")%> il <%=percentuale%>&percnt; dei voti</p>
		 <% }
		%>
		<br>
		<input type="reset" value="Reset"/>
        <input type="submit" value="Invia"/>
    </form> 
 
</body>
</html>