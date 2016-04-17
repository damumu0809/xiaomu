# 通过 JS 添加自定义菜单

## 1. 复制 `menu` 目录

`/class/nodejh/研究开发与实践/第七周作业/express_init/` 目录是一个已经构建好的 [Express](http://www.expressjs.com.cn/) 项目框架。接下来，你需要使用 Express 框架来创建一个 Web 应用，以此来运行老师给的模板，并实现模板菜单的修改。

比如现在我们把 `menu` 目录复制到 `/class/xiaomu/` 下：

```
$ cp -r class/nodejh/研究开发与实践/第七周作业/express_init class/xiaomu/menu
```

然后推荐使用 Webstrom 进行代码编辑。

## 1. 安装 Express 及其依赖模块


```
$ cd class/xiaomu/menu
$ npm install 
```

运行后，控制台应若输出 `Server listening aon port 3000`，则说明应用启动成功。这个时候在浏览器中输入 `localhost:3000` 就可以看到默认的欢迎页面。

按两次 `ctrl + c` 停止应用。

## 3. 下载老师给的模板

[http://cdylx.3322.org:9090](http://cdylx.3322.org:9090)

接下来以 [GymBoom大气商业体育健身运动企业响应式](http://cdylx.3322.org:9090/GymBoom_Bootstrap/index.html) 为例。

## 4. 移动文件到 Express 项目

下载后解压，把解压后当前目录下的 `*.html` (就是所有 html) 文件复制到 `menu` 的 `views/` 目录，并讲 `.html` 的后缀名改为 `.ejs`，因为我们的 Express 项目使用的是 EJS 模板引擎。至于为什么，下面会解释：

EJS 是一个模板引擎，和 JSP 类似，EJS 里面可以写 HTML，并且可以在 `<%` 和 `%>` 标签里面写 JavaScript。这一点和 JSP 是极其相似的。最终 EJS 引擎会将  `<%` 和 `%>` 的内容转换为 HTML。

可以看到，之前 `views` 目录下已经有一个 `index.ejs` 文件，把它删除了即可。`menu` 目录下之前本来有一个 `index.html`，覆盖掉就行。 

然后把其它所有目录和文件移动到 `menu/public/` 目录下。

## 5. 重启应用，看看效果

这个时候，我们先启动一下 node.js 应用，看看效果，和之前一样：

```
$ node app.js
```

然后会发现，首页就可以正常访问了！

但点击导航上的链接，会有类似 `Cannot GET /page_styling.html` 的提示。这是因为我们没有为这个页面添加路由。

这个是即将要学的东西。目前为了完成老师的作业，可以先放着。

## 6. 删除 html 中的菜单

老师作业的要求其实就是，使用 JS 动态添加 HTML 元素。

我们先找到首页的导航的所有 HTML，大概在 40 行至 71 行的 `nav` 标签里面。如下：

```
<nav>
	<ul>
		<li class="current"><a href="./index.html">Home</a></li>
		<li><a href="./page_styling.html">Styles</a></li>
		<li>
			<a href="./trainers.html">Trainers <span class="arrow"></span></a>
			<section class="dropdown">
				<ul>
					<li><a href="./trainer.html">Joey Smith</a></li>
					<li>
						<a href="./trainer.html">Robert Galgoa <span class="arrow"></span></a>
						<section class="dropdown">
							<ul>
								<li><a href="./trainer.html">Joey Smith</a></li>
								<li><a href="./trainer.html">Robert Galgoa</a></li>
								<li><a href="./trainer.html">Franklin Jr.</a></li>
							</ul>
						</section>
					</li>
					<li><a href="./trainer.html">Franklin Jr.</a></li>
					<li><a href="./trainer.html">Sarah Hemmer</a></li>
					<li><a href="./trainer.html">George Norman</a></li>
				</ul>
			</section>
		</li>
		<li><a href="./calendar.html">Calendar</a></li>
		<li><a href="./news.html">News</a></li>
		<li><a href="./gallery.html">Gallery</a></li>
		<li><a href="./contact.php.html">Contact</a></li>
		<li class="phone">(800) 456-7890</li>
	</ul>
</nav>
```


接下来要做的就是，从 html 里面，把 `<nav>...</nav>` 标签里面的内容（不包括`<nav>`和  `</nav>` 本身）都删除，然后给 `<nav>` 添加一个 ID 属性，如： `<nav id="nav">`，供稍后使用。

这个时候我们刷新一下页面（先确定 node 应用已经启动），就会发现导航菜单没有了。

## 7. 定义一个由导航元素的 HTML 组成的字符串



在 `public/` 目录新建一个 `menu.js`，然后在 `views/index.ejs` 的 `<script src="./js/jquery.func.js" type="text/javascript"></script>` 下面引入 `menu.js`：

```
<script src="./js/menu.js" type="text/javascript"></script>
```
接下来在 `menu.js` 里面定义一个 nav 变量。这里的 nav 变量其实就是由很多 HTML 标签组成的一个字符串，这些 HTML 标签就是导航元素的所有 HTML 标签。

由于标签有点多，所以需要耐心一点。最好不要直接复制下面的代码，而是将之前背删掉的 `<nav>...</nav>` 复制过来。

```
var nav = '<ul>' +
  '<li class="current"><a href="./index.html">Home</a></li>'+
  '<li><a href="./page_styling.html">Styles</a></li>'+
  '<li>'+
  '<a href="./trainers.html">Trainers <span class="arrow"></span></a>'+
  '<section class="dropdown">'+
  '<ul>'+
  '<li><a href="./trainer.html">Joey Smith</a></li>'+
  '<li>'+
  '<a href="./trainer.html">Robert Galgoa <span class="arrow"></span></a>'+
  '<section class="dropdown">'+
  '<ul>'+
  '<li><a href="./trainer.html">Joey Smith</a></li>'+
  '<li><a href="./trainer.html">Robert Galgoa</a></li>'+
  '<li><a href="./trainer.html">Franklin Jr.</a></li>'+
  '</ul>'+
  '</section>'+
  '</li>'+
  '<li><a href="./trainer.html">Franklin Jr.</a></li>'+
  '<li><a href="./trainer.html">Sarah Hemmer</a></li>'+
  '<li><a href="./trainer.html">George Norman</a></li>'+
  '</ul>'+
  '</section>'+
  '</li>'+
  '<li><a href="./calendar.html">Calendar</a></li>'+
    '<li><a href="./news.html">News</a></li>'+
    '<li><a href="./gallery.html">Gallery</a></li>'+
    '<li><a href="./contact.php.html">Contact</a></li>'+
    '<li class="phone">(800) 456-7890</li>' +
  '</ul>';
```

## 8. 使用 JS 添加导航菜单

然后就该使用 JS 把变量动态添加到 HTML 中了：

```
document.getElementById('nav').innerHTML = nav;
```

接下来再刷新一下页面，可以发现导航菜单又回来了！

