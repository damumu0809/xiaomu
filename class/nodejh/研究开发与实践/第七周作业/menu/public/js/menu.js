var nav = '<ul>' +
  '<li class="current"><a href="./index.html">Home</a></li>'+
  '<li><a href="./page_styling.html">Styles</a></li>'+
  '<li>'+
  '<a href="./trainers.html">Trainers <span class="arrow"></span></a>'+
  '<section class="dropdown">'+
  '<ul>'+
  '<li><a href="./trainer.html">Joey Smith</a></li>'+
  '<li>'+
  '<a href="./trainer.html">Robert Galgoa <span class="arrow"></span></a>'+
  '<section class="dropdown">'+
  '<ul>'+
  '<li><a href="./trainer.html">Joey Smith</a></li>'+
  '<li><a href="./trainer.html">Robert Galgoa</a></li>'+
  '<li><a href="./trainer.html">Franklin Jr.</a></li>'+
  '</ul>'+
  '</section>'+
  '</li>'+
  '<li><a href="./trainer.html">Franklin Jr.</a></li>'+
  '<li><a href="./trainer.html">Sarah Hemmer</a></li>'+
  '<li><a href="./trainer.html">George Norman</a></li>'+
  '</ul>'+
  '</section>'+
  '</li>'+
  '<li><a href="./calendar.html">Calendar</a></li>'+
    '<li><a href="./news.html">News</a></li>'+
    '<li><a href="./gallery.html">Gallery</a></li>'+
    '<li><a href="./contact.php.html">Contact</a></li>'+
    '<li class="phone">(800) 456-7890</li>' +
  '</ul>';

document.getElementById('nav').innerHTML = nav;