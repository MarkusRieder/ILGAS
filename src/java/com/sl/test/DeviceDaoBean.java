package com.sl.test;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.model.Library;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author markus
 */
public class DeviceDaoBean {

    static DBConn ds = new DBConn();
    static Connection currentCon = null;
    static ResultSet rs = null;

    public static ArrayList getAllBooks() throws ClassNotFoundException {
        Statement stmt = null;

        String searchQuery = "select * from Books";
        ArrayList listLibrary = new ArrayList();

        try {
            currentCon = ds.getConnection();
            stmt = currentCon.createStatement();

            rs = stmt.executeQuery(searchQuery);

            while (rs.next()) {
                Library library = new Library();

                library.setBookID(rs.getInt("BookID"));
                library.setReferenceNumber(rs.getString("referenceNumber"));
                library.setAuthor(rs.getString("Author"));
                library.setTitle(rs.getString("Title"));
//                library.setPublisher(rs.getString("Publisher"));
                library.setPublishingYear(rs.getString("publisherYear"));
                library.setGenre(rs.getString("Genre"));
                library.setTranslationTitle(rs.getString("translationTitle"));
//                library.setTranslationPublisher(rs.getString("translationPublisher"));
                library.setTranslationPublisherYear(rs.getString("translationPublisherYear"));
                library.setTranslator(rs.getString("Translator"));
                library.setLanguage(rs.getString("Language"));
                library.setPhysicalDescription(rs.getString("physicalDescription"));
                library.setDuplicates(rs.getInt("Duplicates"));
                library.setCopies(rs.getString("Copies"));
                library.setNotes(rs.getString("Notes"));
                library.setISBN(rs.getString("ISBN"));
                library.setISSN(rs.getString("ISSN"));

                listLibrary.add(library);
            }

            ds.close(currentCon, stmt);
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return listLibrary;
    }
}
