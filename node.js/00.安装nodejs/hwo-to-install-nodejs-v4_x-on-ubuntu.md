# 在 Ubuntu 中安装 Node.js v4

如果直接使用 `sudo apt-get install nodejs` 安装的话，安装的 Nodejs 的版本是 v0.10，可以通过 `nodejs -v` 查看。

而目前 Node.js 的稳定版本已经是 v4 了，开发版是 v5。v0.1 和 v4 有的区别可参考：[《请用 Node.js 4.0.0》](https://cnodejs.org/topic/55efcc524b70f72113ff4f3b) 


###  安装 Node.js v4

由于之前安装了 v0.1，所以现在先要卸载它：

```
sudo apt-get remove nodejs
```

然后使用下面两行命令进行安装：

```
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
```

然后就可以使用 `nodejs -v` 再看看当前的 Node.js 版本，看看是不是 `v4.4.1`，然后使用 `npm -v`看看是不是 `v2.14.20`。

参考：

+ [NodeSource Node.js and io.js Binary Distributions](https://github.com/nodesource/distributions)

