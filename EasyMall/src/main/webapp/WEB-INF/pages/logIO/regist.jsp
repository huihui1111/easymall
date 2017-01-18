<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="app" value="${pageContext.request.contextPath}/staticfile"/>
<!DOCTYPE HTML>
<html>
<head>
	<title>欢迎注册EasyMall</title>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="${app}/css/regist.css"/>
	<script type="text/javascript" src="${app}/js/ajax.js"></script>
	<script type="text/javascript">
	
	
		//注册表单js校验
		function checkForm(){
			var flag = true;
			flag = checkNull("username", "用户名不能为空") && flag;
			flag = checkNull("password", "密码不能为空") && flag;
			flag = checkNull("password2", "确认密码不能为空") && flag;
			flag = checkNull("nickname", "昵称不能为空") && flag;
			flag = checkNull("email", "邮箱不能为空") && flag;
			flag = checkNull("valistr", "验证码不能为空") && flag;
			flag = checkPassword("password", "两次密码不一致") && flag;
			flag = checkEmail("email", "邮箱格式不正确") && flag;
			return flag;
		}
		//检查邮箱格式
		function checkEmail(name, msg){
			var email = document.getElementsByName(name)[0].value;
			var reg = /^\w+@\w+(\.\w+)+$/;
			setMsg(name, "");
			checkNull(name, "邮箱不能为空");
			if(email != "" && !reg.test(email)){
				setMsg(name, msg);
				return false;
			}
			return true;
		}
		
		//检查两次密码是否一致
		function checkPassword(name, msg){
			var psw1 = document.getElementsByName(name)[0].value;
			var psw2 = document.getElementsByName(name+"2")[0].value;
			setMsg(name+"2", "");
			checkNull(name+"2", "确认密码不能为空");
			if(psw1 != "" && psw2 != "" && psw1 != psw2){
				setMsg(name+"2", msg);
				return false;
			}
			return true;
		}
		//检查表单项是否为空
		function checkNull(name, msg){
			var value = document.getElementsByName(name)[0].value;
			setMsg(name, "");
			
			if(value == ""){
				setMsg(name, msg);
				return false
			}
			return true;
		}
		
		//设置提示消息
		function setMsg(name, msg){
			document.getElementById(name+"_msg").innerHTML = msg;
		}
		
		//利用ajax校验用户名是否存在
		function ajaxCheckUserName(thisobj){
			var username = thisobj.value;
			if(username == ""){
				setMsg("username", "用户名不能为空");
				return;
			}
			
			//ajax校验用户名
			//1.创建XMLHttpRequest对象
			var xmlHttp = ajaxFunction();
			
			//2.打开与服务器的连接
			xmlHttp.open("POST", "AjaxCheckUserName.action", true);
			
			//3.发送请求
			xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); //用来通知服务器发送的是请求参数
			xmlHttp.send("username="+username);
			
			//4.注册监听
			xmlHttp.onreadystatechange = function(){
				if(xmlHttp.readyState == 4){
					if(xmlHttp.status == 200 || xmlHttp.status == 304){
						var data = ${bool};
						if(data == "true"){
							setMsg("username", "用户名已存在");
						}else{
							setMsg("username", "恭喜用户名可以使用!");
						}
					}
				}
			}
		}
		
	</script>
</head>
<body>
	<h1>欢迎注册EasyMall</h1>
	<form action="save.action" method="POST" onsubmit="return checkForm()">
		<table>
			
			<tr>
				<td class="tds" colspan="2" style="color:red; font-size: 14px;text-align:center">
					${ msg }
				</td>
			</tr>
			<tr>
				<td class="tds">用户名：</td>
				<td>
					<input type="text" name="username" onblur="ajaxCheckUserName(this)" value="${ param.username }">
					<span id="username_msg"></span>
				</td>
			</tr>
			<tr>
				<td class="tds">密码：</td>
				<td>
					<input type="password" name="password" onblur="checkNull('password', '密码不能为空')" >
					<span id="password_msg"></span>
				</td>
			</tr>
			<tr>
				<td class="tds">确认密码：</td>
				<td>
					<input type="password" name="password2"  onblur="checkPassword('password', '两次密码不一致')" >
					<span id="password2_msg"></span>
				</td>
			</tr>
			<tr>
				<td class="tds">昵称：</td>
				<td><input type="text" name="nickname" onblur="checkNull('nickname', '昵称不能为空')"  value="${ param.nickname }">
					<span id="nickname_msg"></span>
				</td>
			</tr>
			<tr>
				<td class="tds">邮箱：</td>
				<td>
					<input type="text" name="email" onblur="checkEmail('email', '邮箱格式不正确')"  value="${ param.email }">
					<span id="email_msg"></span>
				</td>
			</tr>
			<tr>
				<td class="tds">验证码：</td>
				<td>
					<input type="text" name="valistr" onblur="checkNull('valistr', '验证码不能为空')" >
					<img id="yzm_img" onclick="changeImage(this)" src="${app}/ValiImageServlet" style="cursor: pointer"/>
					<span id="valistr_msg"></span>
				</td> 
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="注册用户" />
				</td>
			</tr>
		</table>
	</form>
	<script>
		function changeImage(thisobj){
			thisobj.src = "${app}/ValiImageServlet?time="+new Date().getTime();
		}
	</script>
</body>
</html>
