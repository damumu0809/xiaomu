## 在 Ubuntu 下搭建 PHP、MySQL、Nginx（LEMP）开发环境

### 1. Web Server 介绍

Web Server（Web 服务器或网页服务器）是一个提供网页的服务器程序。每一个网页服务器程序都需要从网络接受HTTP请求，然后提供HTTP回复给请求者。HTTP回复一般包含一个HTML文件，有时也可以包含纯文本文件、图像或其他类型的文件。

现在市面上普遍的网页（HTTP）服务器有：

+ Apache软件基金会的Apache HTTP服务器
+ Microsoft的Internet Information Server（IIS）
+ Google的Google Web Server
+ Nginx公司的nginx
+ 淘宝从nginx改良的Tengine
+ lighttpd公司的lighttpd
+ Cherokee_(Web服务器)
+ Microsoft的FrontPage

以下是顶级网服务器的市场份额在互联网上通过[[en:Netcraft|Netcraft公司]最新统计数据：2014年4月与5月的调查

|产品|	供应商|2014年4月|百分比|2014年5月|百分比|变化|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|Apache|Apache|361,853,003|37.74%|366,262,346|37.56%|-0.18%
|IIS|微软|316,843,695|33.04%|325,854,054	|33.41%|+0.37%
|nginx|NGINX, Inc.|146,204,067|15.25%|142,426,538|14.60%|-0.64%|GWS|谷歌|20,983,310|2.19%|20,685,165|2.12%|-0.07%|

Apache，IIS和Nginx的是互联网上最常用的Web服务器。

严格的来说，Apache/Nginx 应该叫做「HTTP Server」；而 Tomcat 则是一个「Application Server」，或者更准确的来说，是一个「Servlet/JSP」应用的容器（Ruby/Python 等其他语言开发的应用也无法直接运行在 Tomcat 上）。

### 2. 安装 Nginx

安装 Nginx 很简单：

```
sudo apt-get install nginx
```

### 3. 安装 MySQL

### 4. 安装 PHP

### 5. 安装 PHP MyAdmin


---
参考：

+ [网页服务器](https://zh.wikipedia.org/wiki/網頁伺服器)
+ [tomcat 与 nginx，apache的区别是什么？](https://www.zhihu.com/question/32212996)


