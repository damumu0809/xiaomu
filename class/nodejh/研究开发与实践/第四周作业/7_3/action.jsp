<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.tuil.*, java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8" />

<%
String name = request.getParameter("name");
String sex = request.getParameter("sex");
int age = Integer.parseInt(request.getParameter("age"));
%>

<sql:setDataSource var="mysql" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost/school?useUnicode=true&characterEncoding=UTF-8"
	user="root" password="root" />

<sql:update dataSource="${mysql}" var="result">
INSERT INTO `student` SET id=null, name=?, sex=?, age=?;
	<sql:param value="<%= name %>" />
	<sql:param value="<%= sex %>" />
	<sql:param value="<%= age %>" />
</sql:update>

<%
   int result =(int)pageContext.getAttribute("result");
  	
  	if (result == 1) {
   		// 插入成功,返回插入成功的 JSON 提示信息
   		out.println("{\"code\":0, \"message\": \"插入成功\"}");
	} else {
		// 插入失败,返回插入失败的 JSON 提示信息
		out.println("{\"code\":1, \"message\": \"插入失败\"}");
	}   
%>