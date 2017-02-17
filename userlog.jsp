<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.*" %>
    <%
    boolean corruser=false;
    String username = "";
    String password = "";
String action = request.getParameter("action");
if(action != null && action.equals("login")) {
	username = request.getParameter("uname");
	 password = request.getParameter("pwd"); 
	%>
	 <% 
	if(username==""||password=="") {
		%>
		<font color="red" size=10>用户名/密码/不能为空！</font>	
		<%}
	else if(username.trim().length()<4||password.trim().length()<4){
			%>
			<font color="red" size=10>兄弟，别搞我呀</font>
		<%}
	if(username.trim().length()>=4&&password.trim().length()>=4){
		corruser=true;
			}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户login</title>
</head>
<body>
 <%
    if(corruser){
  		Class.forName("com.mysql.jdbc.Driver");
	    String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
	    Connection conn = DriverManager.getConnection(url);    
	    Statement  sm1 = conn.createStatement();
	    ResultSet rs1 = sm1.executeQuery("select * from user where name = '"+username+"'");
	    if(rs1.next()){
	    	if(rs1.getString("password").equals(password)){
	    	    session.setAttribute("name", username);
	    	    response.sendRedirect("logok.jsp");
	    	}else{
	    		 %> 
			<font color="red" size=10>密码错误！</font>
		    	 <%
	    	}
	    }else{
	    	 %>
	<font color="red" size=10>用户名错误！</font>
	    	  <%
	    }
	    rs1.close();
	    sm1.close();
	    conn.close();
    }
	    %>
<FORM action="userlog.jsp" method="post">
<input type=hidden name=action value="login">
<table border="2"><TR>
  <TD>
<LABEL 
  for=uname >用户名:</LABEL></TD>
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
</body>
</html>