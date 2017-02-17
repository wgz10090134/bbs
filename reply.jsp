<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    int id = Integer.parseInt(request.getParameter("id"));
    int rootid = Integer.parseInt(request.getParameter("rootid"));
    int pageno=Integer.parseInt(request.getParameter("pageno"));
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reply</title>
</head>
<body>
<form action='replyok.jsp?id=<%=id %>&rootid=<%=rootid %>&pageno=<%=pageno %>' method="post">
<input type="hidden" name="id" value="<%= id%>">
<input type="hidden" name="rootid" value="<%= rootid%>">
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