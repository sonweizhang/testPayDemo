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
<title></title>
<script type="text/javascript">

function getSign(){
	$.ajax({  
        type:"post",//请求方式  
        url:"../sign",//发送请求地址  
        dataType:"json",  
        data:{//发送给数据库的数据  
        	"sign" : $("#sign").val(),
        	"orderAmt" : $("#orderAmt").val(),
        	"curType" : $("#curType").val(),
        	"bankId" : $("#bankId").val(),
        	"returnURL" : $("#returnURL").val(),
        	"notifyURL" : $("#notifyURL").val(),
        	"remark" : $("#remark").val(),
        	"cardType" : $("#cardType").val(),
        	"userId" : $("#userId").val(),
        	"goodsType" : $("#goodsType").val(),
        	"goodsName" : $("#goodsName").val()

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
		<form id="testPay" action="http://localhost/pay/payOrder.do"
			method="post" target="_blank"  accept-charset="UTF-8" style="border-color: gray; padding-top: 40px;">
			<table border="1px">
		 		<tr>
					<td>sign</td>
					<td><input id="sign" name="sign" type="text"
						value="" /></td>
				</tr> 
				<tr>
					<td>orderAmt</td>
					<td><input id="orderAmt" name="orderAmt" type="text"
						value="123.45" /></td>
				</tr>
				<tr>
					<td>curType</td>
					<td><input id="curType" name="curType" type="text" value="CNY" /></td>
				</tr>
				<tr>
					<td>bankId</td>
					<td><input id="bankId" name="bankId" type="text" value="888C" /></td>
				</tr>
				<tr>
					<td>returnURL</td>
					<td><input id="returnURL" name="returnURL" type="text"
						value="http://baidu.com" /></td>
				</tr>
				<tr>
					<td>notifyURL</td>
					<td><input id="notifyURL" name="notifyURL" type="text"
						value="http://baidu.com" /></td>
				</tr>
				<tr>
					<td>remark</td>
					<td><input id="remark" name="remark" type="text" value="testPay" /></td>
				</tr>
				<tr>
					<td>cardType</td>
					<td><input id="cardType" name="cardType" type="text" value="01" /></td>
				</tr>
				<tr>
					<td>userId</td>
					<td><input id="userId" name="userId" type="text"
						value="14" /></td>
				</tr>
				<tr>
					<td>goodsType</td>
					<td><input id="goodsType" name="goodsType" type="text"
						value="0" /></td>
				</tr>
				<tr>
					<td>goodsName</td>
					<td><input id="goodsName" name="goodsName" type="text" value="testPay" /></td>
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