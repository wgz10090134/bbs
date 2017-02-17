<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.sql.*" %>
    <%
    String action = request.getParameter("action");
    String username= (String )session.getAttribute("name");
    if(action!=null&&action.equals("post")){
    	String title = request.getParameter("title");
    	String cont = request.getParameter("cont");
	    Class.forName("com.mysql.jdbc.Driver");
	    String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
	    Connection conn = DriverManager.getConnection(url);
	    conn.setAutoCommit(false);

	    PreparedStatement ps = conn.prepareStatement("insert into article values"+
	    	"(null,0,?,?,?,now(),0,?)",Statement.RETURN_GENERATED_KEYS);
	    ps.setInt(1, -1);
	    ps.setString(2, title);
	    ps.setString(3, cont);
	    ps.setString(4, username);
	    ps.executeUpdate();
	    ResultSet rskey = ps.getGeneratedKeys();
	    rskey.next();
	    int key = rskey.getInt(1);
	    rskey.close();
	    Statement  sm = conn.createStatement();
	    sm.executeUpdate("update article set rootid= "+key+ " where id= " +key);
	    conn.commit();
	    conn.setAutoCommit(true);

	    sm.close();
	    ps.close();
	    conn.close();
	    	response.sendRedirect("tabflat.jsp");
}
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>newobj</title>
</head>
<body>
<form action="newobj.jsp" method="post">
	<input type="hidden" name="action" value="post">
	<input type="hidden" name="tf" value='<%=request.getParameter("tf")%>'>
<table border="1">
<tr>
	<td>
		主题：<input type="text" name="title" size="50">
	</td>
</tr>
<tr>
	<td>
		<textarea name="cont" cols="60" rows="10"></textarea>
	</td>
</tr>
<tr>
	<td>
		<input type="submit"  value="提交">
	</td>
</tr>
</table>
</form>
</body>
</html>