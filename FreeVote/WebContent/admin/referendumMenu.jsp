<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	    <h6>Seleziona l'operazione da effettuare&colon;</h6>
	    <div class="list-group">
		  <a href="<%=response.encodeURL(request.getContextPath() + "/InserisciMozione")%>" class="list-group-item list-group-item-action">Aggiungi una mozione</a>
		  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaMozione.jsp")%>" class="list-group-item list-group-item-action">Rimuovi una mozione</a>
		</div>
		<br>