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

   String sql = "select distinct dong from zipcode where sido = ? and gugun = ?";
   StringBuffer sb = new StringBuffer();

   try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("sido"));
        pstmt.setString(2, request.getParameter("gugun"));

        rs = pstmt.executeQuery();
        while (rs.next()){
            String dong = rs.getString(1);
            sb.append(dong).append(',');
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
<!--
웹사이트에 목록조회
http://localhost:8080/dong.jsp?sido=서울&gugun=강남구 -->
