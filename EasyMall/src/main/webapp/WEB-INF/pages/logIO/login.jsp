<%@page import="java.net.URLDecoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="app" value="${pageContext.request.contextPath}/staticfile"/>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" href="${app}/css/login.css"/>
		<title>EasyMall欢迎您登陆</title>
		<script type="text/javascript">
			window.onload = function(){
				document.getElementsByName("username")[0].value = decodeURI(document.getElementsByName("username")[0].value, "utf-8");
			};
		</script>
	</head>
	<body>
		<h1>欢迎登陆EasyMall</h1>
		<form action="login.action" method="POST">
			<table>
				<td class="tdx" colspan="2" style="color:red; font-size: 14px;text-align:center">
					${ msg }
				</td>
				<tr>
					<td class="tdx">用户名:</td>
					<td><input type="text" name="username" value="${ cookie.remname.value }"/></td>
				</tr>
				<tr>
					<td class="tdx">密码:</td>
					<td><input type="password" name="password"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="remname" value="true" 
							${ cookie.remname.value == "" ? "": 'checked=checked' }
						/>记住用户名
						<input type="checkbox" name="autologin" value="true"/>30天内自动登陆
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="登陆"/>
					</td>
				</tr>
			</table>
		</form>		
	</body>
</html>
