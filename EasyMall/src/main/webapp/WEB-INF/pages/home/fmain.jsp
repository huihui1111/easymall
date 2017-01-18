<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>EasyMall购物商城</title>
</head>
<frameset rows="175,*" name="easaymallFrameset" border="0">
	<frame name="head_frame" scrolling="no"  target="headFrameSet" src="head.action">	
	<frameset rows="*,58" name="downFrameset" border="0" cols="1200">
		<frame name="body_frame" scrolling="yes"  target="downFrameset" src="body.action">	
		<frame name="foot_frame" scrolling="no"  target="downFrameset" src="foot.action">	
	</frameset>
</frameset>
<noframes>
<body>
    <p>此网页使用了框架，但您的浏览器不支持框架。</p>
</body>
</noframes>

</html>