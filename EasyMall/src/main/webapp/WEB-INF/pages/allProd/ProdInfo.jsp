<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>商品详细信息页</title>
  <link href="${app }/staticfile/css/prodInfo.css" rel="stylesheet" type="text/css">
  <script type="text/javascript">
  	function addCart(){
  		window.location.href = "${app}/servlet/CartAddServlet?id=${prod.id}";
  	}
  </script>
</head>
<body>
	<div id="warp">
		<div id="left">
			<div id="left_top">
				<img src="${app }/showImg.action?imgurl=${prod.imgurl}"/>
			</div>
			<div id="left_bottom">
				<img id="lf_img" src="${app }/staticfile/img/prodInfo/lf.jpg"/>
				<img id="mid_img" src="${app }/showImg.action?imgurl=${prod.imgurl}" width="60px" height="60px"/>
				<img id="rt_img" src="${app }/staticfile/img/prodInfo/rt.jpg"/>
			</div>
		</div>
		<div id="right">
			<div id="right_top">
				<span id="prod_name">${prod.name } <br/></span>
				<span id="prod_desc">${prod.desc}<br/></span>
			</div>
			<div id="right_middle">
				<span id="right_middle_span">
						EasyMall 价：<span class="price_red">${prod.price }<br/>
			            运     费：满 100 免运费<br />
			            服     务：由EasyMall负责发货，并提供售后服务<br />
			            库     存：${prod.pnum }<br />
			            购买数量：
	            <a href="#" id="delNum" onclick="">-</a>
	            <input id="buyNumInp" name="" type="text" value="1" onblur="">
		        <a href="#" id="addNum" onclick="">+</a>
			</div>
			<div id="right_bottom">
				<input class="add_cart_but" type="button" onclick="addCart()"/>	
			</div>
		</div>
	</div>
</body>
</html>