### JavaScript 数组循环遍历之forEach

+ 2016.03.05


#### 1. JavaScript 数组循环遍历

最容易想到的就是 for 循环了，如下：

```
var array = ['data1', 'data2', 'data3'];
for (var i=0; i < data.length; i++) {
	
}
```

#### 2. forEach

Firefox 和Chrome 的Array 类型都有 `forEach` 的函数。使用如下：

```
var arrayAll = [];
arrayAll.push(1);
arrayAll.push(2);
arrayAll.push(3);
arrayAll.push(4);

// 匿名方式
arrayAll.forEach(function (e) {
	console.log(e);
});

// 非匿名方式
function foo(arg) {
	console.log(arg);
}

arrayAll.forEach(foo, arrayAll);
```

但是以上，代码在IE中却无法正常工作。

因为IE的Array 没有 `forEach` 这个方法。

```
alert(Array.prototype.forEach); 
//执行以上这句得到的是  "undefined"， 也就是说在IE 中 Array 没有 forEach 的方法。
```
#### 3. 让 IE 兼容 forEach

```
//Array.forEach implementation for IE support..  
//https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/forEach  
if (!Array.prototype.forEach) {  
    Array.prototype.forEach = function(callback, thisArg) {  
        var T, k;  
        if (this == null) {  
            throw new TypeError(" this is null or not defined");  
        }  
        var O = Object(this);  
        var len = O.length >>> 0; // Hack to convert O.length to a UInt32  
        if ({}.toString.call(callback) != "[object Function]") {  
            throw new TypeError(callback + " is not a function");  
        }  
        if (thisArg) {  
            T = thisArg;  
        }  
        k = 0;  
        while (k < len) {  
            var kValue;  
            if (k in O) {  
                kValue = O[k];  
                callback.call(T, kValue, k, O);  
            }  
            k++;  
        }  
    };  
}
```

详细介绍可以参照：
[https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/forEach](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/forEach)

#### 4. 跳出循环

Js 此种状况的forEach 不能使用continue, break;  可以使用如下两种方式：

+ if 控制语句
+ return 控制语句 (return true 或 return false)

其实 return  类似continue 的作用。

以下例子是取出数组中2的倍数和3的倍数的数：
```
if (!Array.prototype.forEach) {  
    Array.prototype.forEach = function(callback, thisArg) {  
        var T, k;  
        if (this == null) {  
            throw new TypeError(" this is null or not defined");  
        }  
        var O = Object(this);  
        var len = O.length >>> 0; // Hack to convert O.length to a UInt32  
        if ({}.toString.call(callback) != "[object Function]") {  
            throw new TypeError(callback + " is not a function");  
        }  
        if (thisArg) {  
            T = thisArg;  
        }  
        k = 0;  
        while (k < len) {  
            var kValue;  
            if (k in O) {  
                kValue = O[k];  
                callback.call(T, kValue, k, O);  
            }  
            k++;  
        }  
    };  
}  
  
var arrayAll = [];  
arrayAll.push(1);  
arrayAll.push(2);  
arrayAll.push(3);  
arrayAll.push(4);  
arrayAll.push(5);
arrayAll.push(6);  
arrayAll.push(7);  
 
  
var arraySpecial = [];  
  
arrayAll.forEach(function(e){  
    if(e%2==0)  
    {  
        arraySpecial.push(e);  
    }else if(e%3==0)  
    {  
        arraySpecial.push(e);  
    }  
}); 
  
```

使用return 达到以上效果：

```
arrayAll.forEach(function(e){  
    if(e%2==0)  
    { 
        arraySpecial.push(e);  
        return;  
    }  
    if(e%3==0)  
    {      
        arraySpecial.push(e);  
        return;  
    }  
})  
```

**至于如何写类似break 的效果，目前尚未找到比较好的办法。**



