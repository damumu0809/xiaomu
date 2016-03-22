function verify(){
	var phoneNumber = document.getElementById("phone").value;
	var reg = /^1[0-9]{10}$/;
	if(!reg.test(phoneNumber))
		alert("手机号错误！");
	else
		alert("手机号正确！");
}


function display(){
	document.getElementById("show").style.display = "block";
}