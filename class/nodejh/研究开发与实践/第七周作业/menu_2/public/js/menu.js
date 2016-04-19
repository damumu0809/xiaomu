//var nav = '<ul>' +
//  '<li class="current"><a href="./index.html">Home</a></li>'+
//  '<li><a href="./page_styling.html">Styles</a></li>'+
//  '<li>'+
//  '<a href="./trainers.html">Trainers <span class="arrow"></span></a>'+
//  '<section class="dropdown">'+
//  '<ul>'+
//  '<li><a href="./trainer.html">Joey Smith</a></li>'+
//  '<li>'+
//  '<a href="./trainer.html">Robert Galgoa <span class="arrow"></span></a>'+
//  '<section class="dropdown">'+
//  '<ul>'+
//  '<li><a href="./trainer.html">Joey Smith</a></li>'+
//  '<li><a href="./trainer.html">Robert Galgoa</a></li>'+
//  '<li><a href="./trainer.html">Franklin Jr.</a></li>'+
//  '</ul>'+
//  '</section>'+
//  '</li>'+
//  '<li><a href="./trainer.html">Franklin Jr.</a></li>'+
//  '<li><a href="./trainer.html">Sarah Hemmer</a></li>'+
//  '<li><a href="./trainer.html">George Norman</a></li>'+
//  '</ul>'+
//  '</section>'+
//  '</li>'+
//  '<li><a href="./calendar.html">Calendar</a></li>'+
//    '<li><a href="./news.html">News</a></li>'+
//    '<li><a href="./gallery.html">Gallery</a></li>'+
//    '<li><a href="./contact.php.html">Contact</a></li>'+
//    '<li class="phone">(800) 456-7890</li>' +
//  '</ul>';
//
//document.getElementById('nav').innerHTML = nav;


// 监听 "未登陆菜单" 按钮的点击事件
$('#not_login').on('click', function() {
  show_menu('not_login');
});


// 监听 "已登陆菜单" 按钮的点击事件
$('#login').on('click', function() {
  show_menu('login');
});


// 根据不同的类型获取菜单并显示
function show_menu(type) {
  var data = {
    type: type,
    a: 'dddd'
  };

  $.post('/menu', data, function(res) {
    console.log(res);
    if (res.code == 0) {
      var nav = '<ul>';
      res.menu.map(function(item) {
        nav += '<li><a href="#">' + item.name + '</a></li>';
      });
      nav += '</ul>';
      $('#nav').empty().html(nav);

    } else {
      alert('获取菜单失败!');
    }

  });
}