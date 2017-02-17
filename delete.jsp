<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.sql.*" %>
         <% String admin = (String )session.getAttribute("admin");
    	if (admin==null||!"true".equals(admin)){
    		out.println("error!!!");
    		return;
    	}
    %>
<%!
private void delete(Connection conn, int id){
	Statement sm= null;
	ResultSet rs = null;
	try{
		 sm= conn.createStatement();
		 rs= sm.executeQuery("select * from article where pid="+id);
		while(rs.next()){
			delete(conn, rs.getInt("id"));
			}
		sm.executeUpdate("delete from article where id="+id);
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		try{
		rs.close();
		sm.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
}
%>   
   
<% 
//<jsp:useBean id="admin" class="java.lang.String" scope="session" />  
int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
Connection conn = DriverManager.getConnection(url);
conn.setAutoCommit(false);
Statement sm= conn.createStatement();
//sm.executeUpdate("delete from article where id in (11,18,19)");
delete(conn,id);
ResultSet rs =sm.executeQuery("select count(*) from article where pid="+pid);
rs.next();
int a = rs.getInt(1);
rs.close();
sm.close();
if(a==0){
	Statement sm2= conn.createStatement();
	sm2.executeUpdate("update article set isleaf=0 where id="+pid);
	sm2.close();
}
conn.commit();
conn.setAutoCommit(true);
conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>delete</title>
</head>
<body>
<%response.sendRedirect("tabtree.jsp"); %>
</body>
</html>