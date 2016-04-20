// 这是一个已经写好的 routes/index.js
// 如果你在写的过程中遇到问题解决不了，可以参考这个


module.exports = function(app) {

 	app.get('/', function (req, res) {
    		res.render('index', { title: 'Express' });
  	});

 	// 监听 /menu 路由
	app.post('/menu', function (req, res) {

		// 获取前台传递来的 type 的值
    		var type = req.body.type;
    		console.log(type);

    		// 创建数据库连接
   		req.getConnection(function(err, connection) {

   			// 连接数据库失败，输出json，并使用 return false 结束执行程序
	      		if (err) {
	        		console.log(err);
	        		res.json({code: 1, msg: err});
	        		return false;
	     		}

	     		// 连接数据库成功，根据不同的 type 构造不同的 select 语句
	      		var select = '';
	      		switch (type) {
	        		case '1':
	          			select = 'SELECT * FROM menu WHERE type="学生"';
	          			break;
	        		case '2':
	         			select = 'SELECT * FROM menu WHERE type="老师"';
	          			break;
	        		default:
	        			// 如果是未知的 type 类型，则返回json，告诉用户类型错误，并使用 return false 结束执行程序
	        			res.json({code: 2, msg: 'wrong type'});
	          			return  false;
	      		}

	      		// 执行 select 语句
	      		connection.query(select, function (err, raws) {

	      			// 如果执行sql语句（select）失败则返回json，并使用 return false 结束执行程序
		        	if (err) {
		          		res.json({code: 3, msg: err});
		          		return false;
		        	}


		        	console.log('get menu: ', raws);  
		        	// 后端的所有 console.log() 都只会输出到终端，不会返回给用户。
		        	//res.json 才是返回给浏览器的
			        
		        	// 查询成功，返回json，并返回查询结果 raws
		        	//可以在终端看到 raws 的具体格式及内容
		        	// 同时，这里返回的json，在前端不需要使用 $.parseJSON() 来转换格式
			        res.json({
			          	code: 0,
			          	menu: raws
			        });
		     	 });
	   	});
 	});	

};
