module.exports = function(app) {
  app.get('/', function (req, res) {
    res.render('index', { title: 'Express' });
  });


  app.post('/menu', function (req, res) {

    var type = req.body.type;

    console.log(type);
    req.getConnection(function(err, connection) {

      if (err) {
        console.log(err);
        res.json({code: 1, msg: err});
        return false;
      }

      var select = '';
      switch (type) {
        case 'not_login':
          select = 'SELECT `name` FROM `not_login_menu`';
          break;
        case 'login':
          select = 'SELECT `name` FROM `login_menu`';
          break;
        default:
          return res.json({code: 2, msg: 'wrong type'});
      }

      connection.query(select, function (err, raws) {

        if (err) {
          res.json({code: 3, msg: err});
          return false;
        }

        console.log('get menu: ', raws);
        res.json({
          code: 0,
          menu: raws
        });
      });

    });
  });

};
