<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.*" %>
    <%
    boolean newuser = false;
    String username = "";
    String password = "";
    String email = "";
String action = request.getParameter("action");
if(action != null && action.equals("login")) {
	username = request.getParameter("uname");
	 password = request.getParameter("pwd");
	 email = request.getParameter("email");	 
	%>
	 <% 
	if(username==""||password==""||email=="") {
		%>
		<font color="red" size=10>用户名/密码/邮箱不能为空！</font>	
		<%}
	else if(username.trim().length()<4||password.trim().length()<4||email.trim().length()<4){
			%>
			<font color="red" size=10>兄弟，别搞我呀</font>
		<%}
	if(username.trim().length()>=4&&password.trim().length()>=4&&email.trim().length()>=4){
		newuser=true;
			}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户注册</title>
</head>
<body>
 <%
    if(newuser){
  		Class.forName("com.mysql.jdbc.Driver");
	    String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
	    Connection conn = DriverManager.getConnection(url);    
	    Statement  sm1 = conn.createStatement();
	    Statement  sm2 = conn.createStatement();
	    ResultSet rs1 = sm1.executeQuery("select * from user where name = '"+username+"'");
	    ResultSet rs2 = sm2.executeQuery("select * from user where email= '"+email+"'");
	    if(!rs1.next()){
	    	if(!rs2.next()){
	    	    conn.setAutoCommit(false);
	    	    PreparedStatement ps = conn.prepareStatement("insert into user values"+
	    		    	"(null,?,?,?,1)",Statement.RETURN_GENERATED_KEYS);
	    		    ps.setString(1, username);
	    		    ps.setString(2, password);
	    		    ps.setString(3, email);
	    		    ps.executeUpdate();
	    	    conn.commit();
	    	    conn.setAutoCommit(true);
	    	    ps.close();
	    	    session.setAttribute("name", username);
	    	    response.sendRedirect("newok.jsp");
	    	}else{
	    		 %> 
	    		<script type="text/javascript">
	    			alert("邮箱已被注册！请重新输入!");
	    		</script>
		    	 <%
	    	}
	    }else{
	    	 %>
	    	 	<script type="text/javascript">
	    		alert("用户名已存在，请重新输入!");
	    		</script>
	    	  <%
	    }
	    rs1.close();
	    rs2.close();
	    sm1.close();
	    sm2.close();
	    conn.close();
    }
	    %>
<FORM action="newuser.jsp" method="post">
<input type=hidden name=action value="login">
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
  <TR>
  <TD>
<LABEL for=email>注册邮箱:</LABEL></TD>
  <TD><INPUT id=email 
  name=email></TD></TR>
  </table>
    <input type="submit" value="注册"> <font  size=3>注意：用户名/密码/邮箱最少4位</font>
  </FORM>
  <form action="tabflat.jsp">
     <input type="submit" value="返回主页 ">
</form>
</body>
</html>