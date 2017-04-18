<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>b2c支付测试</title>
</head>
<body>
	<h2 align="center">b2c支付测试</h2>
	<hr>
	<div align="center">
		<p>
			<a href="<%=request.getContextPath()%>/b2cpay/b2cPayOrder.jsp">2.1
				支付请求</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/b2cpay/b2cOrderQuery.jsp">2.3
				单笔订单查询</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/b2cpay/b2cRefundOrder.jsp">2.5
				退款接口</a>
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/b2cpay/b2cQueryRefundOrder.jsp">2.7
				退款订单查询</a>
		</p>
	</div>
	<hr>
</body>
</html>