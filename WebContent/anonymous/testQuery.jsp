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
<title>2.1 单笔订单查询</title>
<script type="text/javascript">
function getSign(){
	$.ajax({  
        type:"post",//请求方式  
        url:"../sign",//发送请求地址  
        dataType:"json",  
        data:{//发送给数据库的数据  
        	"sign" : $("#sign").val(),
        	"orderNo" : $("#orderNo").val()

        },  
        //请求成功后的回调函数  
        success:function(data){  
            var objs=eval(data); //解析json对象  
            var signMsg = objs["sign"];
            $("#sign").val(signMsg);
        }
	});
}
</script>
</head>
<body>
	<div align="center">
		<!-- <form action="http://localhost:8080/pay/anonymousPayOrder.do" -->
		<!-- <form action="https://pay.yoyipay.com/pay/anonymousPayOrder.do" -->
		<form action="http://localhost/query/queryOrder.do"
			method="post" target="_blank"  accept-charset="UTF-8" style="border-color: gray; padding-top: 40px;">
			<table border="1px">
				<tr>
					<td>sign</td>
					<td><input id="sign" name="sign" type="text"
						value="" /></td>
				</tr>
				<tr>
					<td>订单编号</td>
					<%
					Date date = new Date(); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String dateStr = "test"+sdf.format(date)+"001";
					%>
					<td><input id="orderNo" name="orderNo" type="text"
						value="<%=dateStr %>" /></td>
				</tr>
			</table>
			<p>
				<input id="submitBtn" type="submit" />
			</p>
		</form>
	</div>
		<div align="center" style="height: 500px; padding-left: 20px; padding-top: 20px;">
			<button onclick="getSign()" style="width: 200px;">
				<p>生成密文</p>
			</button>	
	</div>
</body>
</html>