<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %> 
<html>
  <head>
    <title>Hello World</title>
    <style type="text/css">
table {
  text-align: center;
}
.project {
  margin: 50px 0;
  display: table;
  width: 300px;
  height: 200px;
  text-align: center;
  border: 1px solid #000;
}
.left {
  width: 100px;
  height: 100%;
  float: left;
}
.right {
  width: 199px;
  height: 100%;
  display: table-cell;
  vertical-align: middle;
  border-left: 1px solid #000;
}

    </style>
  </head>

  <body>
    <table border=1>
      <thead>
        <tr>
          <th></th>
          <th>项目1</th>
          <th>项目2</th>        
          <th>项目3</th>        
          <th>项目4</th>                
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

    <div class="project">
      <div class="left">项目组</div> 
      <div class="right">项目执行</div>   
    </div>
  </body>

</htm>
