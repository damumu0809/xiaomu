# 研究开发与实践作业中，所谓的菜单权限

这个作业，我的理解就是，先把菜单保存在数据库的表中，然后查询不同的表得到不同的菜单，然后将菜单显示出来。

为了和第一个作业分开，我把第二个作业写在 menu_2 这个目录。最开始 menu_2 是复制的 menu 目录。

```
cp -r menu menu_2
```

接下来就开始吧。

## 1. 安装 MySQL 5.7

首先在 Windows 下安装 MySQL。

下载地址：[http://dev.mysql.com/downloads/installer/](http://dev.mysql.com/downloads/installer/)

找到 384.7M 大小的安装程序，下载，然后安装。

安装后启动，具体界面我不是很清楚，因为我好久没装过。有问题就直接问吧。

然后可以下载一个 Navicat for MySQL 并激活。

Navicat for MySQL 下载地址：[https://www.navicat.com/download](https://www.navicat.com/download)。找到 Navicat for MySQL 下载。

Naviact for MySQL 注册码（激活）： [http://toutiao.com/i6263298671777939970/?iid=3828508039&app=news_article](http://toutiao.com/i6263298671777939970/?iid=3828508039&app=news_article)

## 2. 创建保存菜单的表

根据老师的要求，我们可以有很多种建表的方式。接下来的建表方式只是其中一种。

假设我们系统菜单权限主要针对已登陆用户和未登陆用户。如果是已登陆用户，我们的菜单可能就有：主页，个人中心。而未登陆用户，菜单可能就有：主页，登陆，注册。所以我们可以创建两张表，分别用来保存管理员和普通用户的菜单。如下：

```
// login_menu
|id|name|
|1|主页|
|2|个人中心|

// not_login_menu
|id|name|
|1|主页|
|2|登陆|
|3|注册|

```

如果安装了 Naviact for MySQL，就可以使用 Naviact for MySQL 来管理 MySQL，使用 NAvicat 来建表即可。如果不会使用，请联系我，给你演示一下比在这里写要简单明了很多。如果没有安装，也没关系，打开 MySQL Console，然后输入下面的代码创建 menu 数据库并创建两张表即可：

```
CREATE DATABASE menu DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

CREATE TABLE IF NOT EXISTS `login_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `not_login_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
```

然后往数据库的两张表分别插入数据：

```
INSERT INTO `login_menu`(`id`, `name`) VALUES (null,"主页"),(null,"个人中心");
INSERT INTO `not_login_menu`(`id`, `name`) VALUES (null,"主页"),(null,"登陆"),(null,"注册");
```

现在我们的数据库里面就有了不同权限的菜单了。接下来，要查询这些菜单，并在页面上显示出来。

## 3. 创建一个新的路由

使用 Webstorm 打开 `menu_2` 目录，然后打开 `menu_2/routes/index.js`，在 

```
app.get('/', function (req, res) {
    res.render('index', { title: 'Express' });
  });
```

后面添加如下代码：

```
app.post('/menu', function (req, res) {
    var menu = {};
    res.json(menu);
  });
```

这行代码的意思是，监听通过 POST 请求的 `/menu` 路由，也就是 `host:port/menu` 这个 URL，在这个应用里，为 `localhost:3001/menu`，访问它的时候，就会执行回调函数里的代码。

再来看看上一个路由的 `res.render()`，它的意思是渲染模板，第一个参数是模板名称（不带后缀），第二个参数是传递给模板的变量。这里模板名称是 `menu`，程序就会找到 `views` 目录下的 `index.ejs`，并在浏览器中显示出来。变量的格式是 JS 对象，这个对象里有一个 `title` 属性。

然后新建的路由里面是 `res.json()`，也就是返回一个 JSON 对象给发送请求的客户端。这里我们返回的 JSON 对象为空。

## 4. 修改模板文件

接下来我们简单修改一下 `index.ejs` 模板文件。

在 `<body>` 标签下添加如下两行代码：

```
<div style="top: 20px;position: absolute;z-index: 99">
	<button type="button" id="not_login">未登陆菜单</button>
	<button type="button" id="login">已登陆菜单</button>
</div>
```

启动程序：

```
node app.js
```

然后打开 `localhost:3000` 就可以看到页面左上角出现了两个按钮。我们主要通过这个两个按钮来演示根据权限显示菜单的功能。如：点击“未登陆菜单”就显示“未登陆权限”的菜单，点击“已登陆菜单”就显示“已登陆权限”菜单。

## 5. 修改 menu.js

因为我们需要从数据库获取菜单并显示，所以我们还需要修改一下 `menu.js`，以便向后台发送 HTTP 请求，并得到对应的菜单值。

注视掉之前的所有代码，添加如下代码：

```
// 监听 "未登陆菜单" 按钮的点击事件
$('#not_login').on('click', function() {
  show_menu('not_login');
});


// 监听 "已登陆菜单" 按钮的点击事件
$('#login').on('click', function() {
  show_menu('login');
});


// 根据不同的类型获取菜单并显示
function show_menu(type) {
  var data = {
    type: type
  };
  $.post('/menu', data, function(res) {
    console.log(res);
    if (res.code == 0) {
      var nav = '<ul>';
      res.menu.map(function(item) {
        nav += '<li><a href="#">' + item.name + '</a></li>';
      });
      nav += '</ul>';
      $('#nav').empty().html(nav);

    } else {
      alert('获取菜单失败!');
    }

  });
}
```

这个时候，访问 `localhost:3000`，菜单已经没有了。接下来为们还要做的就是，后台接收 `menu.js` 里面发送的获取菜单请求，并返回响应的数据。

## 6. 安装 MySQL 依赖包

因为我们的数据是存储在 MySQL 的，所以我们要对 MySQL 进行操作。那么久需要安装 MySQL 依赖包。

```
cd menu_2
npm install --save mysql
```

然后修改 `app.js`，引入 MySQL。在 `var bodyParser = require('body-parser');` 下添加下面的代码：

```
var mysql = require('mysql');
var myConnection = require('express-myconnection');
```

然后再在 `app.use(express.static(path.join(__dirname, 'public')));` 下面添加下面的代码：

```
var mysqlConfigOption = {
  host: 'localhost',
  user: 'root',
  password: 'root',
  port: '3306',
  database: 'menu'
};
app.use(myConnection(mysql, mysqlConfigOption, 'request'));
```

注意把数据库配置改为你的数据库配置。

最终的 `app.js` 是下面这样：

```
// app.js

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var myConnection = require('express-myconnection');

var routes = require('./routes/index');

var app = express();

// view engine setup
app.set('port', 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
var mysqlConfigOption = {
  host: 'localhost',
  user: 'root',
  password: 'root',
  port: '3306',
  database: 'menu'
};
app.use(myConnection(mysql, mysqlConfigOption, 'request'));


routes(app);

app.listen(app.get('port'), function() {
  console.log('Server listening aon port ' + app.get('port'));
});

```

## 7. 接收获取菜单的响应

上面我们已经创建了 `app.post('/menu')` 路由，也创建了数据库连接，接下来就该对前台发送的请求做处理。

继续修改 `index.js` 代码，修改后如下：

```
app.post('/menu', function (req, res) {

    var type = req.body.type;
    console.log(type);
    req.getConnection(function(err, connection) {

      if (err) {
        console.log(err);
        res.json({code: 1, msg: err});
        return false;
      }

      var select = '';
      switch (type) {
        case 'not_login':
          select = 'SELECT `name` FROM `not_login_menu`';
          break;
        case 'login':
          select = 'SELECT `name` FROM `login_menu`';
          break;
        default:
          return res.json({code: 2, msg: 'wrong type'});
      }

      connection.query(select, function (err, raws) {

        if (err) {
          res.json({code: 3, msg: err});
          return false;
        }

        console.log('get menu: ', raws);
        res.json({
          code: 0,
          menu: raws
        });
      });

    });
  });
```

最终的 `index.js` 是下面这样：

```
// routes/index.js
module.exports = function(app) {
  app.get('/', function (req, res) {
    res.render('index', { title: 'Express' });
  });


  app.post('/menu', function (req, res) {

    var type = req.body.type;
    console.log(type);
    req.getConnection(function(err, connection) {

      if (err) {
        console.log(err);
        res.json({code: 1, msg: err});
        return false;
      }

      var select = '';
      switch (type) {
        case 'not_login':
          select = 'SELECT `name` FROM `not_login_menu`';
          break;
        case 'login':
          select = 'SELECT `name` FROM `login_menu`';
          break;
        default:
          return res.json({code: 2, msg: 'wrong type'});
      }

      connection.query(select, function (err, raws) {

        if (err) {
          res.json({code: 3, msg: err});
          return false;
        }

        console.log('get menu: ', raws);
        res.json({
          code: 0,
          menu: raws
        });
      });

    });
  });

};

```

然后重启一下：

```
node app.js
```

再打开浏览器，输入 `localhost:3000`，点击一下两个按钮，看看效果呢！

