<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%	
boolean isAdmin = request.getSession(false) != null && request.getSession(false).getAttribute("adminRoles")!= null;
%>
<div class="container-fluid pb-5">   
<nav class="navbar navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
<a class="navbar-brand" href="<%=response.encodeURL(request.getContextPath() + "/home.jsp")%>">
	<img src="<%=request.getContextPath()%>/imgs/logoFreevote3.png" width="50" height="50"  alt="FreeVote"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <% if (isAdmin) { %>
        <li class="nav-item">
        
          <a class="nav-link" href="<%=response.encodeURL(request.getContextPath() + "/admin/interfacciaAdmin.jsp")%>">Interfaccia Admin</a>
        </li> <%
      } %>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL(request.getContextPath() + "/PartitiControl")%>">Partiti</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL(request.getContextPath() + "/Referendum")%>">Referendum</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL(request.getContextPath() + "/statisticheLive.jsp")%>">Statistiche Live</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Risultati
        </a>
        <div class="dropdown-menu mydark-dropdown-menu bg-dark" aria-labelledby="navbarDropdown">
          <a class="dropdown-item mydark-dropdown-item" href="<%=response.encodeURL(request.getContextPath() + "/Risultati")%>">Risultati Generali</a>
          <a class="dropdown-item mydark-dropdown-item" href="<%=response.encodeURL(request.getContextPath() + "/risultatiCoalizioni.jsp")%>">Risultati per coalizione</a>
          <a class="dropdown-item mydark-dropdown-item" href="<%=response.encodeURL(request.getContextPath() + "/risultatiPerEta.jsp")%>">Risultati per fascia d'et&agrave;</a>
          <a class="dropdown-item mydark-dropdown-item" href="<%=response.encodeURL(request.getContextPath() + "/risultatiRegioni.jsp")%>">Risultati per Regione</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item mydark-dropdown-item" href="<%=response.encodeURL(request.getContextPath() + "/risultatiReferendum.jsp")%>">Risultati Generali Referendum</a>
        </div>
       </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL(request.getContextPath() + "/infoEContatti.jsp")%>">Info &amp; Contatti</a>
      </li>
      <% 
      boolean isElettore = request.getSession(false) != null && request.getSession(false).getAttribute("elettoreRoles")!= null;
      
      if (isElettore || isAdmin) { %>
        <li class="nav-item">
          <a class="nav-link" href="<%=response.encodeURL(request.getContextPath() + "/Logout")%>">Logout</a>
      	</li> <%
        } %>
      </ul>
       <% 
        if (isElettore) { %>
        <div class="my-2 my-lg-0">
	      	<a href="<%=response.encodeURL(request.getContextPath() + "/elettore/schedaVoto.jsp")%>" class="btn btn-info">Vai alla scheda</a>
      	  </div>
        <%} else { %>
	      <div class="my-2 my-lg-0">
	      	<a href="<%=response.encodeURL(request.getContextPath() + "/Elettore")%>" class="btn btn-info">Vota</a>
      	  </div>
      	<% } %>
    </div>
  </nav>
</div>