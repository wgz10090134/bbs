<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
int pid = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
int pageno = Integer.parseInt(request.getParameter("pageno"));
String title = request.getParameter("title");
String cont = request.getParameter("cont");
//cont.replaceAll("\n", "<br>");
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
Connection conn = DriverManager.getConnection(url);
conn.setAutoCommit(false);
Statement  sm = conn.createStatement();
sm.executeUpdate("update article set isleaf=1 where id="+
		pid);
PreparedStatement ps = conn.prepareStatement("insert into article values"+
	"(null,?,?,?,?,now(),0)");
ps.setInt(1, pid);
ps.setInt(2, rootid);
ps.setString(3, title);
ps.setString(4, cont);
ps.executeUpdate();
conn.commit();
conn.setAutoCommit(true);
sm.close();
ps.close();
conn.close();
response.sendRedirect("detail.jsp?id="+pid+"&pageno="+pageno);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>replyok</title>
</head>
<body>

</body>
</html>