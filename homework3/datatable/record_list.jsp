<%@page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<meta charset="utf-8" />
		<title>管理系统</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<div style="margin:50px;border:2px solid red;">
			<table class="table table-striped table-bordered table-hover datatable" id="record_list">
				<thead>
					<tr>
						<th class="table-checkbox"><input type="checkbox" class="group-checkable" data-set="#record_list .checkboxes" /></th>
						<th>设备ID</th>
						<th>设备名称</th>
						<th>创建人</th>
						<th>创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
	<!-- END BODY -->
</html>
<link rel="stylesheet" type="text/css" href="dataTables.bootstrap.css" />
<link rel="stylesheet" type="text/css" href="bootstrap.min.css"/>

<script type="text/javascript" src="jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="jquery.uniform.min.js"></script>
<script type="text/javascript" src="jquery.dataTables.min.js"></script>

<script src="record_list.js" type="text/javascript"></script>
