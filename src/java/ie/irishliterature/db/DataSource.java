/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.db;

/**
 *
 * @author markus
 */
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

public class DataSource {

    private static DataSource ds = null;
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost/ILGAS";
    private static final String USER = "root";
    private static final String PASS = "ankh573";

    public DataSource() {

    }

    public static DataSource getInstance() {
        if (ds == null) {
            ds = new DataSource();
        }
        return ds;
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            try {
                conn.close();
            } catch (SQLException e1) {
            }
        }
        return conn;
    }

    public static List GetCategoryList(String Keyword) throws SQLException {
        List<String> CategoryList = new ArrayList<>();
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = (Connection) DriverManager.getConnection(DB_URL, USER, PASS);
            PreparedStatement preStatement;
            ResultSet resultSet;
//            String query = "SELECT Company, Company_Number FROM international_publishers";
            String query = "SELECT * FROM international_publishers";
            preStatement = conn.prepareStatement(query);
            resultSet = preStatement.executeQuery(query);
            while (resultSet.next()) {
                CategoryList.add(resultSet.getString(1));
                CategoryList.add(resultSet.getString(2));
                CategoryList.add(resultSet.getString(3));
                CategoryList.add(resultSet.getString(4));
                CategoryList.add(resultSet.getString(5));
                CategoryList.add(resultSet.getString(6));
                CategoryList.add(resultSet.getString(7));
                CategoryList.add(resultSet.getString(8));
                CategoryList.add(resultSet.getString(9));
                CategoryList.add(resultSet.getString(10));
                CategoryList.add(resultSet.getString(11));
                CategoryList.add(resultSet.getString(12));
                CategoryList.add(resultSet.getString(13));
                CategoryList.add(resultSet.getString(14));
                CategoryList.add(resultSet.getString(15));
            }
            resultSet.close();
            preStatement.close();
            conn.close();

        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(DataSource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return CategoryList;
    }

}
