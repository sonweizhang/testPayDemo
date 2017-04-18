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
<title>2.1 支付请求</title>
<script type="text/javascript">
function getTranData(){
	var merchantId = $("#merchantId2").val();
	var orderNo = $("#orderNo").val();
	var orderAmt = $("#orderAmt").val();
	var curType = $("#curType").val();
	var returnURL = $("#returnURL").val();
	var notifyURL = $("#notifyURL").val();
	var remark = $("#remark").val();
	var userId = $("#userId").val();
	var goodsName = $("#goodsName").val();
	var goodsType = $("#goodsType").val();
	var isBind = $("#isBind").val();
	var mobile = $("#mobile").val();
	var certNo = $("#certNo").val();
	var userName = $("#userName").val();
	var cardNo = $("#cardNo").val();
	var bankType = $("#bankType").val();
	var cardType = $("#cardType").val();
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" ?><B2CReq>" +
	"<merchantId>"+merchantId+"</merchantId><orderNo>"+orderNo+"</orderNo><orderAmt>"+orderAmt+"</orderAmt>" + 
	"<curType>"+curType+"</curType><returnURL>"+returnURL+"</returnURL><notifyURL>"+notifyURL+"</notifyURL>" +
	"<remark>"+remark+"</remark><userId>"+userId+"</userId><goodsName>"+goodsName+"</goodsName>" + 
	"<goodsType>"+goodsType+"</goodsType><isBind>"+isBind+"</isBind><mobile>"+mobile+"</mobile>" + 
	"<certNo>"+certNo+"</certNo><userName>"+userName+"</userName><cardNo>"+cardNo+"</cardNo>" + 
	"<bankType>"+bankType+"</bankType><cardType>"+cardType+"</cardType>" + 
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

		<!-- <form action="https://pay.yoyipay.com/pay/preprocess.do" -->
		<!-- <form action="http://60.12.221.84:28080/pay/preprocess.do" -->
		<form action="http://localhost:8080/pay/preprocess.do"
			method="post" target="_blank" id="myform"
			style="border-color: gray; padding-top: 40px;">
			<table>
				<tr>
					<td>interfaceName</td>
					<td><input id="interfaceName" name="interfaceName" type="text"
						value="PayOrder" /></td>
				</tr>
				<tr>
					<td>version</td>
					<td><input id="version" name="version" type="text"
						value="B2C1.0" /></td>
				</tr>
				<tr>
					<td>merchantId</td>
					<td><input id="merchantId" name="merchantId" type="text"
						value="M100001520" /></td>
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
					<td>merchantId</td>
					<td><input id="merchantId2" name="merchantId2" type="text"
						value="M100001520" /></td>
				</tr>
				<tr>
					<td>orderNo</td>
					<%
					Date date = new Date(); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String dateStr = "test"+sdf.format(date)+"001";
					%>
					<td><input id="orderNo" name="orderNo" type="text"
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
					<td><input id="remark" name="remark" type="text" value="威尼熊" /></td>
				</tr>
				<tr>
					<td>userId</td>
					<td><input id="userId" name="userId" type="text"
						value="ShopUserId123456" /></td>
				</tr>
				<tr>
					<td>goodsName</td>
					<td><input id="goodsName" name="goodsName" type="text"
						value="" title="跳转至银行的商品名称" /></td>
				</tr>
				<tr>
					<td>goodsType</td>
					<td><input id="goodsType" name="goodsType" type="text"
						value="0" /></td>
				</tr>
				<tr>
					<td>isBind</td>
					<td><input id="isBind" name="isBind" type="text" value="" /></td>
				</tr>
				<tr>
					<td>mobile</td>
					<td><input id="mobile" name="mobile" type="text" value="" /></td>
				</tr>
				<tr>
					<td>certNo</td>
					<td><input id="certNo" name="certNo" type="text" value="" /></td>
				</tr>
				<tr>
					<td>userName</td>
					<td><input id="userName" name="userName" type="text" value="" /></td>
				</tr>
				<tr>
					<td>cardNo</td>
					<td><input id="cardNo" name="cardNo" type="text" value="" /></td>
				</tr>
				<tr>
					<td>bankType</td>
					<td><input id="bankType" name="bankType" type="text" value="" /></td>
				</tr>
				<tr>
					<td>cardType</td>
					<td><input id="cardType" name="cardType" type="text" value="" /></td>
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