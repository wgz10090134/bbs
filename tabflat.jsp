<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <% boolean admin=false;
    String userquit = (String ) request.getParameter("quit");
    String usertype = (String )session.getAttribute("name");
    if(userquit!=null&&userquit.equals("yes")){
    	session.setAttribute("name",null);
    	usertype =null;
    }
	if (usertype!=null&&"admin".equals(usertype)){
		admin = true;
	}
    %>
<%
String ss= request.getParameter("pageno");
int pageno =0;
if(ss==null||ss==""){
	pageno=1;
}else{
	try{
		pageno = Integer.parseInt(ss);
	}catch(Exception e){
		pageno =1;
	}
}
if(pageno<=0){
	pageno=1;
}
	int pagesize =8; 	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
	Connection conn = DriverManager.getConnection(url);
	Statement  sm = conn.createStatement();
	Statement  sm2 = conn.createStatement();
	ResultSet rs2= sm2.executeQuery("select count(*) from article where pid =0");
	rs2.next();
	int allnum = rs2.getInt(1);
	int pidnum = allnum%pagesize==0?allnum/pagesize:allnum/pagesize+1;
	if(pageno>=pidnum)
		pageno=pidnum;
	ResultSet rs = sm.executeQuery(
			"select * from article where pid=0 order by pdate desc limit "+
					(pageno-1)*pagesize+","+pagesize);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tabflat</title>
<style type="text/css">
<!--
.STYLE3 {
	font-size: 36px;
	font-family: "Times New Roman", Times, serif;
	font-weight: bold;
	color: #FF0000;
}
-->
</style>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td background="images/header-stretch.gif"  border="0" height="57" width="100%"><div align="center" class="STYLE3">欢迎来到BBS</div></td>
      <td width="1%"><img src="images/header-right.gif"  border="0"></td>
    </tr>
</table>


<div align="center">
  <!-- ---------------------------------------------------------- -->
  &nbsp;&nbsp;&nbsp;
  <%for(int i=1;i<=pidnum;i++){
 %>
  <a href='tabflat.jsp?pageno=<%=i %>'> <%=i %>  </a> &nbsp;
  <% }%>
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
  <% if (usertype==null){ %>	
    <a href="userlog.jsp">用户登陆   </a>
    
    &nbsp;&nbsp;&nbsp;&nbsp; 
    <a href="newuser.jsp">注册   </a>&nbsp;&nbsp;&nbsp;&nbsp; 
    <%}else{ %>
   <a href="newobj.jsp">发表新主题</a>
    <font color="blue" size=3>欢迎：<%= usertype%></font>
    <a href="tabflat.jsp?quit=yes">退出</a>
    <%} %>
   <%
	if (admin){
	%>
		<a href="tabtree.jsp"> 返回后台</a>
	<% 
	}else{
    %>
    <a href="login.jsp"> 管理员登陆</a>
	<% }
    %>

    
    </div>
  <table border="2" cellpadding="5">
<td width="800px" align=center>主题</td><td width="10%" align=center>作者</td>
<td width="10%" align=center>浏览</td><td width="10%" align=center>回复</td>
<td width="200px" align=center>发表时间</td>
<% while(rs.next()){ %>
		<tr>
			<td>
				 <a href='detail.jsp?id=<%=rs.getInt("id") %>&pageno=<%=pageno%>'>			 
				<%= rs.getString("title")%>
				</a>
			</td>
			<td align=center><%= rs.getString("name")%></td>
			<td align=center><%= rs.getString("id")%></td>
			<td align=center><%= rs.getString("pid")%></td>
			<td align=center><%= rs.getString("pdate")%></td>
		</tr>
		
<% }%>	
</table>
<%
if(pageno>=pidnum){
	pageno=pidnum;
}
%>
<h3> 共 <%=pidnum %>页，第<%=pageno %> 页    
 <a href='tabflat.jsp?pageno=<%=pageno-1%>'>上一页</a>
 <a href="tabflat.jsp?pageno=<%=pageno+1>pidnum?pidnum:pageno+1%>">下一页</a></h3>
 <form name="form2" action="tabflat.jsp">
   <input type="text" size = "8" name="pageno2" value=<%=pageno%>>
   <input name="submit" type="submit" value = "Go">
 </form>
 <form name="form1" action="tabflat.jsp">
 <select name="pageno" onChange="document.form1.submit()">
 <%for(int i=1;i<=pidnum;i++){
 %>
 <option value='<%= i%>' <%=i==pageno?"selected":" " %>>第  <%= i%> 页
 <% }%>
 </select>
 </form>
 <% rs.close();
	rs2.close();
	sm.close();
	sm2.close();
	conn.close();
	%>

</body>
</html>