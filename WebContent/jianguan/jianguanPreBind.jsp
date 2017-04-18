<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="base.ProcessMessage"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript" src="/testPayDemo/js/jquery-1.4.4.min.js"></script>
<title>2.2 预签约</title>
<script type="text/javascript">
function getTranData(){
	var transAccNo = $("#transAccNo").val();
	var merchantId = $("#merchantId2").val();
	var name = $("#name").val();
	var certType = $("#certType").val();
	var certNo = $("#certNo").val();
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" ?><Req>" +
	"<transAccNo>"+transAccNo+"</transAccNo><merchantId>"+merchantId+"</merchantId>" + 
	"<cstInfo><name>"+name+"</name><certType>"+certType+"</certType><certNo>"+certNo+"</certNo></cstInfo>" +
	"</Req>";
	$("#sourceData").val(result);
}

function getEncrypt(){
	var sourceData = encodeURI($("#sourceData").val());
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
            $("#merSignMsg").val(signMsg);
        }
	});
}

function doSubmit(){
	$("#myform").submit();
}
</script>
</head>
<body>
	<div align="center">

		<!-- <form action="https://pay.yoyipay.com/pay/inputFund.do" -->
		<!-- <form action="http://localhost:8080/pay/inputFund.do" -->
		<form action="http://60.12.221.84:28080/pay/preBind.do"
			method="post" target="_blank" id="myform"
			style="border-color: gray; padding-top: 40px;">
			<table>
				<tr>
					<td>interfaceName</td>
					<td><input id="interfaceName" name="interfaceName" type="text"
						value="30001" /></td>
				</tr>
				<tr>
					<td>merchantId</td>
					<td><input id="merchantId" name="merchantId" type="text"
						value="ds1073" /></td>
				</tr>
				<tr>
					<td>tranData</td>
					<td><textarea id="tranDataShow" rows="5" cols="100"></textarea></td>
				</tr>
				<tr>
					<td>merSignMsg</td>
					<td><textarea id="merSignMsg" name="merSignMsg" rows="5" cols="100"></textarea></td>
				</tr>
			</table>
			<input type="hidden" id="tranData" name="tranData" value="" />
			<p>
				<input id="submitBtn" type="button" value="提交" onclick="doSubmit();" />
			</p>
		</form>
	</div>
	<div align="center" style="border: 1px solid gray; height: 550px;">
		<div align="right"
			style="float: left; width: 600px; height: 500px; padding-right: 20px; padding-top: 20px;">
			<table border="1px">
				<tr>
					<td>transAccNo</td>
					<td><input id="transAccNo" name="transAccNo" type="text"
						value="" /></td>
				</tr>
				<tr>
					<td>merchantId</td>
					<td><input id="merchantId2" name="merchantId2" type="text"
						value="ds1073" /></td>
				</tr>
				<tr>
					<td>name</td>
					<td><input id="name" name="name" type="text"
						value="name" /></td>
				</tr>
				<tr>
					<td>certType</td>
					<td><input id="certType" name="certType" type="text" value="CNY" /></td>
				</tr>
				<tr>
					<td>certNo</td>
					<td><input id="certNo" name="certNo" type="text"
						value="" /></td>
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
					<option value="MD5" onclick="$('#signShow').show();">MD5</option>
					<option value="ITRUS" onclick="$('#signShow').hide();">ITRUS</option>
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