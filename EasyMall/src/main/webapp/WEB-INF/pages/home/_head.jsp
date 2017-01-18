<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../base.jsp" %>
<!DOCTYPE HTML>
<link rel="stylesheet" href="${app}/staticfile/css/head.css"/>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<jsp:useBean id="now" class="java.util.Date" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>

    <!-- 调用样式表 -->

	<script type="text/javascript" src="${ctx}/staticfile/components/jquery-ui/jquery-1.2.6.js"></script>    	
	<script language="javascript" src="${ctx}/js/pngfix_map.js"></script>
	<script language="javascript" src="${ctx}/js/common.js"></script>
    <!-- 调用外部 JavaScript 脚本语言 -->
	
<script language="javascript">
	
	function linkHighlightMenu(obj){
		var links=document.getElementsByTagName('span');
		for(var i=0;i<links.length;i++){
			if(links[i].id.indexOf('topmenu')!=-1){
				links[i].style.background = 'url("${app}/staticfile/skin/default/images/title/li_dot.gif1") no-repeat right 8px';
				links[i].style.color = '';
				links[i].style.fontWeight  = '';
				links[i].style.borderTop = '';
				links[i].style.borderLeft = '';
				links[i].style.borderRight = '';
				links[i].style.padding = '';
			}
		}
		obj.style.background ='url("${ctx}/staticfile/skin/default/images/title/button_bg.jpg") no-repeat';
		obj.style.color = "#fff";                                                                                                                                                                                                                                                   
		obj.style.fontWeight  = 'bold';
		obj.style.padding= '6px 11x 5px 13px;';
		obj.blur();		//去掉图片的焦点框,使界面看起来漂亮 updated by tony
	}

	//sendRequest('000001');	
	var y = -5; 		//个人信息栏初始Y坐标
	var dy = -40; 		//显示后Y坐标
	
	function doLoginDiv(){
		ShowLoginDiv();
	}
	
	function HideLoginDiv(){
		 dy = dy - 5;
		 MoveHideLoginDiv();
	}	
	function MoveHideLoginDiv(){
		if( dy > -40){setTimeout("HideLoginDiv()",10);}else{ y = -40; dy = -40;}
		document.getElementById("userInfo").style.top = dy;
		
	}
	function ShowLoginDiv(){
		 y = y + 5;
		 MoveShowLoginDiv();
	}	
	function MoveShowLoginDiv(){			
			if( y < -5){setTimeout("ShowLoginDiv()",10);}else{ dy = -5; y = -1 }
			document.getElementById("userInfo").style.top = y;
	}
	function ShowFrameDiv(queryString){
			return false;		//暂时屏蔽
		top.middle.switches.loading.style.display = 'block';
	//	top.middle.switches.note_iframe.location.href="../home/empmemo/empMemoExpressCreate.jsp";
		setTimeout(ShowFrameMain(queryString),10);
	}
	function ShowFrameMain(passValue){
			
			var url = "../home/doConsoleListAction.do";	//../home/empMemoCreateAction.do
			var topFrame = top.middle.switches;

			document.getElementById('PositionFrame').style.display = "block";
			top.middle.contents.left_frame.style.border = "none";
			top.middle.contents.left_frame.style.overflow = "hidden";
			
			topFrame.PositionFrame_main.style.display ="block";
			topFrame.PositionFrame.style.display ="block";
			topFrame.PositionFrame_notebook.style.display = 'block';
			topFrame.PositionFrame_notebook2.style.display = 'none';	
			topFrame.PositionFrame_my_note.style.display = 'block';
			//topFrame.note_iframe.location.href=url;
			form1.action = url;
			form1.method = "post";
			form1.target = "note_iframe";
//			alert(passValue);
			if(passValue){
				form1.innerHTML='<input type="hidden"  name="passTitle" value="' + passValue[0] + '"/>';
				form1.innerHTML=form1.innerHTML + '<input type="hidden"  name="passContent" value="' +passValue[1]+ '"/>';
			}
			form1.submit();
			
			top.middle.contents.PositionFrame.style.display ="block";
			topFrame.loading.style.display = 'none';
			topFrame.PositionFrame_main.style.visibility = 'visible';
			topFrame.visibility.style.display = 'block';
	}
	
   
	function offset(place){
	
		var mask = $('#mask');
		var targetObj = $('#menuContent');
		
		var maxOffset = targetObj.width()-mask.width();
		
		var currLeft = targetObj.css('left');
//		alert(maxOffset + " " + currLeft);
		var currLeft = Number(currLeft.substring(0,currLeft.length-2));
		if(place=="right" && (0-currLeft) <= maxOffset){
			targetObj.css('left', currLeft - 5);
		} else if(place=="left" && currLeft < 0){
				targetObj.css('left', currLeft + 5);
		}
		
	}
	function periodOffset(thisObj, place){
		var intervalId = window.setInterval(function(){offset(place)}, 1);
		$(thisObj).mouseout(function(){window.clearInterval(intervalId)});
	}
	
		function checkDirectionKey(){
			var mask = $('#mask');
			
			var bodyWidth = $('body').width();
			
			//alert(bodyWidth - 450);
			mask.width(bodyWidth - 250);	//450
			//alert(mask.width());
			var targetObj = $('#menuContent');
			
			var maxOffset = targetObj.width()-mask.width();
			
			var currLeft = targetObj.css('left');
//			alert(maxOffset + " " + currLeft);
			var currLeft = Number(currLeft.substring(0,currLeft.length-2));
//			alert((0-currLeft) <= maxOffset);
			if(!(0-currLeft) <= maxOffset || currLeft < 0) {
				$("#rightKey").show("slow");
				$("#leftKey").show("slow");
				if(!isShow){
					$("#prompt_div").show("slow", function(){window.setTimeout(function(){$("#prompt_div").hide("slow")}, 10000);isShow = true;});
				}
			} else {
				$("#rightKey").hide();
				$("#leftKey").hide();
				$("#prompt_div").hide();
			}
		}
		var isShow = false;
		$(function(){
			window.onresize = checkDirectionKey;
			$("#rightKey").hide();
			$("#leftKey").hide();
			$("#prompt_div").hide();
			checkDirectionKey();
		});
		
		function logout(){
			return formSubmit("${ctx}/logout", "_top");
		}
		
		function toModule(moduleName){
			top.body_frame.location.href = moduleName+'.action';
			linkHighlightMenu(this);
		}
		
		function toHome(){
			top.location.href = "home.action";
		}
		
		function toLogin(path){
			top.location.href = path+"tologin.action";
		}
		
		function toregist(path){
			top.location.href = path+"toregist.action";
		}
		
		function toCategory(moduleName,cate){
			top.body_frame.location.href = moduleName+'.action?cate='+cate;
		}
		
		function tologOut(path){
			top.location.href = path+"tologout.action";
		}
		
		function toBack(){
			top.location.href="/pages/back/toBack.action";
		}
</script>
<body>

	<div id="common_head">
		<div id="line1">
			<div id="content">
				<!-- 如果用户没有登录, 才提示 注册或登陆  -->
				<c:if test="${ user != null }">
				欢迎回来,&nbsp;&nbsp;${ user.username }&nbsp;&nbsp;|&nbsp;
				<a href="#" onclick="tologOut('${app}/pages/logIO/');">退出</a>&nbsp;&nbsp;
				<a href="#" onclick="toBack()">后台管理</a>
			</c:if>
			<c:if test="${ user == null  }">
				<a href="#" onclick="toLogin('${app}/pages/logIO/');">登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="#" onclick="toregist('${app}/pages/logIO/');">注册</a>
			</c:if>
			
				
			</div>
		</div>
		<div id="line2">
			<img id="logo" src="${app}/staticfile/img/head/logo.jpg"/>
			<input type="text" name=""/>
			<input type="button" value="搜索"/>
			<span id="goto">
				<a id="goto_order" href="${app}/servlet/OrderListServlet">我的订单</a>
				<a id="goto_cart" href="${app}/cart.jsp">我的购物车</a>
			</span>
			<img id="erwm" src="${app}/staticfile/img/head/qr.jpg"/>
		</div>
		<div id="line3">
			<div id="content">
				<ul>
					<li><a href="#" onclick="toHome();">首页</a></li>
					<li><a href="#" onclick="toModule('findAllProd');">全部商品</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',1);">手机数码</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',2);">电脑平板</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',3);">家用电器</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',4);">汽车用品</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',5);">食品饮料</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',6);">图书杂志</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',7);">服装服饰</a></li>
					<li><a href="#" onclick="toCategory('findProdByCate',8);">理财产品</a></li>
				</ul>
			</div>
		</div>
	</div>
	
</body>