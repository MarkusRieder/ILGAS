/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static java.nio.charset.StandardCharsets.*;

/**
 *
 * @author markus
 */
public class CSVReader {

    static String Translator;
    static int TranslatorID;

    public static void main(String[] args) throws DBException, SQLException {

        String csvFile1 = "/home/markus/NetBeansProjects/testupload.csv";
        String csvFile2 = "/home/markus/NetBeansProjects/Untitled 2.csv";
        String csvFile3 = "/home/markus/NetBeansProjects/Author1.csv";
        String line = "";
        String cvsSplitBy = ",";
        int counter = 1;
        int z = 1;

        try (BufferedReader br2 = new BufferedReader(new FileReader(csvFile3))) {

            while ((line = br2.readLine()) != null) {

//                add FullName to A_Author
//ID,Name
                String[] AuthorArray = line.split(cvsSplitBy);

//int id = Integer.parseInt(AuthorArray[0]);
                String id = AuthorArray[0];

//int ID = Integer.parseInt(id);
                String Fullname = AuthorArray[1];

              //  String Name = Fullname.substring(1, Fullname.length() - 1);

                System.out.println("id:  " + id + ", Name:  " + Fullname);

                updateAuthor(id, Fullname);

                String[] TranslatorNames = line.split(cvsSplitBy);

                String TranslatorName = TranslatorNames[0];

                String Translator2 = TranslatorName.substring(1, TranslatorName.length() - 1);

//                byte[] ptext = TranslatorName.getBytes("Windows-1252");
//                String value = new String(ptext, utf8mb4);
                if ("" != Translator2) {

                    Translator2 = Translator2.replaceAll("  ", " ");

//                    insertTranslator(Translator2);
//                    System.out.println(counter + " :: [TranslatorName= " + Translator2);
                } else {
//                    System.out.println(counter + " :: [TranslatorName= " + Translator2);

                }
                counter++;
            }

        } catch (IOException e) {
        }

        try (BufferedReader br = new BufferedReader(new FileReader(csvFile1))) {
            counter = 1;
            while ((line = br.readLine()) != null) {

                // use comma as separator
                String[] country = line.split(cvsSplitBy);

                String RefNo = country[0];
                String Author = country[1];
                String Title = country[2];
                String Translator = country[3];

//                remove quotes
                String RefNo2 = RefNo.substring(1, RefNo.length() - 1);
                String Author2 = Author.substring(1, Author.length() - 1);
                String Title2 = Title.substring(1, Title.length() - 1);
                String Translator2 = Translator.substring(1, Translator.length() - 1);

//                byte[] ptext = Translator2.getBytes(ISO_8859_1);
//                String value = new String(ptext, UTF_8);
                Translator2 = Translator2.replaceAll("  ", " ");
                Title2 = Title2.replaceAll(",", "-");

//                TranslatorID = findTranslator(Translator2);
                if (0 != TranslatorID) {
//                    insertRow(RefNo2, Author2, Title2, Translator2, TranslatorID);
                } else {
//                    System.out.println(" No: " + z + " counter: " + counter + " :: [RefNo= " + country[0] + " , Author=" + country[1] + " , Title=" + Title2 + " , Translator=" + country[3] + ", TranslatorID=" + TranslatorID + "]");

                    z++;
                }
                //   public static String insertRow(String RefNo, String Author, String Title, String Translator, String TranslatorID) throws DBException 
                counter++;
            }

        } catch (IOException e) {
        }

    }

    public static int findTranslator(String translator) throws SQLException, DBException {

        Connection conn = null;
        int TransID = 0;
        String Name = "";

        try {

            conn = DBConn.getConnection();

            String selectSQL = "SELECT idTranslator, Name FROM Translator WHERE Name = ? ";

            PreparedStatement preparedStatement = conn.prepareStatement(selectSQL);
            preparedStatement.setString(1, translator);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                TransID = rs.getInt("idTranslator");
                Name = rs.getString("Name");

                if (TransID == 0) {

//                System.out.println("Name:  " + Name + " ::  translator " + translator);
                }
            }

            DBConn.close(conn, preparedStatement, rs);

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
            throw new DBException("1 Excepion while accessing database");
        }

        if (TransID == 0) {

//                System.out.println("Name:  " + Name + " ::  translator " + translator);
        }

        return TransID;
    }

    //  System.out.println(counter + " :: [RefNo= " + country[0] + " , Author=" + country[1] + " , Title=" + country[2] + " , Translator=" + country[3] + ", TranslatorID=" + TranslatorID + "]");
    public static String insertRow(String RefNo, String Author, String Title, String Translator, int TranslatorID) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        String id = null;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("insert into TranslatorTrack (idTranslator, Author, Title, ReferenceNumber) values (?,?,?,?)");
            ps1.setInt(1, TranslatorID);
            ps1.setString(2, Author);
            ps1.setString(3, Title);
            ps1.setString(4, RefNo);

            ps1.executeUpdate();

            conn.commit();
            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
            throw new DBException("4 Excepion while accessing database");
        }

        return id;
    }

    public static String insertTranslator(String Name) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        String id = null;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("insert into Translator (Name) values (?)");
            ps1.setString(1, Name);

            ps1.executeUpdate();

            conn.commit();
            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
            throw new DBException("4 Excepion while accessing database");
        }

        return id;
    }

    public static int updateAuthor(String id, String Fullname) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int idx = 0;
  
        ResultSet res = null;

        try {

            idx = Integer.parseInt(id);
            
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("UPDATE A_Author SET Name = ? where ID = ?");

            ps1.setString(1, Fullname);
            ps1.setString(2, id);

            ps1.executeUpdate();

            System.out.println("Updating id: " + id + " FullName: " + Fullname);

            conn.commit();
            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e.getMessage());
            throw new DBException("4 Excepion while accessing database");
        }

        return idx;
    }
}
