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
<title>2.2 支付请求</title>
<script type="text/javascript">
function getTranData(){
	var merchantId = $("#merchantId").val();
	var orderNo = $("#orderNo").val();
	var orderAmt = $("#orderAmt").val();
	var curType = $("#curType").val();
	var remark = $("#remark").val();
	var tranSerialNo = $("#tranSerialNo").val();
	var tranStat = $("#tranStat").val();
	var tranTime = $("#tranTime").val();
	
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" ?><B2CReq>" +
	"<merchantId>"+merchantId+"</merchantId><orderNo>"+orderNo+"</orderNo><orderAmt>"+orderAmt+"</orderAmt>" + 
	"<curType>"+curType+"</curType><remark>"+remark+"</remark><tranSerialNo>"+tranSerialNo+"</tranSerialNo>" +
	"<tranStat>"+tranStat+"</tranStat><tranTime>"+tranTime+"</tranTime>" +
	"</B2CReq>";
	$("#sourceData").val(result);
}

function getEncrypt(){
	var sourceData = encodeURI($("#sourceData").val(),"UTF-8");
	var signKey = $("#signKey").val();
	var encryptType = $("#encryptType").val();
	
	$.ajax({  
        type:"post",//请求方式  
        url:"../EncryptDemo",//发送请求地址  
        dataType:"json",  
        data:{//发送给数据库的数据  
        	"sourceData" : sourceData,
        	"signKey" : signKey,
        	"encryptType" : encryptType
        },  
        //请求成功后的回调函数  
        success:function(data){  
            var objs=eval(data); //解析json对象  
            var tranData = objs["tranData"];
            var signMsg = objs["signMsg"];
            
            $("#tranDataShow").val(tranData);
            $("#tranData").val(tranData);
            $("#signData").val(signMsg);
        }
	});
}
</script>
</head>
<body>
	<div align="center">
		<!-- <form action="http://localhost:8080/pay/anonymousPayOrder.do" -->
		<!-- <form action="https://pay.yoyipay.com/pay/anonymousPayOrder.do" -->
		<form action="http://localhost/pay/returnUrl.do"
			method="post" target="_blank" style="border-color: gray; padding-top: 40px;">
			<table>
				<tr>
					<td>interfaceName</td>
					<td><input id="interfaceName" name="interfaceName" type="text"
						value="PayOrderNotify" /></td>
				</tr>
				<tr>
					<td>version</td>
					<td><input id="version" name="version" type="text"
						value="B2C1.0" /></td>
				</tr>
				<tr>
					<td>tranData</td>
					<td><textarea id="tranDataShow" rows="5" cols="100"></textarea></td>
				</tr>
				<tr>
					<td>signData</td>
					<td><textarea id="signData" name="signData" rows="5" cols="100"></textarea></td>
				</tr>
			</table>
			<input type="hidden" id="tranData" name="tranData" value="" />
			<p>
				<input id="submitBtn" type="submit" />
			</p>
		</form>
	</div>
	<div align="center" style="border: 1px solid gray; height: 620px;">
		<div align="right"
			style="float: left; width: 600px; height: 500px; padding-right: 20px; padding-top: 20px;">
			<table border="1px">
				<tr>
					<td>merchantId</td>
					<td><input id="merchantId" name="merchantId" type="text"
						value="M100002065" /></td>
				</tr>
				<tr>
					<td>orderNo</td>
					<%
					Date date = new Date(); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String dateStr = "test"+sdf.format(date)+"001";
					String dateTime = sdf.format(date);

					%>
					<td><input id="orderNo" name="orderNo" type="text"
						value="<%=dateStr %>" /></td>
				</tr>
				<tr>
					<td>tranSerialNo</td>
					<td><input id="tranSerialNo" name="tranSerialNo" type="text"
						value="<%=dateStr %>" /></td>
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
					<td>tranTime</td>
					<td><input id="tranTime" name="tranTime" type="text" value="<%=dateTime %>" /></td>
				</tr>
				<tr>
					<td>tranStat</td>
					<td><input id="tranStat" name="tranStat" type="text"
						value="" /></td>
				</tr>
				<tr>
					<td>remark</td>
					<td><input id="remark" name="remark" type="text"
						value="remark" /></td>
				</tr>
			</table>
		</div>
		<div align="center"
			style="float: left; width: 250px; height: 500px; padding-top: 120px;">
			<button onclick="getTranData();" style="width: 200px;">
				<p>1.组装tranData原文</p>
			</button>
			<button onclick="getEncrypt();" style="width: 200px;">
				<p>2.生成base64密文和签名</p>
			</button>
			<p>
			请选择签名方式：
				<select title="签名方式" id="encryptType" name="encryptType">
					<option value="ITRUS" onclick="$('#signShow').hide();" select="select">ITRUS</option>
					<option value="MD5" onclick="$('#signShow').show();">MD5</option>
				</select>
			</p>
			<p id="signShow">
				签名密钥<input id="signKey" name="signKey" type="text" value="123123"
					style="width: 200px;" />
			</p>
		</div>
		<div align="center"
			style="float: left; height: 500px; padding-left: 20px; padding-top: 20px;">
			<textarea rows="20" cols="50" id="sourceData" name="sourceData">请点击“1.组装tranData原文”按钮生成原文</textarea>
		</div>
	</div>
</body>
</html>