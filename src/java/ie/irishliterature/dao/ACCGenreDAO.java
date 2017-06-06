/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ie.irishliterature.model.ACgenre;
/**
 *
 * @author markus
 *
 * AC = autocomplete
 *
 */
@SuppressWarnings("unchecked")
public class ACCGenreDAO {

    public ArrayList getGenre(String s) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        ArrayList genreList = new ArrayList();
        Database db = new Database();
        Connection connection = db.getConnection();

        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * from genres WHERE genres  like ?");
            ps.setString(1, "%" + s + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ACgenre genre = new ACgenre();
                genre.setId(rs.getString("idgenres"));
                genre.setValue(rs.getString("genres"));

                System.out.println("genre.setId : " + rs.getString("idgenres"));
                System.out.println("genre.setValue : " + rs.getString("genres"));

                genreList.add(genre);
            }
        } catch (SQLException e) {
        }
        return genreList;
    }

}
