<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <% String admin = (String )session.getAttribute("admin");
    	if (admin!=null&&"true".equals(admin)){
    		login = true;
    	}
    %>
<%!
String sb ="";
boolean login = false;
private void showtree(Connection conn, int id, int level){
	String presb ="";
	Statement sm= null;
	ResultSet rs = null;
	for(int i = 0;i<level;i++){
		presb+="**";
	}
	try{
		 sm= conn.createStatement();
		 String str = "select * from article where pid ="+id;
		 rs= sm.executeQuery(str);
		 String strlog ="";
		while(rs.next()){
			if(login){
				strlog ="<td><a href='delete.jsp?id="+rs.getInt("id")+
						"&pid="+rs.getInt("pid")+"'>删除</a></td>";
			}
				sb += "<tr><td>"+rs.getInt("id")+"</td><td>"+
				presb+"<a href='detail.jsp?tf=tree&id="+rs.getInt("id")+"'>"+
				rs.getString("title")+"</a>"+"</td>"+strlog
					+"</tr>";
			if(rs.getInt("isleaf")!=0){
				showtree(conn, rs.getInt("id"),level+1);
			}
		}
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
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
	Connection conn = DriverManager.getConnection(url);
	Statement  sm = conn.createStatement();
	 ResultSet rs = sm.executeQuery("select * from article where pid=0");
	 String strlog="";
	while(rs.next()){
		 if(login){
				strlog ="<td><a href='delete.jsp?id="+rs.getInt("id")+"&pid="+rs.getInt("pid")+
							"'>删除</a></td>";
				 }
		sb+="<tr><td>"+rs.getInt("id")+"</td><td>"+
	"<a href='detail.jsp?id="+rs.getInt("id")+"'>"+rs.getString("title")+
	"</a></td>"+
	strlog +"</tr>";
		if(rs.getInt("isleaf")!=0){
			showtree(conn,rs.getInt("id"),1);
		}
	}
	rs.close();
	sm.close();
	conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tabtree</title>
</head>
<body>
  <form action="tabflat.jsp">
     <input type="submit" value="返回主页 ">
</form>
<br/>
<table border="1">
<%= sb%>
<% sb="";
login=false;%>
</table>
</body>
</html>