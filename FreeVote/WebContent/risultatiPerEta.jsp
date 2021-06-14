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
	<%@ include file="header.jsp"%>
    <br/>
    <h3>Scegliendo il nome di un partito ed inserendo una particolare fascia d'et&agrave; potrai visualizzare, in percentuale,
    quante votazioni quel partito ha ricevuto in quella specifica fascia d'et&agrave; </h3>

	<%String partito = (String)request.getAttribute("partito");
	  if (partito == null) partito = "";
	%>
	
    <form action="EtaControl" method="post"> 
    	<label for="partito">Partito&colon; </label>
        <select name="partito">
            <%
            Iterator<?> it = partiti.iterator();
            while(it.hasNext()) {
                PartitoBean bean = (PartitoBean)it.next(); 
                if (bean.getNome().equals(partito)) {  
                    %>
                    <option value="<%=bean.getNome()%>" selected><%=bean.getNome()%></option>
            <%  } 
            	else if (!bean.getNome().equals("Scheda Bianca")) {  
            %>
            <option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
            <%  } 
            }
            %>
        </select> 
        <br>
        <% String min = (String)request.getAttribute("minima");
           if(min == null) min = "";
           
           String max = (String)request.getAttribute("massima");
           if(max == null) max = "";
        %>
        <label for="eta">Et&agrave; minima&colon; </label>
        <input type="number" id="eta" name="minima" min="18" max="120" value="<%=min%>">

        <label for="eta">Et&agrave; massima&colon; </label>
        <input type="number" id="eta" name="massima" min="18" max="120" value="<%=max%>">

		<%
		  String percentuale = (String) request.getAttribute("percentuale");
		  if (percentuale != null) { %>
			  <p><%=request.getParameter("partito")%> ha ricevuto dalla fascia d'et&agrave;
			   <%=min%>&sol;<%=max%> il <%=percentuale%>&percnt; dei voti</p>
		 <% }
		%>
		<br>
        <input type="submit" value="Invia"/>
    </form> 
 
</body>
</html>