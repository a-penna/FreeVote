function checkNomeCognome(inputtxt) {
	var name = /^[A-Za-z]+$/;
	if(inputtxt.value.trim().match(name)) 
		return true;

	return false;	
}

function checkNomeCompleto(inputtxt) {
	var name = /^[A-Za-z ]+$/;
	if(inputtxt.value.trim().match(name)) 
		return true;

	return false;	
}

function checkNomePartitoCoalizione(inputtxt) {
	var name = /^[0-9A-Za-z ]+$/;
	if(inputtxt.value.trim().match(name)) 
		return true;

	return false;	
}

function checkEta(inputtxt) {
	var name = /^[0-9]+$/;
	if(!inputtxt.value.trim().match(name)) {
		return false; 
	}

	if((inputtxt.value.trim() < 18) || (inputtxt.value.trim() > 130)) {
		return false;	
	}
	
	return true;
}

function checkCAP(inputtxt) {
	var name = /^\d{5}$/;
	if(!inputtxt.value.trim().match(name)) {
		return false; 
	}
	
	return true;
}

function checkCf(inputtxt)  {
    var name = /^[A-Z]{6}\d{2}[A-Z]\d{2}[A-Z]\d{3}[A-Z]$/i;
	if(inputtxt.value.trim().match(name)) 
		return true;

	return false;	
}

function toUpperCaseCf()  {
	var cf = document.getElementById("cf");
	cf.value = cf.value.toUpperCase();
}

