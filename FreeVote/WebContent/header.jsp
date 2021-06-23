<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
	boolean isAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
%>
   
<nav class="navbar navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
<a class="nav-link" href="<%=response.encodeURL("/FreeVote/home.jsp")%>">Home<span class="sr-only">(current)</span></a>
      </li>
     <% if (isAdmin) { %>
    	 <li class="nav-item">
         <a class="nav-link" href="<%=response.encodeURL("/FreeVote/admin/interfacciaAdmin.jsp")%>">Interfaccia Admin</a>
       </li> <%
     } %>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/PartitiControl")%>">Partiti</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/Referendum")%>">Referendum</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Risultati
        </a>
        <div class="dropdown-menu bg-dark" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="<%=response.encodeURL("/FreeVote/Risultati")%>">Risultati Generali</a>
          <a class="dropdown-item" href="<%=response.encodeURL("/FreeVote/risultatiPerEta.jsp")%>">Risultati per fascia d'et&agrave;</a>
          <a class="dropdown-item" href="<%=response.encodeURL("/FreeVote/risultatiRegioni.jsp")%>">Risultati per Regione</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href=<%=response.encodeURL("/FreeVote/risultatiReferendum.jsp")%>">Risultati Generali Referendum</a>
        </div>
      </li>
     <% 
     	boolean isElettore = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
		if (isElettore) { %>
			<li class="nav-item">
              <a class="nav-link" href="<%=response.encodeURL("/FreeVote/elettore/schedaVoto.jsp")%>">Vai alla scheda</a>
      		</li>
	<%	} %>
      <li class="nav-item">
              <a class="nav-link" href="<%=response.encodeURL("/FreeVote/infoEContatti.jsp")%>">Info &amp; Contatti</a>
      </li>
    <%
      	if (isElettore || isAdmin) { %>
      		<li class="nav-item">
              <a class="nav-link" href="<%=response.encodeURL("/FreeVote/Logout")%>">Logout</a>
      		</li> <%
		}
	%>
    </ul>
  </div>
</nav>
