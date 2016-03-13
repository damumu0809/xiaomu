## Ubuntu 下安装 fcitx 拼音输入法

### 1. 添加 fcitx 源

首先在终端输入：

```
sudo add-apt-repository ppa:fcitx-team/nightly
```

或

```
sudo add-apt-repository ppa:fcitx-team/stable
```

然后更新软件源：

```
sudo apt-get update
```


### 2. 安装

```
sudo apt-get install fcitx-pinyin 
```

安装后重启，系统右上角菜单栏就会有个小企鹅图标了，点击它就可以切换中英文。当然还有快捷键切换，自己摸索啦！


### 3. 其它

将系统设置为中文：[Linux Ubuntu：系统怎么设置成中文语言](http://jingyan.baidu.com/article/5553fa82cedaa265a2393420.html)

参考：

+ [Install (Ubuntu) - Fcitx](https://fcitx-im.org/wiki/Install_(Ubuntu))
+ [Ubuntu 14.04 安装小企鹅输入法 Fcitx](http://my.oschina.net/eechen/blog/224291)



