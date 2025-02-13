function checkValue(obj, msg){
	var result = false;
	if(obj.value == ""){
		alert(msg);
		obj.focus();
		result = true;
	}
	return result;
}

function checkLength(obj,maxLength,msg){
	var result = false;
	if(obj.value.length > maxLength){
		alert(msg);
		obj.select();
		result = true;
	}
	return result;
}	