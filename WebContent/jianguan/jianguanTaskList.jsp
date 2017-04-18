<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资金结算系统核心接口测试</title>
</head>
<body>
	<h2 align="center">资金结算系统核心接口测试</h2>
	<hr>
	<div align="center">
		<p>
			<a href="<%=request.getContextPath()%>/jianguan/jianguanPreBind.jsp">2.2
				预签约（账户绑定）（30001）</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/jianguan/jianguanPreUnBind.jsp">2.3
				预解约（解除账户绑定）（30002）</a>
		</p>
		<p>
			<a href="<%=request.getContextPath()%>/jianguan/jianguanInputFund.jsp">2.4
				客户入金（电商平台端发起）（30003）</a>
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/jianguan/jianguanInputFundMer.jsp">2.5
				电商平台入金（电商平台端发起）（30006）</a>
		</p>
		<p>
			<a
				href="<%=request.getContextPath()%>/jianguan/jianguanModifyCustInfo.jsp">2.6
				客户资料完善（只针对迁移客户）（30014）</a>
		</p>
	</div>
	<hr>
</body>
</html>