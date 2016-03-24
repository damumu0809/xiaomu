<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>a.jsp</title>
</head>
<body>

<form>
	<button id="button" type="button">点击跳转到c.jsp</button>
</form>

</body>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
	$('#button').click(function () {
		var url = 'b.jsp';
		$.get(url, function(res){
			console.log(res);
			var data = $.parseJSON(res);
			var redirect_url = data.url;
			location.href = redirect_url;
		});
	});
</script>

</html>