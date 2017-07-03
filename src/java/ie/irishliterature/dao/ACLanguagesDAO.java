/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;

import ie.irishliterature.model.AClanguages;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author markus
 */

@SuppressWarnings("unchecked")
public class ACLanguagesDAO {
    
     public ArrayList getLanguage(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        ArrayList languageList = new ArrayList();
        Database db = new Database();
        Connection connection = db.getConnection();

        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * from Languages WHERE lang  like ?");
            ps.setString(1, "%" + s + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AClanguages language = new AClanguages();
                language.setId(rs.getString("id"));
                language.setValue(rs.getString("lang"));

                System.out.println("language.setId : " + rs.getString("id"));
                System.out.println("language.setValue : " + rs.getString("lang"));

                languageList.add(language);
            }
        } catch (SQLException e) {
        }
        return languageList;
    }
    
}
