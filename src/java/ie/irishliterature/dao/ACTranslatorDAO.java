/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;

import ie.irishliterature.model.ACtranslator;
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
public class ACTranslatorDAO {

    public ArrayList getTranslators(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        ArrayList translatorList = new ArrayList();
        Database db = new Database();
        Connection connection = db.getConnection();

        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * from ILGAS.Translator WHERE Name  like ?");
            ps.setString(1, "%" + s + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ACtranslator translator = new ACtranslator();
                translator.setId(rs.getString("idTranslator"));
                translator.setValue(rs.getString("Name"));

                System.out.println("translator.setId : " + rs.getString("idTranslator"));
                System.out.println("translator.setValue : " + rs.getString("Name"));

                translatorList.add(translator);
            }
        } catch (SQLException e) {
        }

        return translatorList;
    }
}
