# 通过 JS 添加自定义菜单

## 1. 复制 `menu` 目录

`/class/nodejh/研究开发与实践/第七周作业/memu/` 目录是一个已经构建好的 [Express](http://www.expressjs.com.cn/) 项目框架。接下来，你需要使用 Express 框架来创建一个 Web 应用，以此来运行老师给的模板，并实现模板菜单的修改。

比如现在我们把 `menu` 目录复制到 `/class/xiaomu/` 下：

```
$ cp -r class/nodejh/研究开发与实践/第七周作业/menu class/xiaomu/
```

然后推荐使用 Webstrom 进行代码编辑。

## 1. 安装 Express 及其依赖模块


```
$ cd class/xiaomu/menu
$ npm install 
```

运行后，控制台应若输出 `Server listening aon port 3000`，则说明应用启动成功。这个时候在浏览器中输入 `localhost:3000` 就可以看到默认的欢迎页面。

## 3. 下载老师给的模板





