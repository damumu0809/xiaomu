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

### 4. 删除重复的老师链接

老师名字可能有重复 ，所以有时候需要删除重复的老师。因为我们采取的抓取方式，是先将所有老师的姓名和链接抓取后，存入一个叫 `teacherUrlListsArray` 的数组里面，这个数组大概在 `raw.js` 的第 50 行。然后我们再循环 `teacherUrlListsArray` 里面的每一个链接，并抓取该链接里面的内容。

所以，如果要删除重复的老师，只需要删除 `teacherUrlListsArray` 数组里面的重复元素即可。

下面这个函数，主要是用来删除重复元素的：

```
/**
* 删除所有老师数组中的重复元素
* teacherUrlListsArray 数组的内容是对象，大概如下：
*  teacherUrlListsArray ＝ [
*  {name: "教师姓名", href: "教师链接"}, 
*  {name: "教师姓名", href: "教师链接"}, 
*  {name: "教师姓名", href: "教师链接"}, 
*  ... 
*  ];
*/
function unique(array){
  var r = []; // 定义一个新的数组，用来存放不重复的数据
  // 遍历数组，如果某个元素只在数组里出现一次，则将其加入到 r 这个数组
  for(var i = 0, l = array.length; i < l; i++) {
    for(var j = i + 1; j < l; j++)
      if (array[i].href === array[j].href) j = ++i;
    r.push(array[i]);
  }
  return r;
}
```

将该函数放在 `raw.js` 的末尾，并在第 50 行左右对 `teacherUrlListsArray` 调用该函数即可。
调用后，第 50 行左右的几行代码大概如下：

```
console.log('所有教师列表:');
teacherUrlListsArray = unique(teacherUrlListsArray);
console.log(teacherUrlListsArray);
```


