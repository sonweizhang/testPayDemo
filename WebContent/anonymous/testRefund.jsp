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
<title>2.6 退款接口</title>
<script type="text/javascript">
</script>
</head>
<body>
	<div align="center">
		<!-- <form action="http://localhost:8080/pay/refundOrder.do" -->
		<!-- <form action="http://60.12.221.84:28080/pay/refundOrder.do" -->
		<form action="http://localhost/refund/refundOrder.do"
			method="post" target="_blank"
			style="border-color: gray; padding-top: 40px;">
			<table border="1px">
				<tr>
					<td>订单编号</td>
					<%
					Date date = new Date(); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String dateStr0 = "TK"+sdf.format(date)+"001";
					String dateStr1 = "test"+sdf.format(date)+"001";

					%>
					<td><input id="orderNo" name="orderNo" type="text"
						value="<%=dateStr1 %>" /></td>
				</tr>
				<tr>
					<td>退款金额</td>
					<td><input id="refundAmt" name="refundAmt" type="text"
						value="123.45" /></td>
				</tr>
				<tr>
					<td>商户退款订单流水号</td>
					<td><input id="merRefundOrderFlowNo" name="merRefundOrderFlowNo" type="text"
						value="<%=dateStr0 %>" /></td>
				</tr>
			</table>
			<p>
				<input id="submitBtn" type="submit" />
			</p>
		</form>
	</div>
</body>
</html>