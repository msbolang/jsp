<%@page pageEncoding="UTF-8" %>
<%@page import="java.sql.*,java.util.*,com.bbs.www.*" %>

<%
	String action = request.getParameter("action");
    boolean message=false;
	if(action!=null && action.trim().equals("post")) {
		 String username = request.getParameter("username");
	     String password = request.getParameter("password");
	     
	     if(username!=null && username.trim().equals("admin")) {
	          if(password!=null && password.trim().equals("123456")) {
	          	 session.setAttribute("login","ok");
	          	 response.setHeader("Refresh","0;url=http://localhost:8080/BBS/index.jsp");
	          }else{
	          	message = true;
	          }
	        
	     }else{
	     	message = true;
	     }
	     
	}
//   int id = Integer.parseInt(ID);
 String showMessage = "";
	if(message) {
	  showMessage = "账号或密码错误";
	}
 %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>login</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="rss/rssmessages.jspa?threadID=744236">
<link href="ckeditor5/sample/css/sample.css" rel="stylesheet" type="text/css" />
	<style>
	.ck-editor__editable {
    min-height: 300px;
}
	</style>
	
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>

    <tr>
      <td width="140"><a href="index.jspa"><img src="images/header-left.gif" alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
      <td><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%"></td>
      <td width="1%"><img src="images/header-right.gif" alt="" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-flatpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><p class="jive-breadcrumbs"> <a href="index.jspa">首页</a> &#187; <a href="forumindex.jspa?categoryID=1">ChinaJavaWorld技术论坛|Java世界_中文论坛</a> &#187; <a href="category.jspa?categoryID=2">Java 2 Platform, Standard Edition (J2SE)</a> &#187; <a href="forum.jspa?forumID=20&amp;start=0">Java语言*初级版</a> </p>
          <p class="jive-page-title">  </p></td>
        <td width="1%"><div class="jive-accountbox"></div></td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">

  </div>
  <br>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div id="jive-message-holder">
            <div class="jive-message-list">
              <div class="jive-table">
                <div class="jive-messagebox">
                  <table summary="Message" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
		                  <form action="" method="post">
		            			<input type="hidden" name="action" value="post" />
							  <p> name: <input type="text" name="username" /></p>
							 <p> passwod: <input type="text" name="password" /></p>
							  
							  <input type="submit" value="Submit" />
						</form>
                    </tbody>
                  </table>
   
      <%=showMessage %>
 
                </div>
              </div>
            </div>
            <div class="jive-message-list-footer">
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="nowrap" width="1%"></td>
                    <td align="center" width="98%"><table border="0" cellpadding="0" cellspacing="0">
                        <tbody>
                          <tr>
                            <td><a href="forum.jspa?forumID=20"><img src="images/arrow-left-16x16.gif" alt="返回到主题列表" border="0" height="16" hspace="6" width="16"></a> </td>
                            <td><a href="forum.jspa?forumID=20">返回到主题列表</a> </td>
                          </tr>
                        </tbody>
                      </table></td>
                    <td nowrap="nowrap" width="1%">&nbsp;</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div></td>
        <td width="1%"></td>
      </tr>
    </tbody>
  </table>
</div>

</body>
</html>
