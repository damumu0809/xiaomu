var http = require('http'); // 内置的http模块提供了http服务器和客户端功能
var fs = require('fs'); // 内置的fs模块提供了文件读写的功能
var path = require('path');
var mime = require('mime'); // 附加的mine模块有根据文件扩展名得出MIME类型的功能
var cache = {}; // cache 是用来缓存文件内容的对象

var chatServer = require('./lib/chat_server');



// 当所请求的文件不存在时发送404错误
function send404 (response) {
  response.writeHead(404, {'Content-Type': 'text/plain'});
  response.write('Error 404: resource not found.');
  response.end();
}



// 提供文件数据服务
function sendFile(response, filePath, fileContents) {
  response.writeHead(200,
    {'Content-type': mime.lookup(path.basename(filePath))}
  );
  response.end(fileContents);
}


// 提供静态文件服务
function serverStatic(response, cache, absPath) {
  if (cache[absPath]) {
    sendFile(response, absPath, cache[absPath]);
  } else {
    fs.exists(absPath, function(exists) {
      if (exists) {
        fs.readFile(absPath, function (err, data) {
          if (err) {
            send404(response);
          } else {
            cache[absPath] = data;
            sendFile(response, absPath, data);
          }
        });
      } else {
        send404(response);
      }
    });
  }
}



// 创建HTTP服务器的逻辑
var server = http.createServer(function (requset, response) {
  var filePath = false;
  
  if (requset.url == '/') {
    filePath = 'public/index.html';
  } else {
    filePath = 'public' + requset.url;
  }
  
  var absPath  ='./' + filePath;
  serverStatic(response, cache, absPath);
});

// 启动HTTP服务
server.listen(3000, function () {
  console.log('server listening on port 3000');
});


chatServer.listen(server);
