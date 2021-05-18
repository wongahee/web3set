<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
   String DRV = "org.mariadb.jdbc.Driver";
   String URL = "";
   String USR = "playground";
   String PWD = "bigdata2020";

   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;

   String sql = " select count(userid) cnt from member where userid = ?";
   StringBuffer sb = new StringBuffer();

   try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("uid"));

        rs = pstmt.executeQuery();
        if (rs.next()){
            int cnt = rs.getInt(1);
            if (cnt > 0) sb.append("yes");
            else sb.append("no");
        }
   } catch(Exception ex) {
        ex.printStackTrace();
   } finally{
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
    }
    out.write(sb.toString());
%>
