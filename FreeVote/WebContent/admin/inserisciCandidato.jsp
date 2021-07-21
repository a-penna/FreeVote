<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" import="java.util.*, model.*"%>

<% 
	Collection<?> partiti = (Collection<?>) request.getAttribute("listaPartiti");
    if (partiti == null) {
        response.sendRedirect(response.encodeURL(request.getContextPath() + "/InserisciCandidato"));
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="FreeVote, piattaforma voto, voto, voto online, operazione admin, inserisci candidato, candidato, inserisci">
	<meta name="description" content="Inserisci candidato">
	<meta name="author" content="Bene Sabato, Cozzolino Lidia, Napoli Riccardo, Penna Alessandro">    
	<title>FreeVote &dash; Inserisci Candidato</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS --> 
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">						
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/script.js"></script>
	<!-- jQuery library --> 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
	<!-- Popper JS --> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
	<!-- Latest compiled JavaScript --> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> 
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

    	function validate(obj) {	
            var valid = true;	

            var name = document.getElementsByName("nome")[0];
            if(!checkNomeCognome(name)) {
                valid = false;
                name.classList.remove("is-valid");
                name.classList.add("is-invalid");
                name.focus();
            } else {
            	 name.classList.remove("is-invalid");
            	 name.classList.add("is-valid");
            }
            
            var surname = document.getElementsByName("cognome")[0];
            if(!checkNomeCognome(surname)) {
                valid = false;
                surname.classList.remove("is-valid");
                surname.classList.add("is-invalid");
                surname.focus();
            } else {
            	surname.classList.remove("is-invalid");
           	 	surname.classList.add("is-valid");
            }

            var codiceF = document.getElementsByName("cf")[0];
            if(!checkCf(codiceF)) {
                valid = false;
                codiceF.classList.remove("is-valid");
                codiceF.classList.add("is-invalid");
                codiceF.focus();
            } else {
            	codiceF.classList.remove("is-invalid");
           	 	codiceF.classList.add("is-valid");
            }
            
            var curriculumC = document.getElementsByName("curriculum")[0];
            if((curriculumC.value.trim() == "")) {
                valid = false;
                curriculumC.classList.add("is-invalid");
                curriculumC.focus();
            } else {
            	curriculumC.classList.remove("is-invalid");
           	 	curriculumC.classList.add("is-valid");
            }
            
            var nomePartito = document.getElementsByName("partito")[0];
            if((nomePartito.value == "Seleziona Partito")) {
                valid = false;
                nomePartito.classList.add("is-invalid");
                nomePartito.focus();
            } else {
            	nomePartito.classList.remove("is-invalid");
           	 	nomePartito.classList.add("is-valid");
            }
            
            if(valid) obj.submit();
        }
    	
    </script>
    
</head>            

	<body class="bg-light">
	<%@ include file="/admin/admin-header.jsp"%>
        <div class="container-fluid py-5">
        	<div class="row">
				<div class="col-md-2">
					<%@ include file="/admin/politicheMenu.jsp" %>
				</div>
				<div class="col-md-10">
					<p>Compila il seguente form per inserire un nuovo candidato all&apos;interno di un partito gi&agrave; registrato sulla piattaforma&colon;<p>
					<form name="form" action="<%=response.encodeURL(request.getContextPath() + "/InserisciCandidato")%>" method="post" enctype="multipart/form-data" onsubmit="event.preventDefault(); validate(this)"> 
		                 <fieldset>
		                    <legend>Informazioni sul candidato&colon; </legend>
		                    <div class="form-group">
		                        <label for="nome">Nome&colon;</label>
								<%
									if (request.getAttribute("erroreNome") != null) {
										%><input type="text" class="form-control is-invalid" id="nome" placeholder="Inserisci Nome" value="<%=request.getAttribute("nome")%>" name="nome"><% 
									} else if (request.getAttribute("nome") != null) {
										%><input type="text" class="form-control is-valid" id="nome" placeholder="Inserisci Nome" value="<%=request.getAttribute("nome")%>" name="nome"><% 
									} else {
										%><input type="text" class="form-control" id="nome" placeholder="Inserisci Nome" name="nome"><% 
									}
								%>
		                        <div class="valid-feedback">Corretto</div>
		                        <div class="invalid-feedback">Nome non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="cognome">Cognome&colon;</label>
		                        <%
									if (request.getAttribute("erroreCognome") != null) {
										%><input type="text" class="form-control is-invalid" id="cognome" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognome")%>" name="cognome"><% 
									} else if (request.getAttribute("cognome") != null) {
										%><input type="text" class="form-control is-valid" id="cognome" placeholder="Inserisci Cognome" value="<%=request.getAttribute("cognome")%>" name="cognome"><% 
									} else {
										%><input type="text" class="form-control" id="cognome" placeholder="Inserisci Cognome" name="cognome"><% 
									}
								%>
		                        <div class="valid-feedback">Corretto</div>
		                        <div class="invalid-feedback">Cognome non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="cf">Codice Fiscale&colon;</label>
		                        <%
									if (request.getAttribute("erroreCf") != null) {
										%><input type="text" class="form-control is-invalid" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" value="<%=request.getAttribute("cf")%>" name="cf"><% 
									} else if (request.getAttribute("cf") != null) {
										%><input type="text" class="form-control is-valid" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" value="<%=request.getAttribute("cf")%>" name="cf"><% 
									} else {
										%><input type="text" class="form-control" onkeyup="toUpperCaseCf()" id="cf" placeholder="Codice Fiscale" name="cf"><% 
									}
								%>
		                        <div class="valid-feedback">Corretto</div>
		                        <div class="invalid-feedback">Codice fiscale non valido&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="curriculum">Curriculum&colon;</label>
		                    <%  if (request.getAttribute("erroreCurriculum") != null) {
		                    		%><textarea class="form-control is-invalid" rows="10" cols="48" id="curriculum" placeholder="Inserisci qui il curriculum" name="curriculum"></textarea><% 
		                    	} else if(request.getAttribute("curriculum") != null) {
									%><textarea class="form-control" rows="10" cols="48" id="curriculum" placeholder="Inserisci qui il curriculum" name="curriculum"><%=request.getAttribute("curriculum")%></textarea><% 
								} else {
									%><textarea class="form-control" rows="10" cols="48" id="curriculum" placeholder="Inserisci qui il curriculum" name="curriculum"></textarea><% 
								}
							%>   
							  <div class="valid-feedback">Corretto</div>
		                      <div class="invalid-feedback">Inserire il curriculum&excl;</div>
		                    </div>
		                    <div class="form-group">
		                        <label for="foto">Carica Foto(Max&period; size&equals;10MB)&colon;</label>
		                        <input id="foto" type="file" accept="image/*" name="foto">  
		                    </div>
		                 </fieldset>
		                 <fieldset>
			                 <legend>Nome del partito in cui inserire il candidato&colon; </legend>
			                 <div class="form-group">
				                 <label for="partito">Nome&colon;</label>
				                 <select class="custom-select" name="partito">
						        		<option disabled selected>Seleziona Partito</option>
							            <%
							            String partito = (String)request.getAttribute("partito");
				                		 if (partito == null) partito = "";
							            Iterator<?> it = partiti.iterator();
							            while(it.hasNext()) {
											PartitoBean bean = (PartitoBean)it.next();
											if (!bean.getNome().equals("Scheda Bianca")) { 
												if (bean.getNome().equals(partito)) {%>
							            		  <option value="<%=bean.getNome()%>" selected><%=bean.getNome()%></option>
							            		<%} else { %>
							            		  <option value="<%=bean.getNome()%>"><%=bean.getNome()%></option>
							            <%		}
							            	}  
										} 
							            %>
							     </select> 
							     <div class="valid-feedback">Selezionato&excl;</div>
							     <div class="invalid-feedback">Seleziona il partito&excl;</div>
			                 </div>
		                 </fieldset>
		               <button type="submit" class="btn btn-dark">Inserisci</button>
		            </form>
		        </div>
		    </div>
        </div>

</body>
</html> 