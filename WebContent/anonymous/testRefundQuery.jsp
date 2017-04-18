<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="base.ProcessMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/testPayDemo/js/jquery-1.4.4.min.js"></script>
<title>2.8 退款订单查询</title>
<script type="text/javascript">

</script>
</head>
<body>
	<div align="center">
		<!-- <form action="http://localhost:8080/pay_query/QueryRefundOrder.do" -->
		<!-- <form action="http://60.12.221.84:28080/pay_query/QueryRefundOrder.do" -->
		<form action="http://localhost/refundQuery/queryRefundOrder.do"
			method="post" target="_blank"
			style="border-color: gray; padding-top: 40px;">
			<table border="1px">
				<tr>
					<td>退款流水号</td>
										<%
					Date date = new Date(); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddss");
					String dateStr = "TK"+sdf.format(date);
					%>
					<td><input id="tranSerialNo" name="tranSerialNo" type="text"
						value="<%=dateStr %>" /></td>
				</tr>
			</table>
			<p>
				<input id="submitBtn" type="submit" />
			</p>
		</form>
	</div>
</body>
</html>