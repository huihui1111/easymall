<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../base.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>商品查询列表页</title>
    <!-- 样式 -->
 	<link href="${app}/staticfile/css/prodList.css" rel="stylesheet" type="text/css">
 	<link href="${app}/staticfile/css/page.css" rel="stylesheet" type="text/css">
 	
</head>
<body>

	<div id="content">
		<div id="search_div">
			<form id="searchForm" method="post">
				<span class="input_span">商品名：<input type="text" name="name" value=""/></span>
				<span class="input_span">商品种类：<input type="text" name="category" value=""/></span>
				<span class="input_span">商品价格区间：<input type="text" name="minprice" value=""/> -
				 <input type="text" name="maxprice" value=""/></span>
				<input type="button" value="查询" onclick="formSubmit('selectProd','_self');this.blur();">
			</form>
		</div>
		<div id="prod_content">
	<c:forEach items="${prodList}" var="prod">
			<div id="prod_div">
				<a href="${app}/prodInfo?prodId=${prod.id}">
				<img src="${app}/showImg.action?imgurl=${prod.imgurl}"></img>
				</a>
				<div id="prod_name_div">
				<a href="${app}/servlet/ProdInfoServlet?pid=${prod.id}">
					${prod.name }
				</a>
				</div>
				<div id="prod_price_div">
					${prod.price}元
				</div>
				<div>
					<div id="gotocart_div">
						<a href="${app}/servlet/CartAddServlet?id=${prod.id}">加入购物车</a>
					</div>					
					<div id="say_div">
						库存：${prod.pnum}
					</div>					
				</div>
			</div>
	</c:forEach>	
		</div>
		<div style="clear: both"></div>
	</div>
	<div id="fy_div">
	
共${page.countrow }条记录 共${page.countpage }页
<a href="javascript:void(0)" onclick="changePageA(1)">首页</a>
<a href="javascript:void(0)" onclick="changePageA(${page.prepage})">上一页</a>
<%-- 分页逻辑开始 --%>
<c:set var="begin" scope="page" value="1"/>
<c:set var="end" scope="page" value="1"/>
<c:if test="${page.countpage<=5}">
	<c:set var="begin" scope="page" value="1"/>
	<c:set var="end" scope="page" value="${page.countpage }"/>
</c:if>
<c:if test="${page.countpage>5 }">
	<c:choose>
		<c:when test="${page.thispage<=3}">
			<c:set var="begin" scope="page" value="1"/>
			<c:set var="end" scope="page" value="5"/>
		</c:when>
		<c:when test="${page.thispage>=page.countpage-2 }">
			<c:set var="begin" scope="page" value="${page.countpage-4 }"/>
			<c:set var="end" scope="page" value="${page.countpage }"/>
		</c:when>
		<c:otherwise>
			<c:set var="begin" scope="page" value="${page.thispage-2 }"/>
			<c:set var="end" scope="page" value="${page.thispage+2 }"/>
		</c:otherwise>
	</c:choose>
</c:if>
<c:forEach begin="${begin }" end="${end}" step="1" var="i">
	<c:if test="${i!=page.thispage}">
		<a href="javascript:void(0)" onclick="changePageA(${i})">${i }</a>
	</c:if>
	<c:if test="${i==page.thispage}">${i }</c:if>
</c:forEach>


<%-- 分页逻辑结束 --%>
<a href="javascript:void(0)" onclick="changePageA(${page.nextpage})">下一页</a>
<a href="javascript:void(0)" onclick="changePageA(${page.countpage})">尾页</a>
跳转到<input type="text" value="${page.thispage }" onblur="changePageB(this)"/>页
</div>

</body>
</html>