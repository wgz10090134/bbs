<%@ page contentType="text/html; charset=gbk" pageEncoding="gbk" %>
<%
String action = request.getParameter("action");
if(action != null && action.equals("login")) {
	String username = request.getParameter("uname");
	String password = request.getParameter("pwd");
	if(username == null || !username.equals("admin")) {
		%>
		<font color="red" size=10>请检查用户名！</font>
		<%
		//return;
	}else if(password == null || !password.equals("admin")) {
		%>
		<font color="red" size=10>请检查密码！</font>
		<%
		//return;
	}else {
		session.setAttribute("name", "admin");
		response.sendRedirect("tabtree.jsp");
	}
}
%>
<HTML><HEAD><TITLE>bbs Login</TITLE>
</HEAD>
<BODY ><!-- background=images/7.jpg -->
<FORM action="login.jsp" method="post">
<input type=hidden name=action value=login>
<table border="2"><TR>
  <TD>
<LABEL 
  for=uname>用户名:</LABEL></TD>
  <TD><INPUT id=uname name=uname></TD></TR>
  <TR>
  <TD>
<LABEL for=pwd>密码:</LABEL></TD>
  <TD><INPUT id=pwd type=password 
  name=pwd></TD></TR>
  </table>
    <input type="submit" value="登陆">
  </FORM>
  <form action="tabflat.jsp">
     <input type="submit" value="返回主页 ">
</form>
</BODY></HTML>
