<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, model.*"%>

<%
    Collection<?> partiti = (Collection<?>) request.getAttribute("partiti");
     
    if(partiti == null) {
        response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/EtaControl")); 
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, risultati, risultati votazioni, votazioni, risultati per et&agrave;, et&agrave;">
	<meta name="description" content="Risultati votazioni per et&agrave;">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
    <title>FreeVote &dash; Risultati votazioni per et&agrave;</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/FreeVote/scripts/script.js"></script>
    <script>
        function validate(obj) {	
            var valid = true;	
            
            var partito = document.getElementsByName("partito")[0];
            if (partito.value == "Seleziona Partito") {
            	valid = false;
            	partito.classList.add("is-invalid");
            } else {
            	 partito.classList.remove("is-invalid");
            }
            
            var minima = document.getElementsByName("minima")[0];
           
            if(!checkEta(minima)) {
                valid = false;
                minima.classList.add("is-invalid");
            } else {
            	 minima.classList.remove("is-invalid");
            }
            
            var massima = document.getElementsByName("massima")[0];            
            if(!checkEta(massima)) {
                valid = false;
                massima.classList.add("is-invalid");
            } else {
            	massima.classList.remove("is-invalid");
            }

            if(valid) obj.submit();
        }
    </script> 

</head>            

<body class="bg-light">
	<%@ include file="header.jsp"%>
	<div class="container py-5">
		<div class="card bg-light text-black mb-3">
  		<div class="card-header text-center">Scegliendo il nome di un partito ed inserendo una particolare fascia d'et&agrave; potrai visualizzare, in percentuale,
    quante votazioni quel partito ha ricevuto in quella specifica fascia d'et&agrave;</div>
  			<div class="card-body">
	<%String partito = (String)request.getAttribute("partito");
	  if (partito == null) partito = "";
	%>
    <form action="<%=response.encodeURL(request.getContextPath() + "/EtaControl")%>" method="get" onsubmit="event.preventDefault(); validate(this)"> 
     <fieldset>
		<div class="form-group">
	    	<label for="partito">Partito&colon; </label>
	    	 <%
				if (request.getAttribute("errorePartito") != null) { %>
					<select name="partito" class="custom-select is-invalid">
						<option disabled selected>Seleziona Partito</option>
			            <%
			            Iterator<?> it = partiti.iterator();
			            while(it.hasNext()) {
			                PartitoBean bean = (PartitoBean)it.next(); 
			            	if (!bean.getNome().equals("Scheda Bianca")) {  
			            %>
			            		<option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
			            <%  } 
			            }
			            %>
			        </select>
			 <%	} else {
        	 %>
	        		<select name="partito" class="custom-select">
			        	<option disabled selected>Seleziona Partito</option>
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
	        <% } %>
       	<div class="invalid-feedback">Selezionare un partito&excl;</div>
        </div> 

        <div class="form-group">
	        <label for="etaMin">Et&agrave; minima&colon; </label>
	        <%
				if (request.getAttribute("erroreEtaMin") != null) {
					%><input type="number" class="form-control is-invalid" id="etaMin" name="minima" min="18" max="130" value="<%=request.getAttribute("min")%>"><% 
				} else if (request.getAttribute("min") != null) {
					%><input type="number" class="form-control" id="etaMin" name="minima" min="18" max="130" value="<%=request.getAttribute("min")%>"><% 
				} else {
					%><input type="number" class="form-control" id="etaMin" name="minima" min="18" max="130"><% 
				}
			%>
            <div class="invalid-feedback">Et&agrave; minima non corretta&excl; Ricorda che il sistema ammette solo un&apos;et&agrave; compresa tra 18 e 130</div>
	    </div>
        <div class="form-group">
	        <label for="etaMax">Et&agrave; massima&colon; </label>
	         <%
				if (request.getAttribute("erroreEtaMax") != null) {
					%><input type="number" class="form-control is-invalid" id="etaMax" name="massima" min="18" max="130" value="<%=request.getAttribute("max")%>"><% 
				} else if (request.getAttribute("max") != null) {
					%><input type="number" class="form-control" id="etaMax" name="massima" min="18" max="130" value="<%=request.getAttribute("max")%>"><% 
				} else {
					%><input type="number" class="form-control" id="etaMax" name="massima" min="18" max="130"><% 
				}
			%>
 <div class="invalid-feedback">Et&agrave; massima non corretta&excl; Ricorda che il sistema ammette solo un&apos;et&agrave; compresa tra 18 e 130</div>	    </div>
        <input type="submit" class="btn btn-dark" value="Invia"/>
       </fieldset>
    </form> 
		<%
		  String percentuale = (String) request.getAttribute("percentuale");
		  if (percentuale != null) { %>
		  <br>
		  <div class="alert alert-info" role="alert">
		  <%System.out.println(request.getAttribute("partito")); %>
			  <a href="<%=response.encodeURL(request.getContextPath() + "/Partito?nome=" + request.getParameter("partito"))%>" class="alert-link"><%=request.getParameter("partito")%></a> ha ricevuto dalla fascia d'et&agrave;
			   <%=request.getAttribute("min")%>&sol;<%=request.getAttribute("max")%> la seguente percentuale di voti&colon; <%=percentuale%>&percnt; 
		  </div>
		 <% }
		%>
 </div>
 
 </div>
 </div>
 
</body>
</html>