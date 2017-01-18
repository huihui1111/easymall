<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
<style type="text/css">
body {
	background: #F5F5F5;
	text-align: center;
}

table {
	text-align: center;
	margin: 0px auto;
}

th {
	background-color: silver;
}
.row1{
	background-color: orange;
}
.row2{
	background-color: blue;
}
</style>
<script type="text/javascript" src="${app}/js/ajax.js"></script>
<script type="text/javascript">
//pid：商品的id，iptObj:代表输入框对象，oldNum“原始”库存
function changePnum(pid,iptObj,oldNum){
	var newPnum = iptObj.value;
	var reg = /^[1-9][0-9]*$/;
	if(!reg.test(newPnum)){//不合法
		alert("输入数据不合法，请输入正整数!");
		iptObj.value = oldNum;
		return;
	}
	//1.获取XMLHttpRequest对象
	var xmlHttp = ajaxFunction();
	//2.打开与服务器的连接
	xmlHttp.open("POST", "${app}/servlet/AjaxChangePnumServlet", true);
	//3.发送请求
	//通知服务器当前发送的是请求参数
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send("id="+pid+"&newPnum="+newPnum);
	//4.注册监听
	xmlHttp.onreadystatechange = function(){
		//获取服务器处理的结果
		if(xmlHttp.readyState == 4){
			if(xmlHttp.status == 200){
				//获取结果
				var result = xmlHttp.responseText;
				if(result == "true"){
					alert("库存修改成功！");
				}else{
					alert("库存修改失败！");
				}
			}
		}
	};
}
//pid：商品的id，iptObj:代表输入框对象，oldNum“原始”库存
function changePnum(pid,iptObj){
	var newPnum = iptObj.value;
	var reg = /^[1-9][0-9]*$/;
	if(!reg.test(newPnum)){//不合法
		alert("输入数据不合法，请输入正整数!");
		iptObj.value = document.getElementById("hd_"+pid).value;
		return;
	}else if(newPnum==document.getElementById("hd_"+pid).value){
		return;
	}
	//1.获取XMLHttpRequest对象
	var xmlHttp = ajaxFunction();
	//2.打开与服务器的连接
	xmlHttp.open("POST", "${app}/servlet/AjaxChangePnumServlet", true);
	//3.发送请求
	//通知服务器当前发送的是请求参数
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send("id="+pid+"&newPnum="+newPnum);
	//4.注册监听
	xmlHttp.onreadystatechange = function(){
		//获取服务器处理的结果
		if(xmlHttp.readyState == 4){
			if(xmlHttp.status == 200){
				//获取结果
				var result = xmlHttp.responseText;
				if(result == "true"){
					document.getElementById("hd_"+pid).value=newPnum;
					alert("库存修改成功！");
				}else{
					alert("库存修改失败！");
				}
			}
		}
	};
}
//pid：商品的id，iptObj:代表输入框对象，oldNum“原始”库存
function changePnum(pid){
	var newPnum = document.getElementById(pid).value;
	//数据输入错误，回填
	document.getElementById(pid).value = document.getElementById("hd_"+pid).value;
}
function deleteProd(prodId){
	if(window.confirm("您确定删除？")){
		window.location.href = "${app}/pages/back/deletProd.action?id="+prodId;
	}
}
</script>
</head>
<body>
	<h1>商品管理</h1>
	<a href="${app}/pages/back/addProd.action">添加商品</a>
	<hr>
	<table bordercolor="black" border="1" width="95%" cellspacing="0px" cellpadding="5px">
		<tr>
			<th>全选<input type="checkbox" > </th>
			<th>商品图片</th>
			<th>商品名称</th>
			<th>商品种类</th>
			<th>商品单价</th>
			<th>库存数量</th>
			<th>描述信息</th>
			<th nowrap="nowrap">&nbsp;&nbsp;操&nbsp;&nbsp;&nbsp;&nbsp;作&nbsp;&nbsp;</th>
		</tr>
	<c:forEach items="${prodList}" var="prod" varStatus="stat">
		
			<tr  <c:if test="${stat.count%2==1}">class="row1"</c:if>
			<c:if test="${stat.count%2==0}">class="row2"</c:if>>
				<td><input type="checkbox" name="prodId" value="${prod.id}">  </td>
				<td><img width="120px" height="120px" src="${app }/showImg.action?imgurl=${prod.imgurl}"/></td>
				<td>${prod.name }</td>
				<td>${prod.category}</td>
				<td>${prod.price}</td>
				<td>
				<input type="hidden" id="hd_${prod.id }" value="${prod.pnum }"/>
				<input type="text" id="${prod.id}" value="${prod.pnum }" 
					style="width: 50px" onblur="changePnum('${prod.id}',this)"/></td>
				<td>${prod.desc}</td>
				<td><a href="${app}/pages/back/deletProd.action?prodId=${prod.id}">删除</a>
				<a href="${app}/pages/back/updateProd.action?prodId=${prod.id}">修改</a></td>
			</tr>
	</c:forEach>
	</table>
</body>
</html>
