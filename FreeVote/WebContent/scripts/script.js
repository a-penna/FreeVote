function checkNomeCognome(inputtxt) {
	var name = /^[A-Za-z ]+$/;
	if(inputtxt.value.match(name)) 
		return true;

	return false;	
}

function checkEta(inputtxt) {
	var name = /^[0-9]+$/;
	if(inputtxt.value.match(name)) 
		return true;

	return false;	
}

function checkCf(inputtxt)  {
    var name = /^[A-Z]{6}\d{2}[A-Z]\d{2}[A-Z]\d{3}[A-Z]$/i;
	if(inputtxt.value.match(name)) 
		return true;

	return false;	
}

function toUpperCaseCf()  {
	var cf = document.getElementById("cf");
	cf.value = cf.value.toUpperCase();
}

