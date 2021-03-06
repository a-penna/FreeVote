<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

				    <h6>Seleziona l'operazione da effettuare&colon;</h6>
				    <div class="list-group">
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciPartito.jsp")%>" class="list-group-item list-group-item-action"> Inserisci un nuovo partito</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaPartito.jsp")%>" class="list-group-item list-group-item-action">Elimina un partito</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciPartitoCoalizione.jsp")%>" class="list-group-item list-group-item-action">Inserisci un partito in una coalizione</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaPartitoCoalizione.jsp")%>" class="list-group-item list-group-item-action">Elimina un partito da una coalizione</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciCoalizione.jsp")%>" class="list-group-item list-group-item-action">Crea una coalizione</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaCoalizione.jsp")%>" class="list-group-item list-group-item-action">Elimina una coalizione</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/inserisciCandidato.jsp")%>" class="list-group-item list-group-item-action">Aggiungi un candidato ad un partito</a>
					  <a href="<%=response.encodeURL(request.getContextPath() + "/admin/eliminaCandidato.jsp")%>" class="list-group-item list-group-item-action">Rimuovi un candidato da un partito</a>
					</div>
					<br>