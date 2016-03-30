<%@ page import="java.io.*, java.util.*,java.sql.*, javax.servlet.http.*,java.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>

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

	<%
		// int c= (int)pageContext.getAttribute("count")
		int result =(int)pageContext.getAttribute("count");
  	
  	if (result == 1) {
   		// 插入成功,返回插入成功的 JSON 提示信息
   		out.println("{\"message\": \"插入成功\"}");
	} else {
		// 插入失败,返回插入失败的 JSON 提示信息
		out.println("{\"message\": \"插入失败\"}");
	}   
		
	%>

