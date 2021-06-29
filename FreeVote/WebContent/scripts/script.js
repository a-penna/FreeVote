function checkNomeCognome(inputtxt) {
	var name = /^[A-Za-z]+$/;
	if(inputtxt.value.match(name)) 
		return true;

	return false;	
}

function checkCf(inputtxt)  {
    var name = /^[A-Z0-9]+$/;
	if(inputtxt.value.match(name)) 
		return true;

	return false;	
}
