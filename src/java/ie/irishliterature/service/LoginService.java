package ie.irishliterature.service;

import java.sql.*;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginService {

    public String[] loginCheck(String username, String password) {
        System.out.println("LoginService username before : " + username);
        boolean login;
        String[] reply = new String[8];

        try {
            //loading drivers for mysql
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database 
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ILGAS", "root", "ankh573");
            PreparedStatement pst = conn.prepareStatement("Select userID, uname,first_name, last_name,password,email,function,role FROM users WHERE uname=? AND password=?");

            pst.setString(1, username);
            pst.setString(2, password);

            System.out.println("username  loginCheck: " + username);
            System.out.println("password: loginCheck  " + password);

            ResultSet rs = pst.executeQuery();

            System.out.println("ResultSet: loginCheck  " + rs);

            login = rs.first();

            //    String strLogin = 
            System.out.println("userID: " + rs.getString("userID"));
            System.out.println("role: " + rs.getString("role"));
            System.out.println("function: " + rs.getString("function"));
            System.out.println("firstname: 0: " + rs.getString("first_name"));
            System.out.println("lastname: 0: " + rs.getString("last_name"));
            System.out.println("email: 0: " + rs.getString("email"));

            // build full name
            String name = rs.getString("first_name") + " " + rs.getString("last_name");

            reply[0] = Boolean.toString(login);
            reply[1] = rs.getString("role");
            reply[2] = rs.getString("function");
            reply[3] = rs.getString("first_name");
            reply[4] = rs.getString("last_name");
            reply[5] = name;
            reply[6] = rs.getString("email");
            reply[7] = rs.getString("userID");

            System.out.println("reply " + Arrays.toString(reply));

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(LoginService.class.getName()).log(Level.SEVERE, null, ex);
        }

        return reply;
    }
}
