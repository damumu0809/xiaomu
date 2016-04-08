var eventproxy = require('eventproxy');
var superagent = require('superagent-charset');
var cheerio = require('cheerio');
var url = require('url');
var eventproxy = require('eventproxy');
var fs = require('fs');
var ep = new eventproxy();

// 教师链接页面
var teacherListPageUrls = [
  'http://sky.ccnu.edu.cn/szll/js.htm',
  'http://sky.ccnu.edu.cn/szll/fjs.htm'
];
// 教师链接和简历间的分隔符
var splitBetweenUrlAndResume = 'TEACHER_RESUME_URL';
// 教师之间的分隔符
var splitBetweenTeachers = '_THIS_IS_END_OF_ONE_DATA_';
// 教师链接DOM节点
var teacherUrlElement = '#text td[width="72"] a';
// 教师简历DOM节点
var teacherResumeElement = '#vsb_content';


ep.after('get_teacher_list', teacherListPageUrls.length, function(teacherLists) {
  //console.log(teacherLists);
  //console.log('================');
  var teacherUrlListsArray = [];

  teacherLists.map(function(teacherListPair) {
    var teacherListPageUrl = teacherListPair[0];
    var teacherListPageHtml = teacherListPair[1];
    var $teacherListPage = cheerio.load(teacherListPageHtml);

    $teacherListPage(teacherUrlElement).each(function(id, element) {
      var name = $teacherListPage(element).text().replace(/[\n|\r|\t|\s]*/g, '');
      var href = url.resolve(teacherListPageUrl, $teacherListPage(element).attr('href'));
      if (name && href) {
        teacherUrlListsArray.push({
          name: name,
          href: href
        }); 
      }
    });
  });
  console.log('所有教师列表:');
  console.log(teacherUrlListsArray);
  
  ep.after('get_teacher_resume', teacherUrlListsArray.length, function (teacherResumes) {
    teacherResumes.map(function (teacherResumePair) {
      var teacherResumeUrl = teacherResumePair[0];
      var teacherResumeHtml = teacherResumePair[1];
      var $teacherResume = cheerio.load(teacherResumeHtml);
      // 教师简历
      var content = teacherResumeUrl;
      content += splitBetweenUrlAndResume; // 链接和简历之间的分隔符
      content += $teacherResume(teacherResumeElement).text().replace(/[\n|\s|\t|\r]+/g, ' '); // 简历内容
      content += '\n\n' + splitBetweenTeachers + '\n\n'; // 教师和教师之间的分隔符

      // 将简历存入文件
      fs.open('raw.txt', 'a', function (err_f, fd) {
        if (err_f) {
          console.log('====================================');
          console.log('error: open file error');
          console.log(content);
          console.log(err_f);
          console.log('====================================');
          console.log('\n');
        } else {
          fs.write(fd, content, function (err_fw, res_fw) {
            if (err_fw) {
              console.log('====================================');
              console.log('error: write file error');
              console.log(teacherResumeUrl);
              console.log(content);
              console.log(err_fw);
              console.log('====================================');
              console.log('\n');
            } else {
              console.log('write file success');
              console.log(teacherResumeUrl);
              console.log(res_fw);
              console.log('\n');
            }
            fs.close(fd);
          });
        }
      });

    });
  });

  // 获取所有教师简历
  teacherUrlListsArray.forEach(function (teacherUrlObject) {
    var teacherResumeUrl = teacherUrlObject.href;
    superagent.get(teacherResumeUrl)
      .end(function (err, res) {
        if (err) {
          console.log('================================');
          console.log('获取教师简历出错');
          console.log(teacherUrlObject);
          console.log(err);
          console.log('================================');
        } else {
          console.log('fetch: ' + teacherResumeUrl + ' successful!');
        }
        ep.emit('get_teacher_resume', [teacherResumeUrl, res.text]);
      });
  });
});


// 获取所有教师链接
teacherListPageUrls.forEach(function(teacherListPageUrl) {
  superagent.get(teacherListPageUrl)
    .end(function(err, res) {
      if (err) {
        console.log('================================');
        console.log('获取教师链接页面出错');
        console.log(teacherListPageUrl);
        console.log(err);
        console.log('================================');
      } else {
        console.log('fetch: ' + teacherListPageUrl + ' successful');
      }
      ep.emit('get_teacher_list', [teacherListPageUrl, res.text]);
    });
});