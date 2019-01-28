<%-- 
    Document   : checkusername
    Created on : 03-Mar-2017, 21:37:19
    Author     : markus
:
    Checks if username is already in database
--%>

<%@ page import="java.io.*,java.sql.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String uname = request.getParameter("uname");

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://www.literatureirelandgrantapplication.com:3306/ILGAS", "markus", "ankh573");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from ILGAS.users where uname='" + uname + "'");  // this is for name
    if (rs.next()) {
        out.println("<font color=red>");
        out.println("Username already exists");
        out.println("</font>");

    } else {
//        out.println("<font color=green>");
//        out.println("Available");
//        out.println("</font>");

    }
    rs.close();
    st.close();
    con.close();
%> 