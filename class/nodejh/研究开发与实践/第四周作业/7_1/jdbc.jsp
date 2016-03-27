<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
<title>SELECT Operation</title>
</head>
<body>
 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/school"
     user="root"  password="root"/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT * from student  (${name});
</sql:query>
 
<table border="1">
<tr>
   <th>Student ID</th>
   <th>Name</th>
   <th>Age</th>
   <th>Sex</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.id}"/></td>
   <td><c:out value="${row.name}"/></td>
   <td><c:out value="${row.age}"/></td>
   <td><c:out value="${row.sex}"/></td>
</tr>
</c:forEach>
</table>
 
</body>
</html>