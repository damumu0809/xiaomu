<!DOCTYPE html>
<html>
<head>
	<title>a.jsp</title>
	<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
	<script type="text/javascript" src="jquery.js"></script>

</head>
<body>
	<form  >
		<button  id= "button"  type="button">跳转c.jsp</button>
		
	</form>
</body>
<script type="text/javascript">
		$("#button").click(function(){
			$.get("b.jsp", function(res){
				console.log(res);
				var data = $.parseJSON(res);
				location.href = data.url;
			});		
		})
</script>
</html>