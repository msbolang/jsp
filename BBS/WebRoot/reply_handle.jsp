<%@page pageEncoding="UTF-8" %>
<%@page import="java.sql.*,java.util.*,com.bbs.www.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String title  = request.getParameter("title");
	String content = request.getParameter("content");
	String ID = request.getParameter("id");
    String PID = request.getParameter("pid");
	if(ID==null || ID.trim().equals("")) {
		out.println("id error");
		return;
	}
   int id = Integer.parseInt(ID);

	if(PID==null || PID.trim().equals("")) {
		out.println("id error");
		return;
	}
   int pid = Integer.parseInt(PID);
   
		Connection conn = DB.getConn();
		
		//创建事务开始
	//	boolean autoCommit = conn.getAutoCommit();
	//	conn.setAutoCommit(false);
		
		//插入此数据到article表
 		String sql = "insert into article values (null,?, ?, ?, ?, now(), ?)";
		PreparedStatement pstmt = DB.prepareStmt(conn, sql);
		pstmt.setInt(1, id);
		pstmt.setInt(2,id);
		pstmt.setString(3,title);
		pstmt.setString(4,content);
		pstmt.setInt(5,0);
		pstmt.executeUpdate();
		
		//更新此条数据为留言
		Statement stmt = DB.getStmt(conn);
		int OK = stmt.executeUpdate("update article set isleaf = 1 where id = " + id);
		//提交事务
	//	conn.commit();
	//	conn.setAutoCommit(autoCommit);
		
		DB.close(pstmt);
		DB.close(stmt);
	    DB.close(conn);
	    
	    

 %>
 
 回复成功了！！！！！！
<%  
  //   response.sendRedirect("http://localhost:8080/BBS/article_detail.jsp?id="+id);
	 response.setHeader("Refresh","2;url=http://localhost:8080/BBS/index.jsp");
%>