<%@page import="java.nio.charset.Charset"%>
<%@page import="base.ProcessMessage"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript" src="/testPayDemo/js/jquery-1.4.4.min.js"></script>
<title>2.1 ��ȡ��������</title>
<script type="text/javascript">
function getTranData(){
	var remark = $("#remark").val();
	var result = "<?xml version=\"1.0\" encoding=\"GBK\" ?><B2CReq>" +
	"<remark>"+remark+"</remark>" + 
	"</B2CReq>";
	$("#sourceData").val(result);
}

function getEncrypt(){
	var sourceData = encodeURI($("#sourceData").val(),"GBK");
	var signKey = $("#signKey").val();
	var encryptType = $("#encryptType").val();
	
	$.ajax({  
        type:"post",//����ʽ  
        url:"../EncryptDemo",//���������ַ  
        dataType:"json",  
        data:{//���͸����ݿ������  
        	"sourceData" : sourceData,
        	"signKey" : signKey,
        	"encryptType" : encryptType
        },  
        //����ɹ���Ļص�����  
        success:function(data){  
            var objs=eval(data); //����json����  
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

		<!-- <form action="http://localhost:8080/pay/getBanksForPay.do" -->
		<!-- <form action="https://pay.yoyipay.com/pay/getBanksForPay.do" -->
		<form action="http://60.12.221.84:28080/pay/getBanksForPay.do"
			method="post" target="_blank"
			style="border-color: gray; padding-top: 40px;">
			<table>
				<tr>
					<td>interfaceName</td>
					<td><input id="interfaceName" name="interfaceName" type="text"
						value="getBanksForPay" /></td>
				</tr>
				<tr>
					<td>version</td>
					<td><input id="version" name="version" type="text"
						value="B2C1.0" /></td>
				</tr>
				<tr>
					<td>merchantId</td>
					<td><input id="merchantId" name="merchantId" type="text"
						value="M100002065" /></td>
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
				<input id="submitBtn" type="submit" value="�ύ" />
			</p>
		</form>
	</div>
	<div align="center" style="border: 1px solid gray; height: 250px;">
		<div align="right"
			style="float: left; width: 600px; height: 200px; padding-right: 20px; padding-top: 20px;">
			<table border="1px">
				<tr>
					<td>remark</td>
					<td><input id="remark" name="remark" type="text"
						value="�����ֶοɲ���" /></td>
				</tr>
			</table>
		</div>
		<div align="center"
			style="float: left; width: 250px; height: 200px; padding-top: 20px;">
			<button onclick="getTranData();" style="width: 200px;">
				<p>1.��װtranDataԭ��</p>
			</button>
			<button onclick="getEncrypt();" style="width: 200px;">
				<p>2.����base64���ĺ�ǩ��</p>
			</button>
			<p>
			��ѡ��ǩ����ʽ��
				<select title="ǩ����ʽ" id="encryptType" name="encryptType">
					<option value="ITRUS" onclick="$('#signShow').hide();" select="select">ITRUS</option>
					<option value="MD5" onclick="$('#signShow').show();">MD5</option>
				</select>
			</p>
			<p id="signShow">
				ǩ����Կ<input id="signKey" name="signKey" type="text" value="123123"
					style="width: 200px;" />
			</p>
		</div>
		<div align="center"
			style="float: left; height: 200px; padding-left: 20px; padding-top: 20px;">
			<textarea rows="5" cols="50" id="sourceData" name="sourceData">������1.��װtranDataԭ�ġ���ť����ԭ��</textarea>
		</div>
	</div>
</body>
</html>