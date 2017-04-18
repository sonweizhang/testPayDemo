<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/testPayDemo/js/jquery-1.4.4.min.js"></script>
<title>2.4 汇款文件处理申请</title>
<script type="text/javascript">
function checkFTPFile(){
	var ftpFileName = $("#ftpFileName").val();
	var merchantId = $("#merchantId2").val();
    
	$.ajax({  
        type:"post",//请求方式  
        url:"../CheckFTPFile",//发送请求地址  
        dataType:"json",  
        data:{//发送给数据库的数据  
        	"ftpFileName" : ftpFileName,
        	"merchantId" : merchantId
        },  
        //请求成功后的回调函数  
        success:function(data){  
            var objs=eval(data); //解析json对象  
            var isExist = objs["ifExist"];
            
            if(isExist==true){
            	alert("文件已上传");
            	$("#submitBtn").enabled();
            }else{
            	alert("文件未上传");
            	$("#submitBtn").disabled();
            }
        }
	});
}

function getFileName(){
	var merchantId2 = $("#merchantId2").val();
	var nowDate = $("#nowDate").val();
	var number = $("#number").val();
	var postfix = $("#postfix").val();
	var result = ""+merchantId2+"_"+nowDate+"_"+number+"."+postfix;
	$("#ftpFileName").val(result);
}

function getTranData(){
	var version = $("#version").val();
	var ftpFileName = $("#ftpFileName").val();
	var notifyURL = $("#notifyURL").val();
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" ?><B2CReq>" +
	"<version>"+version+"</version><ftpFileName>"+ftpFileName+"</ftpFileName>" +
	"<notifyURL>"+notifyURL+"</notifyURL>" +
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
</script>
</head>
<body>
	<div align="center">

		<form action="http://60.12.221.84:28080/pay/batchRemit.do"
			method="post" target="_blank"
			style="border-color: gray; padding-top: 40px;">
			<!-- <form action="http://localhost:8080/pay/pilianghuikuan.do" method="post" target="_blank" style="border-color: gray;padding-top: 40px;"> -->
			<table>
				<tr>
					<td>interfaceName</td>
					<!-- 退款查询的interfaceName字段，传QueryRefundOrder -->
					<td><input id="interfaceName" name="interfaceName" type="text"
						value="QueryRefundOrder" /></td>
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
				<input id="submitBtn" type="submit" />
			</p>
		</form>
	</div>
	<div align="center" style="border: 1px solid gray; height: 370px;">
		<div align="right"
			style="float: left; width: 600px; height: 300px; padding-right: 20px; padding-top: 20px;">
			<p align="center">生成tranData所需参数：</p>
			<table border="1px;">
				<tr>
					<td>version</td>
					<td><input id="version" name="version" type="text"
						value="B2C1.0" /></td>
				</tr>
				<tr>
					<td>ftpFileName</td>
					<td><input id="ftpFileName" name="ftpFileName" type="text"
						value="请点击“1.生成文件名”按钮生成文件名" disabled="disabled"
						style="width: 200px;" /></td>
				</tr>
				<tr>
					<td>notifyURL</td>
					<td><input id="notifyURL" name="notifyURL" type="text"
						value="http://192.168.1.191:8088/testPayDemo/NotificationDemo"
						style="width: 200px;" /></td>
				</tr>
			</table>
			<p align="center">生成文件名所需参数：</p>
			<table border="1px">
				<tr>
					<td>商户号</td>
					<td><input id="merchantId2" name="merchantId2" type="text"
						value="M100001520" /></td>
				</tr>
				<tr>
					<td>日期(yyyyMMdd)</td>
					<%
					Date date = new Date(); 
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					String dateStr = sdf.format(date);
					%>
					<td><input id="nowDate" name="nowDate" type="text"
						value="<%=dateStr %>" /></td>
				</tr>
				<tr>
					<td>序号</td>
					<td><input id="number" name="number" type="text" value="002" /></td>
				</tr>
				<tr>
					<td>后缀名</td>
					<td><select id="postfix">
							<option value="csv" selected="selected">csv</option>
							<option value="xls">xls</option>
					</select></td>
				</tr>
			</table>
		</div>
		<div align="center"
			style="float: left; width: 250px; height: 300px; padding-top: 40px;">
			<button onclick="getFileName();" style="width: 200px;">
				<p>1.生成文件名</p>
			</button>
			<button onclick="checkFTPFile();" style="width: 200px;">
				<p>2.请确保上传文件到FTP</p>
			</button>
			<button onclick="getTranData();" style="width: 200px;">
				<p>3.组装tranData原文</p>
			</button>
			<button onclick="getEncrypt();" style="width: 200px;">
				<p>4.生成base64密文和签名</p>
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
			style="float: left; height: 250px; padding-left: 20px; padding-top: 20px;">
			<textarea rows="12" cols="50" id="sourceData" name="sourceData">请点击“3.组装tranData原文”按钮生成原文</textarea>
		</div>
	</div>
</body>
</html>