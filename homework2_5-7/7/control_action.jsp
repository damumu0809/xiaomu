<%@ page import="java.io.*, java.util.*,java.sql.*, javax.servlet.http.*,java.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>添加成功</title>
	<meta content="text/html" charset="utf-8"/>
</head>
<body>
	<% 
		String name=request.getParameter("name");
		String sex=request.getParameter("sex");
		int age=Integer.parseInt(request.getParameter("age"));
	 %>

	 <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
	 	url="jdbc:mysql://localhost/school?useUnicode=true&characterEncoding=UTF-8" 
		user="root" password="111111" />

	<sql:update dataSource="${snapshot}" var="count">
		INSERT INTO `student`  VALUE(null, ? ,? ,?);
		<sql:param value="<%= name %>"/>
		<sql:param value="<%= sex %>"/>
		<sql:param value="<%=age %>"/>
	</sql:update>

	<c:choose>
   		 <c:when test="${count == 1}">
       			插入成功!
    		</c:when>
    		<c:otherwise>
      			 插入失败!
    		</c:otherwise>
	</c:choose>

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