## 研究开发与实践第三周作业
### 1.用记事本或者文本编辑器编写网页
用以下标记实现：```<A><input><p><br><hr><UL><LI><div><select><img>
```+ （1）一个文字链接，点击可以调到百度首页；
+ （2）一个输入框，一个复选框，三个单选按钮，一个下拉框+ （3）用`<p>`和`<br>`分段，`<hr>`制作水平线+ （4）一个清单列表，用`<ul><li>`列出项目组成员+ （5）一个图片链接，点击图片可以跳转川大首页### 2.用记事本编写一个页面，点击提交按钮跳转到下一页


用`<Form>`标记，有`action、method、id`属性。###3.修饰css，页内和单独页外css文件
对第1题的 `img` 进行修饰，做成圆形图片，做两个 html 文件，第一个html内嵌style，第二个html把style放在外部css文件里。
#### 4.做一页面实现通过js检查输入的正确性用js编写按钮的onclick的响应，点击按钮可以执行检查对应输入是否正确，例如手机号
单独页面存放js，html通过页面引用调入
另外在页面上设置一按钮，点击可以显示一个输入框，一个select，一个form和对应的提交按钮。
#### 5.jsp页面处理+ （1）编写一b.jsp页面，通过url链接访问，返回json数据+ （2）编写一a.jsp页面，通过`<form>`访问 b.jsp，最后跳转到c.jsp。即json返回后，执行跳转页面工作：`a.jsp->b.jsp(返回json)->跳转到c.jsp`
### 6. MySQL的使用安装MySQL 5和Navicat 8，创建数据表，导出数据，实现数据表复制和导入。
	### 7.数据库交互

+ （1）用记事本编写一record_list.jsp，从数据库里读取数据，显示数据表里的数据；+ （2）编写一 `record_add.html` 和 `control_action.jsp`，通过`<form>`的方式将数据写进数据库；+ （3）编写一`record_add.html`和`data_action.jsp`，通过json方式传输数据将数据写进数据库；以上的过程注意截图，不能只截取结果。



---

## ISSUE

### 第5题

第5题（2）我觉得老师的表述有问题。

我觉得要实现的效果应该是：

首先 a.jsp 通过 AJAX 来请求 b.jsp；然后 b.jsp 返回一个 JSON 格式的 URL，这个 URL 的值就是 c.jsp；再然后，a.jsp 得到 URL 的值后，通过 JS 跳转到 c.jsp。

JS 的页面跳转方法为 `location.href = url`。

我写的代码目录为：[/class/nodejh/研究开发与实践/第四周作业/5](/class/nodejh/研究开发与实践/第四周作业/5/a.jsp)，可参考一下。

然后，如果 b.jsp 里面有 HTML，是无法正确返回 JSON 格式的。不管 PHP 还是 JSP 不能有 HTML，不然返回的就是一个 HTML 文本。所以 b.jsp 里面就只应该有输出 JSON 的代码，如：

```
<% out.println("{\"url\":\"c.jsp\"}"); %>
```

### 第7题

第 7 题的 (2)、(3) 小题主要是使用 JSP 的 JSTL 标签进行数据库的操作。

#### 1) 直接使用 SQL 语句插入数据

向数据库插入数据的标签主要是 [`<sql:update>`](http://www.runoob.com/jsp/jstl-sql-update-tag.html)。

使用示如下：

```
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/school"
     user="root"  password="root"/>

<sql:update dataSource="${mysql}" var="count">
   INSERT INTO `student` VALUES (null, '小木', '女', '19');
</sql:update>
```

其中 `<sql:update>` 和 `</sql:update>` 标签里面就是 SQL 语句。该 SQL 语句如果执行成功，就会返回插入的行数，并将返回的结果存入 `var` 定义的 `count` 变量。比如上面的语句，是插入一行数据，所以会返回 `1`，也就是插入成功后，`count` 的值就为 `1`。


#### 2) 在 SQL 语句中通过占位符来使用变量

上面的例子中，`VALUES` 的值都是已经写好的字符串，但大多时候，我们需要插入的数据都是一个变量。要插入变量，我们就需要使用到 [`<sql:param>`](http://www.runoob.com/jsp/jstl-sql-param-tag.html) 这个标签。

先来看下面的代码：

```
<% 
String name="小木"; 
String sex = "女";
int age = "19";
%>

<sql:update dataSource="${mysql}" var="count">
   INSERT INTO `student` VALUES (null, ?, ?, ?);
   <sql:param value="<%= name %>" />
   <sql:param value="<%= sex %>" />
   <sql:param value="<%= age %>" />
</sql:update>
```

`<%` 和 `%>` 里面的代码，主要是进行一些变量的初始化，当然这些变量也可以通过 `request.getParameter()` 方法来获取由前端通过 `GET` 或 `POST` 传来的数据。

然后我们再来对比一下这里和之前的的 `<sql:update>` 标签里面的内容，不难发现这里的 `VALUES` 后面的值变成了 `?`，同时还多了 3 个 `<sql:param>` 标签。

这里的 `?` 就是占位符；而 `<sql:param>` 的 `value` 的值，就是设置占位符的值。三个 `<sql:param>` 和三个 `?` 是按顺序一一对应的。当然，如果有四个或更多的占位符，也是一样的道理。这里还需要注意的一点是，`VALUES` 后面的括号里面的值的顺序，也必须和数据库表的字段名顺序一一对应，不然就可能出现把 `name` 插入 `age` 字段，或者由于类型不对而无法正确执行 SQL 语句。


#### 3) 另一个插入语句

前面我们插入语句使用的是 `INSERT INTO student VALUSE (null, '小木', '女', '19');` 的方式。在 MySQL 中我们还有一种插入数据的 SQL 语句：

```
INSERT INTO student SET id=null,name="小木",sex="女",age="19";
```

如果使用占位符的话，同样可以：

```
INSERT INTO student SET id=null,name=?,sex=?,age=?;
```

如果这样写的话，就可以避免前面提到的占位符和据库字段顺序不一致而插入失败的问题。这样写，就只需要我们的 `<sql:param>` 的值和 `SET` 后面的 `?` 所代表的字段值一一对应即可，而不用担心 这里的 `id,name,sex,age` 和数据库里面的字段顺序是否一致。

#### 4) 代码示例


第 7 题 (2) 参考： [/class/nodejh/研究开发与实践/第四周作业/7_2](/class/nodejh/研究开发与实践/第四周作业/7_2/add.html)。

第 7 题 (3) 参考：[/class/nodejh/研究开发与实践/第四周作业/7_3](/class/nodejh/研究开发与实践/第四周作业/7_3/add.html)。




