<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ok!</title>
</head>
<body>
	    	    <font color="red" size=10>登陆成功！</font><br/>   	   
	    	     <span id="time" style="background:yellow">5</span>秒钟后自动跳转，如果不跳转，请点击下面链接

<script  type="text/javascript">
function delayURL(url) {
	var delay = document.getElementById("time").innerHTML;
	if(delay > 0) {
		delay--;
		document.getElementById("time").innerHTML = delay;
	} else {
		window.top.location.href = url;
    }
    setTimeout("delayURL('" + url + "')", 1000); 
}
</script>
<a href="tabflat.jsp">返回主页</a>
<script type="text/javascript">
	delayURL("tabflat.jsp");
</script>
</body>
</html>