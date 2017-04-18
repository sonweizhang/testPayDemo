<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>匿名支付测试</title>
</head>
<body>
	<h2 align="center">匿名支付测试</h2>
	<hr>
	<div align="center">
		<p>
			<a
				href="<%=request.getContextPath()%>/anonymous/anonymousGetBanksForPay.jsp">2.1
				获取付款银行</a>
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/anonymous/anonymousPayOrder.jsp">2.2
				支付请求</a> 
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/anonymous/anonymousOrderQuery.jsp">2.4
				单笔订单查询</a>
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/anonymous/anonymousRefundOrder.jsp">2.6
				退款接口</a>
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/anonymous/anonymousQueryRefundOrder.jsp">2.8
				退款订单查询</a>
		</p>
	</div>
	<hr>
</body>
</html>