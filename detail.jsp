<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.* , java.util.*" %>
<%
String s = request.getParameter("id");
int id = Integer.parseInt(s);
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?useSSL=true&user=root&password=root";
Connection conn = DriverManager.getConnection(url);
Statement  sm1 = conn.createStatement();
ResultSet  rs1 = sm1.executeQuery("select * from article where id="+id);
rs1.next();
childnum.add(id);
showtree(conn,id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>detail</title>
<style type="text/css">
<!--
.STYLE4 {
	font-size: 24px;
	font-weight: bold;
}
.STYLE5 {
	font-size: 36px;
	font-weight: bold;
	color: #FF0000;
}
-->
</style>
</head>
<body>
<br />
<%!
ArrayList <Integer>childnum = new ArrayList<Integer>();
private void showtree(Connection conn, int id){
	Statement sm= null;
	ResultSet rs = null;
	try{
		 sm= conn.createStatement();
		 String str = "select * from article where pid ="+id;
		 rs= sm.executeQuery(str);
		while(rs.next()){
			childnum.add(rs.getInt("id"));
			if(rs.getInt("isleaf")!=0){
				showtree(conn, rs.getInt("id"));
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
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="80%"  height="57" background="images/header-stretch.gif" bgcolor="#F0F0F0" class="STYLE4" ><div align="center"><span class="STYLE5">welcome to bbs!</span></div></td>
      <td width="20%"><img src="images/header-right.gif"  height="57" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-flatpage">
  <table width="100%" border="1" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
    <tbody>
      <tr valign="top">
        <td width="99%"><p class="jive-breadcrumbs"> <a href='tabflat.jsp?pageno=<%=request.getParameter("pageno")%>'><strong>首页</strong></a> &#187; 
        <a href='detail.jsp?id=<%=id%>&pageno=<%=request.getParameter("pageno")%>'>
        <%= rs1.getString("title")%></a></td>
	  </tr>
          <tr><td bgcolor="#FF00FF"> <span class="STYLE4">主题</span>: </td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="100%"><div id="jive-message-holder">
<%
for(int i = 0;i<childnum.size();i++){
	Statement  sm = conn.createStatement();
	 ResultSet rs = sm.executeQuery("select * from article where id="+childnum.get(i));
	 rs.next();
				 %>
            <div class="jive-message-list">
              <div class="jive-table">
                <div class="jive-messagebox">
				
				<!-- start -->
				<table summary="Message" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr id="jive-message-780144" class="jive-odd" valign="top">
                        <td class="jive-first" width="1%">
						<!-- 个人信息的table -->
						<table width="150" height="186" border="0" cellpadding="0" cellspacing="0">
                            <tbody>
                              <tr>
                                <td><img src="images/avatar-display.png" alt="" width="109" height="72" border="0" class="jive-avatar"> 
                                <span style="padding: 0px;">
                                </span><br>
                                  <span style="padding: 0px;">
                                  <%= rs.getString("name")%></a> 
                                  <img class="jive-status-level-image" src="images/level3.gif" title="世界新手" alt="" border="0">
                                  </span><br>
                                  <span class="jive-description"> 发表:
                                  34 <br>
                                  点数: 100<br>
                                  注册:
                                  07-5-10 <br>
              </span> </td>
                              </tr>
                            </tbody>
                          </table>
						  <!--个人信息table结束-->
						  
					    </td>
                        <td class="jive-last" width="99%"><table width="100%" height="185" border="0" cellpadding="0" cellspacing="0" bordercolor="#666666" bgcolor="#CCCCCC">
                            <tbody>
                              <tr valign="top">
                                <td width="100%" height="31" bordercolor="#FF0000" bgcolor="#00FF66"><strong>
                                <%= rs.getString("title")%></strong></td>
                              </tr>
                              <tr><td align="right">第 <%=i+1 %> 楼</td>
                              </tr>
                              <tr>
                                <td height="108" colspan="4" bordercolor="#666666" bgcolor="#CCCCCC" style="border-top: 1px solid rgb(204, 204, 204);"><div align="left"><br>
                                  <%= rs.getString("cont")%><br>
                                  <br>         
                                  </tr>
                              <tr> <td align="right"> <a href='reply.jsp?id=<%=id%>&rootid=<%= rs1.getInt("rootid")%>&pageno=<%=request.getParameter("pageno")%>'>
                              回复this</a></td>
                              </tr>
                              <tr>
                                <td colspan="4" bordercolor="#000000" bgcolor="#CCFFFF" style="font-size: 9pt;"><div align="left"><img src="images/sigline.gif"><br>
                                  <font color="#568ac2">学程序是枯燥的事情，愿大家在一起能从中得到快乐！</font> <br>                                
                                </div></td>
                              </tr>
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table>
				  
				  <!-- end -->
                </div>
              </div>
            </div>
			
		<%
}
		%>
            <div class="jive-message-list-footer">
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tbody>
                  <tr>
                    
                    <td align="center" width="100%"><table border="0" cellpadding="0" cellspacing="0">
                        <tbody>
                          <tr> 
						  <br />                        
                            <td><a href='tabflat.jsp?pageno=<%=request.getParameter("pageno")%>'>返回</a> </td>
                          </tr>
                        </tbody>
                      </table></td>
               
                  </tr>
                </tbody>
              </table>
            </div>
          </div></td>
        <td width="1%">&nbsp;</td>
      </tr>
    </tbody>
  </table>
</div>
</body>

<%
childnum.clear();
rs1.close();
sm1.close();
conn.close();
%>
</html>
