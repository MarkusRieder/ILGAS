package ie.irishliterature.service;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginService {

    public String[] loginCheck(String username, String password) {
        System.out.println("LoginService username before : " + username);
        boolean login;
        boolean LogonPassed;
        String[] reply = new String[9];

        try {
            //loading drivers for mysql
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database 
            Connection conn = DriverManager.getConnection("jdbc:mysql://www.literatureirelandgrantapplication.com:3306/ILGAS", "markus", "ankh573");
            PreparedStatement pst = conn.prepareStatement("Select userID, uname, lastLogon, first_name, last_name,password,email,function,role  FROM ILGAS.users WHERE uname=? AND password=?");

            pst.setString(1, username);
            pst.setString(2, password);

//            System.out.println("username  loginCheck: " + username);
//            System.out.println("password: loginCheck  " + password);

            ResultSet rs = pst.executeQuery();

//            System.out.println("ResultSet: loginCheck  " + rs);

            login = rs.first();
//            System.out.println("ResultSet: loginCheck login " + login);

            //    String strLogin = 
//            System.out.println("userID: " + rs.getString("userID"));
//            System.out.println("role: " + rs.getString("role"));
//            System.out.println("function: " + rs.getString("function"));
//            System.out.println("firstname: 0: " + rs.getString("first_name"));
//            System.out.println("lastname: 0: " + rs.getString("last_name"));
//            System.out.println("email: 0: " + rs.getString("email"));
            // build full name
            String name = rs.getString("first_name") + " " + rs.getString("last_name");
            
            boolean loginSuccess = login;
//            System.out.println("SUCCESS " + Boolean.toString(loginSuccess));
            
            LogonPassed = true;

//            https://www.javaworld.com/article/2072937/java-web-development/solving-the-logout-problem-properly-and-elegantly.html?page=2
//            Solving the logout problem properly and elegantly

//            long lastLogonDB = rs.getLong("lastLogon");
//            if ((lastLogonForm > lastLogonDB) && (login == true)) {
//                // set LogonPassed = true and update lastLogon in users table
//                LogonPassed = true;
//                String updateTableSQL = ("update users set lastLogon= " + lastLogonForm + " where uname = '" + username + "'");
//                pst = conn.prepareStatement(updateTableSQL);
//                pst.executeUpdate();
//
//            } else {
//                LogonPassed = false;
//            }
            
            //We send reply back to LoginServlet
            //There the redirects will be performed
            reply[0] = Boolean.toString(login);
            reply[1] = rs.getString("role");
            reply[2] = rs.getString("function");
            reply[3] = rs.getString("first_name");
            reply[4] = rs.getString("last_name");
            reply[5] = name;
            reply[6] = rs.getString("email");
            reply[7] = rs.getString("userID");
            reply[8] = Boolean.toString(LogonPassed);

//            System.out.println("reply " + Arrays.toString(reply));

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reply;
    }
}
