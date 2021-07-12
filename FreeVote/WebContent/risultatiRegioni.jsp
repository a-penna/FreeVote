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
		if (percentuali != null && !percentuali.isEmpty()) { %>
    <table>
    	<tr>
 			<th>Partito</th>
 			<th>&percnt;Voti</th>
		</tr>
		<% 	it = percentuali.iterator();	
			while(it.hasNext()) { 
				String perc = (String)it.next();
				if (!perc.contains("Scheda Bianca")) {
					String[] tableEl = perc.split(" ");
		%> 
		<tr>
 			<td><%=tableEl[0]%></td>
 			<td><%=tableEl[1]%></td>
    	</tr>
	<%
				}
			}
		}
    %>
    </table>
</body>
</html>