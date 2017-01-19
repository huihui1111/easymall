<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="app" value="${pageContext.request.contextPath }"/>
<!DOCTYPE HTML>
<html>
  <head>
    <title>我的购物车</title>
  	<link href="${app}/staticfile/css/cart.css" rel="stylesheet" type="text/css">
  	<script type="text/javascript">
  	function changeBuyNum(id,oldBuyNum,obj){
  		if(!/^[1-9][0-9]*$/.test(obj.value)){
  			alert("请输入正整数");
  			obj.value = oldBuyNum;
  			return;
  		}
  		if(obj.value!=oldBuyNum){
  			window.location.href="${app}/pages/cart/update.action?id="+id+"&newBuyNum="+obj.value;
  		}
  	}
  	function delNum(id,obj){
  		var input = obj.parentNode.getElementsByTagName("input")[0];
  		var newBn = parseInt(input.value)-1;
  		if(newBn>0){
  			window.location.href="${app}/pages/cart/update.action?id="+id+"&newBuyNum="+newBn;
  		}else{
  			window.location.href = "${app}/pages/cart/delete.action?id="+id;
  		}
  	}
  	function addNum(id,obj){
  		var input = obj.parentNode.getElementsByTagName("input")[0];
  		var newBn = parseInt(input.value)+1;
  		window.location.href="${app}/pages/cart/update.action?id="+id+"&newBuyNum="+newBn;
  	}
  	
  	
  	function formSubmit (url,sTarget){
  		top.location.href=url;
  	}
  	
  	function toOderList (path){
  		window.location.href = path+"addOrder.action";
  	}
  	</script>
	</head>
	<body>

		<div class="warp">
		${msg}
			<!-- 标题信息 -->
			<div id="title">
				<input name="allC" type="checkbox" value="" onclick=""/>
				<span id="title_checkall_text">全选</span>
				<span id="title_name">商品</span>
				<span id="title_price">单价（元）</span>
				<span id="title_buynum">数量</span>
				<span id="title_money">小计（元）</span>
				<span id="title_del">操作</span>
			</div>
			<!-- 购物信息 -->
	<c:set var="money" value="0" scope="page"/>
	<c:forEach items="${cart}" var="prod">
			  <div id="prods">
				<input name="prodC" type="checkbox" value="" onclick=""/>
		  	<img src="${app}/showImg.action?imgurl=${prod.key.imgurl}"  width="90" height="90" /> 
				<span id="prods_name">${prod.key.name }</span>
				<span id="prods_price">${prod.key.price}</span>
				<span id="prods_buynum"> 
					<a href="javascript:void(0)" id="delNum" onclick="delNum('${prod.key.id}',this)">-</a>
					<input id="buyNumInp" type="text" value="${prod.value }" onblur="changeBuyNum('${prod.key.id}',${prod.value },this)">
					<a href="javascript:void(0)" id="addNum" onclick="addNum('${prod.key.id}',this)">+</a>
				</span>
				<span id="prods_money">${prod.key.price*entry.value}</span>
				<span id="prods_del"><a href="${app}/pages/cart/delete.action?prodId=${prod.key.id}">删除</a></span>
				<c:set var="money" value="${money+prod.key.price*prod.value}" scope="page"/>
			</div>
	</c:forEach>
			<!-- 总计条 -->
			<div id="total">
				<div id="total_1">
					<input name="allC" type="checkbox" value=""/> 
					<span>全选</span>
					<a id="del_a" href="#">删除选中的商品</a>
					<span id="span_1">总价：</span>
					<span id="span_2">${money}</span>
				</div>
				<div id="total_2">	
					<a id="goto_order" href="${app}/pages/order/addOrder.action" >去结算</a>
				</div>
			</div>
		</div>

	</body>
</html>