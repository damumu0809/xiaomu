var socketio = require('socket.io');
var io;
var guestNumber = 1;
var nickNames = {};
var namesUsed = [];
var currentRoom = {};

exports.listen = function(server) {
  io = socketio.listen(server);
  //io.set('log level', 1);

  io.sockets.on('connetcion', function(socket) {
    guestNumber = assignGuestName(socket, guestNumber, nickNames, namesUsed);
    // 在用户连接上时,把他放入聊天室 Lobby 里面
    joinRoom(socket, 'Lobby');
    // 处理用户的消息
    handleMessageBroadcasting(socket, nickNames);
    // 处理用户的更名,以及聊天室的创建和变更
    handleNameChangeAttemps(socket, nickNames, namesUsed);
    handleRoomJoining(socket);
    // 用户发出请求时,向其提供已经被占用的聊天室列表
    socket.on('rooms', function() {
      socket.emit('rooms', io.sockets.manager.rooms);
    });
    // 定义用户断开连接后的清除逻辑
    handleClientDisconnection(socket, nickNames, namesUsed);
  });
};


// 分配用户昵称
function assignGuestName(socket, guestNumber, nickNames, namesUsed) {
  var name = 'Guest' + guestNumber;
  nickNames[socket.id] = name;
  socket.emit('nameResult', {
    success: true,
    name: name
  });
  namesUsed.push(name);
  return guestNumber + 1;
}

// 进入聊天室
function joinRoom(socket, room) {
  socket.join(room);
  currentRoom[socket.id] = room;
  socket.emit('joinResult', {
    room: room
  });
  socket.broadcast.to(room).emit('message', {
    text: nickNames[socket.id] + ' has joined ' + room + ' .'
  });

  var usersInRoom = io.sockets.clients(room);
  if (usersInRoom.length > 1) {
    var usersInRoomsSummary = 'Users currently in ' + room + ' : ';
    for (var index in usersInRoom) {
      var userSocketId = usersInRoom[index].id;
      if (userSocketId != socket.id) {
        if (index > 0) {
          usersInRoomsSummary += ', ';
        }
        usersInRoomsSummary += nickNames[userSocketId];
      }
    }
    usersInRoomsSummary += ' .';
    socket.emit('message', {
      text: usersInRoomsSummary
    });
  }
}


// 更改名称处理逻辑
function handleNameChangeAttemps(socket, nickNames, namesUsed) {
  socket.on('nameAttempt', function (name) {
    if (name.indexOf('Guest') == 0) {
      socket.emit('nameResult', {
        success: false,
        message: 'Names cannot begin with "Guest".'
      });
    } else {
      if (namesUsed.indexOf(name) == -1) {
        var previousName = nickNames[socket.id];
        var previousNameIndex = namesUsed.indexOf(previousName);
        namesUsed.push(name);
        nickNames[socket.id] = name;
        delete namesUsed[previousNameIndex];
        socket.emit('nameResult', {
          success: true,
          name: name
        });
        socket.boradcast.to(currentRoom[socket.id]).emit('message', {
          text: previousName + ' is now knows as ' + name + ' .'
        });

      } else {
        socket.emit('nameResult', {
          success: false,
          message: 'That name is already in use.'
        });
      }
    }
  });
}


// 发送聊天消息
function handleMessageBroadcasting(socket) {
  socket.on('message', function (message) {
    socket.broadcast.to(message.room).emit('message', {
      text: nickNames[socket.io] + ' : ' + message.text
    });
  });
}


// 创建房间
function handleRoomJoining(socket) {
  socket.on('join', function(room) {
    socket.leave(currentRoom[socket.id]);
    joinRoom(socket, room.newRoom);
  });
}


// 用户断开连接

function handleClientDisconnection(socket) {
  socket.on('disconnect', function() {
    var nameIndex = namesUsed.indexOf(nickNames[socket.id]);
    delete namesUsed[nameIndex];
    delete nickNames[socket.id];
  });
}