<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.tuil.*, java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登记学生信息</title>
</head>
<body>

<%
String name = request.getParameter("name");
String sex = request.getParameter("sex");
int age = Integer.parseInt(request.getParameter("age"));
%>


<sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost/school"
	user="root" password="root" />

<sql:update dataSource="${mysql}" var="result">
INSERT INTO `student` VALUES (null, ?, ?, ?);
	<sql:param value="<%= name %>" />
	<sql:param value="<%= sex %>" />
	<sql:param value="<%= age %>" />
</sql:update>


<c:out value="${result}" />
</body>
</html>