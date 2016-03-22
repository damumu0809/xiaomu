<!DOCTYPE html>
<html>
<head>
    <title>1  </title>
    <%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
</head>

<body>
<a href="http://baidu.com">返回百度首页</a>
    <form>
        项目组名
        <input type="text" name="groupname"/>
        <br/>

        项目主题
        <select name="theme">
            <option value="project">项目管理子系统</option>
            <option value="weixin">微信警务</option>
            <option value="hospital">医院管理子系统</option>
            <option value="class">移动互动课堂</option>
        </select>
        <br/>

        项目成员数
        <input type="radio" name="numberOfMembers" value="3"/>3 
        <input type="radio" name="numberOfMembers" value="4"/>4 
        <input type="radio" name="numberOfMembers" value="5"/>5
        <br/>
        
        选择成员
        <input type="checkbox" name="1"/>大娃
        <input type="checkbox" name="1"/>二娃
        <input type="checkbox" name="1"/>三娃
        <input type="checkbox" name="1"/>四娃
        <input type="checkbox" name="1"/>五娃
        <input type="checkbox" name="1"/>六娃
        <input type="checkbox" name="1"/>七娃
        <br/>

    </form>

    <p>我是分界线 </p>
    <hr/>
    <p>项目计划</p>
    <ul>
        <li>需求分析</li>
        <li>架构设计</li>
        <li>编写代码</li>
        <li>测试发布</li>
    </ul>

    <a href="http://scu.edu.cn">
        <img src="http://www.scu.edu.cn/portal2013/lib/images/logo.jpg">
    </a>

</body>
</html>
