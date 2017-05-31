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

public class CountryACDataSource {

    private static CountryACDataSource ds = null;
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost/ILGAS";
    private static final String USER = "root";
    private static final String PASS = "ankh573";

    public CountryACDataSource() {

    }

    public static CountryACDataSource getInstance() {
        if (ds == null) {
            ds = new CountryACDataSource();
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
            String query = "SELECT nicename, iso  from country";
            preStatement = conn.prepareStatement(query);
            resultSet = preStatement.executeQuery(query);
            while (resultSet.next()) {
                CategoryList.add(resultSet.getString(1));
                CategoryList.add(resultSet.getString(2));
            }
            resultSet.close();
            preStatement.close();
            conn.close();

        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(CountryACDataSource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return CategoryList;
    }

}
