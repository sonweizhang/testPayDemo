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
<title>2.1 获取付款银行</title>
<script type="text/javascript">

</script>
</head>
<body>
	<div align="center">
		<!-- <form action="http://localhost:8080/pay/anonymousPayOrder.do" -->
		<!-- <form action="https://pay.yoyipay.com/pay/anonymousPayOrder.do" -->
		<form action="http://localhost/pay/getBanksForPay.do"
			method="post" target="_blank"  accept-charset="UTF-8" style="border-color: gray; padding-top: 40px;">
			<table border="1px">
				<tr>
					<td>remark</td>
					<td><input id="remark" name="remark" type="text" value="威尼熊" /></td>
				</tr>
			</table>
			<p>
				<input id="submitBtn" type="submit" />
			</p>
		</form>
	</div>
</body>
</html>