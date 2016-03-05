## JavaScript Array.prototype.map()详解

+ 2016.03.05

> map 方法会给原数组中的每个元素都按顺序调用一次 callback 函数。callback 每次执行后的返回值组合起来形成一个新数组。 callback 函数只会在有值的索引上被调用；那些从来没被赋过值或者使用 delete 删除的索引则不会被调用。

### 1. for 循环遍历和 map 遍历实例

在我们日常开发中，操作和转换数组是一件很常见的操作，下面我们来看一个实例：

```
var desColors = [];
var srcColors = [
	{r: 255, g: 255, b: 255}, // white
	{r: 128, g:128, b:128}, // gray
	{r: 0, g: 0, b: 0} // black
];

for (var i=0, length = srcColors.length; i<length; i++) {
	var color = srcColors[i];
	var format = function (color) {
		return Math.round(color/2);
	};
	
	desColors.push({
		r: format(color.r),
		g: format(color.g),
		b: format(color.b)
	});
}
console.log(desColors);

// Outputs:
// [
//    {r: 128, g: 128, b: 128 },
//    {r: 64,  g: 64,  b: 64  },
//    {r: 0,   g: 0,   b: 0   }
// ];
```

从上例可以看出，所有的操作重复率都比较高，如何来优化呢，幸运的是Ecmascript 5给我们提供了一个map方法，我们可以利用它来优化上例：

```
var srcColors = [
	{r: 255, g: 255, b: 255}, // white
	{r: 128, g:128, b:128}, // gray
	{r: 0, g: 0, b: 0} // black
];

var desColors = srcColors.map(function (val) {
	var format = function(color) {
		return Math.round(color/2);
	};
	return ({
		r: format(val.r),
		g: format(val.g),
		b: format(val.b)
	});
});
console.log(desColors);

// Outputs:
// [
//    {r: 128, g: 128, b: 128 },
//    {r: 64,  g: 64,  b: 64  },
//    {r: 0,   g: 0,   b: 0   }
// ];

```

从上例看以看出，我们使用map替换掉了for循环部分，从而只需要关心每个元素自身的实现逻辑。

### 2. map基本定义

> array.map(callback[, thisArg]);

map 方法会给原数组中的每个元素都按顺序调用一次 callback 函数。callback 每次执行后的返回值组合起来形成一个新数组。 callback 函数只会在有值的索引上被调用；那些从来没被赋过值或者使用 delete 删除的索引则不会被调用。

callback 函数会被自动传入三个参数：数组元素，元素索引，原数组本身。

如果 thisArg 参数有值，则每次 callback 函数被调用的时候，this 都会指向 thisArg 参数上的这个对象。如果省略了 thisArg 参数,或者赋值为 null 或 undefined，则 this 指向全局对象 。

map 不修改调用它的原数组本身（当然可以在 callback 执行时改变原数组）。

当一个数组运行 map 方法时，数组的长度在调用第一次 callback 方法之前就已经确定。在 map 方法整个运行过程中，不管 callback 函数中的操作给原数组是添加还是删除了元素。map 方法都不会知道，如果数组元素增加，则新增加的元素不会被 map 遍历到，如果数组元素减少，则 map 方法还会认为原数组的长度没变，从而导致数组访问越界。如果数组中的元素被改变或删除，则他们被传入 callback 的值是 map 方法遍历到他们那一刻时的值。

### 3. map 详解

```
//实例一：字符串上调用map方法
var result = Array.prototype.map.call("Hello World", function (x, index, arr) {
	console.log(arr);
	// 输出11 此下面的字符串对象：
	// String {0: "H", 1: "e", 2: "l", 3: "l", 4: "o", 5: " ", 6: "w", 7: "o", 8: "r", 9: "l", 10: "d", length: 11}	return x.charCodeAt(0);
});

console.log(result);
//Outputs: [72, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100] 
```

上例演示了在一个String上使用map方法获取字符串中每个字符所对应的 Unicode 编码组成的数组。请注意看打印的console.log(arr)打印的结果。

```
//实例二：下面的操作结果是什么？
var result = ["1", "2", "3"].map(parseInt);
//Outputs: [1, NaN, NaN] 
console.log(result);
```

也许你会有疑问，为什么不是 `[1,2,3]` 呢？我们知道 `parseInt()` 方法可接收两个参数，第一个参数为需要转换的值，第二个参数为进制数，不了解的可以戳这里。当我们使用map方法的时候，callback函数接收三个参数，而 `parseInt()` 最多只能接收两个参数，以至于第三个参数被直接舍弃，与此同时，`parseInt()` 把传过来的索引值当成进制数来使用.从而返回了 `NaN`。看下面的输出结果：

```
console.log(parseInt("1", 0)); // 1
console.log(parseInt("1", undefined)); // 1
console.log("2", 1); // NaN
console.log("3", 2); // NaN
```

后面两个很容易理解，但是前两个为什么返回1呢？为了解释这个问题，我们看看官方的描述：


>If radix is undefined or 0 (or absent), JavaScript assumes the following:
>
>+ a) If the input string begins with “0x” or “0X”, radix is 16 (hexadecimal) and the remainder of the string is parsed.
> + b) If the input string begins with “0″, radix is eight (octal) or 10 (decimal). Exactly which radix is chosen is implementation-dependent. ECMAScript 5 specifies that 10 (decimal) is used, but not all browsers support this yet. For this reason always specify a radix when using parseInt.
> + c) If the input string begins with any other value, the radix is 10 (decimal).

在第三点中当string为其他值时，进制默认为10。

那么我们如何修改才能使上例正常输出呢？看下例：

```
var result = ["1", "2", "3"].map(function(val) {
    return parseInt(val, 10);
});
console.log(result);
//Outputs: [1, 2, 3] 
```

### 4. map方法的兼容性

map方法在IE8及以下浏览器不支持，要想兼容老版本的浏览器，可参考：

[JavaScript数组遍历map()的原型扩展](http://www.nowamagic.net/librarys/veda/detail/783)