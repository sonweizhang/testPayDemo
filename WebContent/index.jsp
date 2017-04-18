<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请选择测试Demo</title>
</head>
<body>
	<h2 align="center">请选择测试Demo</h2>
	<hr>
	<div align="center">
		<p>
			<a
				href="<%=request.getContextPath()%>/anonymous/anonymousTaskList.jsp">匿名支付</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/b2cpay/b2cTaskList.jsp">b2c支付</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/plhk/plhkTaskList.jsp">批量汇款</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/jianguan/jianguanTaskList.jsp">资金结算系统</a>
		</p>
	</div>
	<hr>
</body>
</html>