## 爬取说明

### 0. 安装 Node.js v4

参考: `/xiaomu/node.js/00.安装nodejs/hwo-to-install-nodejs-v4_x-on-ubuntu.md`

### 1. 复制 `raw.js` 到对应的 `学校/学院/raw.js` 

```
cd 学校
cd 学院
CP ../../raw.js .
```

### 2. 修改参数

+ 第9行 teacherListPageUrls 改为对应的教师姓名页面的链接数组.不清楚的话,可以打开示例程序中对应的链接查看
+ 第23行 teacherUrlElement 教师链接DOM节点.不清楚的话,可以找到对应节点查看
+ 第25行 teacherResumeElement 教师简历DOM节点.不清楚的话,可以找到对应节点查看
+ 如果出现**乱码**，则将第 100 行和第 120 行的注释取消即可

### 3. 运行 

```
 nodejs raw.js | tee log.txt
```

一切正常的话,终端就会输出日志信息,同时将日志信息存储到 `log.txt`.爬取结束就会生成一个 `raw.txt`,里面就是爬取结果.

