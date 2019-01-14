<%@page pageEncoding="UTF-8" %>
<%@page import="java.sql.*,java.util.*,com.bbs.www.*" %>

<%
 session.removeAttribute("login");
 session.invalidate();
 out.print("<script>alert('用户即将退出，确定后退出该页面。');window.location.href='index.jsp'</script>"); %> 


 %>
 
