<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container-fluid pb-5">   
<nav class="navbar navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
<a class="navbar-brand" href="<%=response.encodeURL("/FreeVote/admin/interfacciaAdmin.jsp")%>">
	<img src="/FreeVote/imgs/logofreevote1.png" width="60" height="60"  alt="Logo FreeVote Admin">  FreeVote Admin
</a>

  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/home.jsp")%>">FreeVote Home<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/admin/gestionePolitiche.jsp")%>">Gestisci Politiche</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/admin/gestioneReferendum.jsp")%>">Gestisci Referendum</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/admin/eliminaElettore.jsp")%>">Elimina un Elettore</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=response.encodeURL("/FreeVote/Logout")%>">Logout</a>
      </li>
      </ul>
    </div>
  </nav>
</div>

