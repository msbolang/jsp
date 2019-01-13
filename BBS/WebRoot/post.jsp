<%@page pageEncoding="UTF-8" %>
<%@page import="java.sql.*,java.util.*,com.bbs.www.*" %>


<%
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	
	if(action!=null && action.trim().equals("POST")) {
		
		String title  = request.getParameter("title");
		String content = request.getParameter("content");

  		 int pid = 0;
   
		Connection conn = DB.getConn();
		
		//创建事务开始
		boolean autoCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
		int rootID = -1;
		//插入此数据到article表
 		String sql = "insert into article values (null,?, ?, ?, ?, now(), ?)";
		PreparedStatement pstmt = DB.prepareStmt(conn, sql, 1);
		pstmt.setInt(1, 0);
		pstmt.setInt(2,rootID);
		pstmt.setString(3,title);
		pstmt.setString(4,content);
		pstmt.setInt(5,0);
		pstmt.executeUpdate();
		
		ResultSet res = pstmt.getGeneratedKeys();
		res.next();
		int rid = res.getInt(1);

		Statement stmt = DB.getStmt(conn);
		stmt.executeUpdate("update article set rootid = " + rid + " where id = " + rid);

		//提交事务
		conn.commit();
		conn.setAutoCommit(autoCommit);
		
		DB.close(pstmt);
		
	    DB.close(conn);
	 response.setHeader("Refresh","0;url=http://localhost:8080/BBS/index.jsp");
	 }
	    

 %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>回复</title>
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
        <td width="99%"><p class="jive-breadcrumbs"> <a href="article.jsp">首页</a> &#187; <a href="forumindex.jspa?categoryID=1">ChinaJavaWorld技术论坛|Java世界_中文论坛</a> &#187; <a href="category.jspa?categoryID=2">Java 2 Platform, Standard Edition (J2SE)</a> &#187; <a href="forum.jspa?forumID=20&amp;start=0">Java语言*初级版</a> </p>
          <p class="jive-page-title">  </p></td>
        <td width="1%"><div class="jive-accountbox"></div></td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><img src="images/reply-16x16.gif" alt="回复本主题" border="0" height="16" width="16"></td>
          <td class="jive-icon-label"> </td>
        </tr>
      </tbody>
    </table>
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
                   <form action="" method="POST">
                  
                   <input type="hidden" name="action" value="POST" />
                
					  <p> name: <input type="text" name="title" /></p>
					<textarea  id="editor" name="content"></textarea>	
					  
					  <input type="submit" value="Submit" />
				</form>
                    </tbody>
                  </table>
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

<script src="ckeditor5/ckeditor.js"></script>

<script>
	ClassicEditor
		.create( document.querySelector( '#editor' ), {
			// toolbar: [ 'heading', '|', 'bold', 'italic', 'link' ]
		} )
		.then( editor => {
			window.editor = editor;
		} )
		.catch( err => {
			console.error( err.stack );
		} );
</script>

</body>
</html>
