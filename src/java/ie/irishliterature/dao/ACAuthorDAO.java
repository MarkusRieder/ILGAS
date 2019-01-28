/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;


import ie.irishliterature.model.ACauthor;
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
public class ACAuthorDAO {
    
        public ArrayList getAuthors(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        ArrayList authorList = new ArrayList();
        Database db = new Database();
        Connection connection = db.getConnection();

        try {
            PreparedStatement ps = connection.prepareStatement("SELECT DISTINCT * from ILGAS.Author WHERE Name  like ?");
            ps.setString(1, "%" + s + "%");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ACauthor author = new ACauthor();
                author.setId(rs.getString("idAuthor"));
                author.setValue(rs.getString("Name"));

                System.out.println("author.setId : " + rs.getString("idAuthor"));
                System.out.println("author.setValue : " + rs.getString("Name"));

                authorList.add(author);
            }
        } catch (SQLException e) {
        }
        return authorList;
    }
}
