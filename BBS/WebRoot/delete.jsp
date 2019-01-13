<%@page pageEncoding="UTF-8" %>
<%@page import="java.sql.*,java.util.*,com.bbs.www.*" %>
<%!
private void delete(int id) {
	Connection conn = DB.getConn();
	Statement stmt = DB.getStmt(conn);
	String sql = "DELETE FROM  article  where id = " + id;
    	
		try{
			 stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
	//		DB.close(stmt);
		//	DB.close(rs);
		}
}

   private void deleteArticle(int id) {
    	String sql = "select id from article where pid = " + id ;
    		Connection conn = DB.getConn();
    	Statement stmt = DB.getStmt(conn);
		try{
			ResultSet rs = DB.executeQuery(stmt, sql);
			while (rs.next()) {
			 int mid = rs.getInt(1);
			 System.out.println(mid);
			 System.out.println(mid);
			 delete(mid);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
	//		DB.close(stmt);
		//	DB.close(rs);
		}

    }
%>
<%
	request.setCharacterEncoding("UTF-8");
	String ID  = request.getParameter("id");
	String from = request.getParameter("from");
	from +=  request.getParameter("page")==null ? "" : "?page="+ request.getParameter("page");
	
	
	if(ID==null || ID.trim().equals("")) {
		out.println("id error");
		return;
	}
    int id = Integer.parseInt(ID);

	if(from==null || from.trim().equals("")) {
		out.println("from error");
		return;
	}
	
    
		Connection conn = DB.getConn();
		//创建事务开始
		boolean autoCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
			
		//更新此条数据为留言
		Statement stmt = DB.getStmt(conn);
		deleteArticle(id);
		stmt.executeUpdate("DELETE FROM  article  where id = " + id);
		//提交事务
		conn.commit();
		conn.setAutoCommit(autoCommit);
			
		DB.close(stmt);
	    DB.close(conn);   
 %>
 
删除成功了！！！！！！
<%  
	System.out.println(from);
	 response.setHeader("Refresh","0;url="+from);
%>