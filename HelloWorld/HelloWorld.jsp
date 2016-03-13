<!DOCTYPE html>
<html>
<head>
	<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %> 
	<meta charset="utf-8">
	<title>HelloWorld</title>
	<link rel="stylesheet" type="text/css" href="HelloWorld.css">
</head>

<body>
<div class="whole">
	<h1>Hello World!</h1>

	<p>以下是项目安排：用&lttable&gt实现</p>

	<table>
		<thead>
			<tr>
				<td></td>
				<td>项目1</td>
				<td>项目2</td>
				<td>项目3</td>
				<td>项目4</td>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td>待办事项1</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td>待办事项2</td>
				<td></td>
				<td></td>
				<td></td>
				<td>出差</td>	
			</tr>

			<tr>
				<td>待办事项3</td>
				<td></td>
				<td>开会</td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>	
		
	<p>以下是用&ltdiv&gt标签实现，同一行，两个DIV</p>

	<div>
		<div class="text1">项目组</div>

		<div class="text2"> 
			<p class="text3">项目执行</p>
		</div>
	</div>
	
</div>
</body>
</html>