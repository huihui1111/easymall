<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../base.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>订单列表页</title>
 	<link href="${app }/staticfile/css/orderList.css" rel="stylesheet" type="text/css">
</head>
<body style="text-align:center;">
  <c:forEach items="${list}" var="oi">
		<dl class="Order_information">
			<dt>
				<h3>订单信息</h3>
			</dt>
			 <dd>
				订单编号：${oi.orders.id }<br />
				 下单时间： <fmt:formatDate value='${oi.orders.ordertime}' pattern='yyyy-MM-dd'/><br/>
				 订单金额：${oi.orders.money}<br />
				 支付状态：
				 <c:if test="${oi.orders.paystate==0}">
						<font color="red">未支付</font>&nbsp;&nbsp;&nbsp;
						<a href="${app }/pages/order/delete.action?id=${oi.orders.id}"><img src="${app}/staticfile/img/orderList/sc.jpg" width="69" height="19"></a> 
				 		<a href="${app }/pay.jsp?id=${oi.orders.id}&money=${oi.orders.money}"> <img src="${app}/staticfile/img/orderList/zx.jpg" width="69" height="19"></a><br /> 
				 </c:if>
				 <c:if test="${oi.orders.paystate==1}">
						<font color="blue">已支付</font>
				 </c:if>
				 收货地址：${oi.orders.receiverinfo }<br/> 
				支付方式：在线支付
			</dd>
		</dl>
	
		<table width="1200" border="0" cellpadding="0"
			cellspacing="1" style="background:#d8d8d8;color:#333333">
			<tr>
				<th width="276" height="30" align="center" valign="middle" bgcolor="#f3f3f3">商品图片</th>
				<th width="247" align="center" valign="middle" bgcolor="#f3f3f3">商品名称</th>
				<th width="231" align="center" valign="middle" bgcolor="#f3f3f3">商品单价</th>
				<th width="214" align="center" valign="middle" bgcolor="#f3f3f3">购买数量</th>
				<th width="232" align="center" valign="middle" bgcolor="#f3f3f3">小计</th>
			</tr>
		<c:forEach items="${oi.map}" var="entry">
			<tr>
				<td align="center" valign="middle"; bgcolor="#FFFFFF">
					<img src="${app}/showImg.action?imgurl=${entry.key.imgurl}" width="90" height="105">
				</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.key.name }</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.key.price }元</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.value}件</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.value*entry.key.price }元</td>
			</tr>
		</c:forEach>
		</table>
		<div class="Order_price">${oi.orders.money}元</div>
  </c:forEach>
		
</body>
</html>
