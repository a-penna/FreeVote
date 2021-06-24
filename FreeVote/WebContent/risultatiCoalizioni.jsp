<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> coalizioni = (Collection<?>)request.getAttribute("coalizioni");
	if(coalizioni == null) {
        response.sendRedirect(response.encodeRedirectURL("/FreeVote/RisultatiCoalizione"));
		return; 
	}

    Collection<?> votazioni = (Collection<?>)request.getAttribute("nVotazioni");
    if(votazioni == null) {
		response.sendRedirect(response.encodeRedirectURL("/FreeVote/RisultatiCoalizione"));
		return; 
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati per coalizione, votazioni, risultati coalizione, coalizione">
	<meta name="description" content="Risultati per coalizione">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Risultati Per Coalizione</title>
</head>
<body>
	<%@ include file="header.jsp"%>
    <h3>Di seguito i risultati ordinati per coalizione&colon;</h3>
	<%
        Iterator<?> it = coalizioni.iterator();
        Iterator<?> it2 = votazioni.iterator();
        while (it.hasNext() && it2.hasNext()) {
            CoalizioneBean c = (CoalizioneBean) it.next();
            String v = (String) it2.next();
            %>
            <p><%=c.getNome()%> &lsqb;Voti&colon; <%=v%>&rsqb;</p>
            <%
        } 
        %>

</body>
</html>