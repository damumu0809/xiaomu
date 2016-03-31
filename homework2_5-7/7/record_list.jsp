<%@ page import="java.io.*, java.util.*,java.sql.*, javax.servlet.http.*,java.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page language="java"  contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html>
<head>
	<title>record list</title>
</head>
<body>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost/school"
		user="root" password="111111" />

	<sql:query dataSource="${snapshot}" var="result">
		SELECT * from student;
	</sql:query>

	<table border="1" height="200" width="300">
	<tr>
		<td>id</td>
		<td>name</td>
		<td>sex</td>
		<td>age</td>
	</tr>
	<c:forEach var="row" items="${result.rows}">
		<tr>
			<td><c:out value="${row.id}"/></td>
			<td><c:out value="${row.name}"/></td>
			<td><c:out value="${row.sex}"/></td>
			<td><c:out value="${row.age}"/></td>
		</tr>
	</c:forEach>
	</table>

</body>
</html>