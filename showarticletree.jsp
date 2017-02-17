<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=root";
Connection conn = DriverManager.getConnection(url);
Statement sm = conn.createStatement();
ResultSet rs = sm.executeQuery("select * from article");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>articletree</title>
</head>
<body>
<table border = "1">
<%
while(rs.next()){
%>
<tr>
	<td>
		<%= rs.getInt("id") %>
		<%= rs.getString("title") %>
	</td>
</tr>
<%
}
%>
</table>
</body>
<% 
rs.close();
sm.close();
conn.close();
%>
</html>