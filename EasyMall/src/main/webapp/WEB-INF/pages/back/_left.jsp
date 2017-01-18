<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../base.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
  	<style type="text/css">
  		body{
  		.
  			background: #6495ED;
  			text-align: center;
  			font-size: 25px;
  		}
  		a{
  			text-decoration: none;
  		}
  	</style>
  </head>
  <script type="text/javascript">
  function toHome(path){
		top.location.href = path+"/home.action";
	}
  </script>
  <body>
	<a href="#" onclick="toHome('${app}');" >返回首页</a><br>
	<a target="_right" href="${app}/pages/back/findAllProd">商品管理</a><br>
	<a target="_right" href="#">用户管理</a><br>
	<a target="_right" href="#">权限管理</a><br>
	<a target="_right" href="${app }/servlet/SaleInfoListServlet">销售榜单</a><br>
  </body>
</html>
