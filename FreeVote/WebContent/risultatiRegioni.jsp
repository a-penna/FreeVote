<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> regioni = (Collection<?>)request.getAttribute("regioni");
	
	if(regioni == null) {
		response.sendRedirect(response.encodeRedirectURL("/FreeVote/RisultatiReg"));
		return; 
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni, risultati per regione">
	<meta name="description" content="Risultati votazioni per regione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Risultati per Regione</title>
</head>
<body>
	<%@ include file="header.jsp"%>
    <br/>
    <h3>Scegliendo il nome di una regione sarà possibile visualizzare 
    	in percentuale le preferenze politiche espresse dagli abitanti</h3>

	<%String regione = (String)request.getAttribute("regione");
	  if (regione == null) regione = "";
	%>
	
    <form action="RisultatiReg" method="post"> 
    	<label for="regione">Regione&colon; </label>
        <select name="regione">
            <%
            Iterator<?> it = regioni.iterator();
            while(it.hasNext()) {
                String r = (String)it.next(); 
            	if (r.equals(regione)) {
            %>
                    <option value="<%=r%>" selected><%=r%></option>
            <%  } else { %>
            	<option value="<%=r%>"><%=r%></option>           
            <% }
            }
            %>
        </select> 
        <br>
        <input type="submit" value="Scegli"/>
    </form> 
    
    <%  
    	Collection<?> percentuali = (Collection<?>)request.getAttribute("percentuali");
		if (percentuali != null) { %>
    <table>
    	<tr>
 			<th>Partito</th>
 			<th>&percnt;Abitanti</th>
		</tr>
		<% 	it = percentuali.iterator();	
			while(it.hasNext()) { 
				String perc = (String)it.next();
				String[] tableEl = perc.split(" ");
		%> 
		<tr>
 			<td><%=tableEl[0]%></td>
 			<td><%=tableEl[1]%></td>
    	</tr>
	<%
			}
		}
    %>
    </table>
</body>
</html>