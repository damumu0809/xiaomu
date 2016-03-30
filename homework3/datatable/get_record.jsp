<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.text.*,org.json.JSONObject,java.util.ArrayList,java.io.PrintWriter"
	import="java.util.HashMap,java.util.List,java.sql.*,java.util.Map,java.io.IOException"%>
<%
	String action=request.getParameter("action");
	String deviceId=request.getParameter("device_id");
	System.out.println("获得的参数是：action="+action+",device_id="+deviceId);

	//开始查询数据库
	//注意：如果遇到问题，Tomcat的日志在C:\Tomcat\logs\stdout.log，可以查看
	List jsonList = new ArrayList();
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException classnotfoundexception) {
		classnotfoundexception.printStackTrace();
	}
	try {
		//注意：数据表video_file确保在test数据库下面，如果没有就导入进去，或者放在自己建的数据库，下面的test相应要修改
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/copy?user=root&password=111111&useUnicode=true&characterEncoding=UTF-8");
		Statement statement = conn.createStatement();
		System.out.println("连接数据库Ok！！！");
		//构造sql语句，根据传递过来的查询条件参数，目前是deviceId和gpsTime
		String sql="select * from video_file order by register_time";
		//也可以根据device_id查询
		//String sql="select * from video_file where device_id like '%"+deviceId+"%' order by register_time";
		System.out.println("构造出来的sql语句是："+sql);
		ResultSet rs = statement.executeQuery(sql);
		while (rs.next()) {
			List list = new ArrayList();
			list.add(rs.getString("id"));
			list.add(rs.getString("device_id"));
			list.add(rs.getString("device_name"));
			list.add(rs.getString("register"));
			list.add(rs.getString("register_time"));
			jsonList.add(list);
		}
		statement.close();
		conn.close();
		System.out.println("数据库关闭了！！！");
	} catch (SQLException sqlexception) {
		sqlexception.printStackTrace();
	}
	//////////数据库查询完毕，得到了json数组jsonList//////////
	//jsonList.clear();
	//下面开始构建返回的json
	JSONObject jsonObj=new JSONObject();
	jsonObj.put("aaData",jsonList);
	jsonObj.put("action",action);
	jsonObj.put("result_msg","ok");	//如果发生错误就设置成"error"等
	jsonObj.put("result_code",0);	//返回0表示正常，不等于0就表示有错误产生，错误代码
	System.out.println("最后构造得到的json是："+jsonObj.toString());
	response.setContentType("text/html; charset=UTF-8");
	try {
		response.getWriter().print(jsonObj);
		response.getWriter().flush();
		response.getWriter().close();
	} catch (IOException e) {
		e.printStackTrace();
	}
	System.out.println("返回结果给调用页面了。");
%>
