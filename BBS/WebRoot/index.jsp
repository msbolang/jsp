<%@page pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.io.*,  java.util.*, com.bbs.www.*" %>

<%!

private int scount(Connection conn) {
	    String sql = "select count(*) from article where pid=0";
		Statement stmt = DB.getStmt(conn);
		ResultSet rs = DB.executeQuery(stmt,sql);
		int count = 0;
		try {
			rs.next();
			count = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	
	}

	private void tree(List<Article> articles, Connection conn, int id, int grade, int start, int num) {
		String sql = "select * from article where pid = " + id + " order By id desc limit " + start + "," + num;
		Statement stmt = DB.getStmt(conn);
		ResultSet rs = DB.executeQuery(stmt, sql);
		try {
			while (rs.next()) {
				Article a = new Article();
				a.init(rs);
				a.setGrade(grade);
				articles.add(a);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(stmt);
			DB.close(rs);
		}

		Article a = new Article();
	}%>
 
 <%
 	String Page  = request.getParameter("page");
 	
 		int pages = 1; 
 		int count = 3; //显示数量
 		
		if(Page!=null && !Page.trim().equals("")) {
			pages = Integer.parseInt(Page);
			
		}
		
	    if(pages<1) {
			pages=1;
		}	
		System.out.println(pages);
		
		int start = 0;
		
		if(pages>1) {
			start = count*pages-count+1;
		}
	System.out.println(start);

 	List<Article> articles = new ArrayList<Article>();
 	Connection conn = DB.getConn();
 	tree(articles, conn, 0, 0, start, count);
 	int counts = scount(conn);
 	int endP = counts/count;
 
    DB.close(conn);
 	
 	
 	String url = request.getScheme() + "://";  //  http://
 	url += request.getServerName()+":";// http://www.domename.com:
 	url += request.getServerPort();// http://www.domename.com:80
 	url += request.getContextPath();// http://www.domename.com:80/bbs
	url += request.getServletPath();// http://www.domename.com:80/bbs/index.jsp
	url += request.getQueryString()==null?"":"&"+request.getQueryString();// http://www.domename.com:80/bbs/index.jsp&page=1

  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 : Java语言*初级版</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript" src="images/common.js"></script>
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
<div id="jive-forumpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="98%"><p class="jive-breadcrumbs">论坛: Java语言*初级版
            (模仿)</p>
          <p class="jive-description"> 探讨Java语言基础知识,基本语法等 大家一起交流 共同提高！谢绝任何形式的广告 </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="post%21default.jspa?forumID=20"><img src="images/post-16x16.gif" alt="发表新主题" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp">发表新主题</a> <a href="forum.jspa?forumID=20&amp;isBest=1"></a></td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td><span class="nobreak"> 页:
          1,316 - <span class="jive-paginator"> [ <a href="index.jsp?page=1">第一页</a> |  [ <a href="index.jsp?page=<%= pages-1 %>">上一页</a> | <a href="index.jsp?page=<%=pages+1 %>">下一页</a> ] | <a href="index.jsp?page=<%=endP %>">尾页</a> ]</span> </span> </td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div class="jive-thread-list">
            <div class="jive-table">
              <table summary="List of threads" cellpadding="0" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="jive-first" colspan="3"> 主题 </th>
                    <th class="jive-author"> <nobr> 作者
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> 浏览
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> 回复 </th>
                    <th class="jive-last" nowrap="nowrap"> 最新帖子 </th>
                  </tr>
                </thead>
                <tbody>
                <%
                for(Iterator<Article> it = articles.iterator(); it.hasNext(); ) {
                	Article a = it.next();
                 %>
                  <tr class="jive-even">
                  
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <td nowrap="nowrap" width="1%">&nbsp;
                      
                      <a href="delete.jsp?id=<%=a.getId() %>&from=<%=url %>">删除</a>
                      
                      
                      &nbsp;</td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-1" href="/BBS/index_detail.jsp?id=<%=a.getId()%>"><%=a.getTitle()%></a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="/profile.jspa?userID=226030">fei870407</a> </span></td>
                    <td class="jive-view-count" width="1%"> 104</td>
                    <td class="jive-msg-count" width="1%"> 5</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> <%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate()) %> <br>
                        by: <a href="/thread.jspa?messageID=780182#780182" title="jingjiangjun" style="">惺惺惜惺惺</a> </div></td>
                  </tr>
           <%--
                  <tr class="jive-odd">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                    
                      </div></td>
                    <td nowrap="nowrap" width="1%">&nbsp;&nbsp;</td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-2" href="/thread.jspa?threadID=744234&amp;tstart=25">请 兄弟们指点下那里 错误，，，</a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="/profile.jspa?userID=226028">403783154</a> </span></td>
                    <td class="jive-view-count" width="1%"> 52</td>
                    <td class="jive-msg-count" width="1%"> 2</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> 2007-9-13 上午8:40 <br>
                        by: <a href="thread.jspa?messageID=780172#780172" title="downing114" style="">downing114 &#187;</a> </div></td>
                  </tr>
           --%>
                <% } %>
                </tbody>
              </table>
            </div>
          </div>
          <div class="jive-legend"></div></td>
      </tr>
  
    </tbody>
  </table>
  <br>
  <br>
</div>
</body>
</html>
