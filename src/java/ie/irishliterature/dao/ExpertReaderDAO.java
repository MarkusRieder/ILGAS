/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.dao;

import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.ExpertReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import org.apache.log4j.Logger;

/**
 *
 * @author markus
 */
public class ExpertReaderDAO {

    private static final Logger LOGGER = Logger.getLogger(ExpertReaderDAO.class.getName());

    public static int insertExpertReaderReport(String ReferenceNumber, java.sql.Date upDate, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            System.out.println("insertExpertReaderReport......................:");

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            System.out.println("ReferenceNumber: " + ReferenceNumber);
            System.out.println("moveFile: " + moveFileNameReplaced);

            String query = "UPDATE ILGAS.expertReader SET  fileDestination = ?, sampleReturned = ?, reading = ? WHERE ReferenceNumber = ?";
            ps1 = conn.prepareStatement(query);

            ps1.setString(1, moveFileNameReplaced);
            ps1.setDate(2, upDate);
            ps1.setString(3, "false");
            ps1.setString(4, ReferenceNumber);

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    id = res.getInt(1);
                    System.out.println("ExpertReaderDAO id::   " + id);
                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps1, ps2, res);
            throw new DBException("ExpertReaderDAO insertExpertReaderReport 4 Excepion while accessing database");
        }

        return id;
    }

    public static int insertExpertReaderInvoice(String ReferenceNumber, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            System.out.println("insertTranslationSample......................:");

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            System.out.println("ReferenceNumber: " + ReferenceNumber);
            System.out.println("moveFile: " + moveFileNameReplaced);

            String query = "UPDATE ILGAS.expertReader SET  invoicePath = ? WHERE ReferenceNumber = ?";
            ps1 = conn.prepareStatement(query);

            ps1.setString(1, moveFileNameReplaced);
            ps1.setString(2, ReferenceNumber);

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    id = res.getInt(1);
                    System.out.println("GrantApplicationDAO id::   " + id);
                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps1, ps2, res);
            throw new DBException("4 Excepion while accessing database");
        }

        return id;
    }
    
    
  //updateExpertReader
    public static boolean updateExpertReader(ExpertReader expertReader, String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed;
        ResultSet res = null;
      

        System.out.println("doing updatePublisher::  ");
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            java.sql.Timestamp timestamp = getcurrentTimeStamp();

            String sql = "UPDATE ILGAS.expertReader SET setSummaryReport = ?";
            sql += " WHERE ReferenceNumber = " + ReferenceNumber;

            ps1 = conn.prepareStatement(sql);

            ps1.setString(1, expertReader.getSummaryReport());                      

            System.out.println("ps1::  " + ps1);

            committed = ps1.executeUpdate();

            conn.commit();

            if (committed > 0) {
                id = true;
            } else {
                id = false;
            }

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            throw new DBException("updateExpertReader - 4 Excepion while accessing database");
        }

        return id;
    }
    public static List<ExpertReader> getExpertReaderOpenReadings(String userID) throws ClassNotFoundException, SQLException, DBException {

        List<ExpertReader> ExpertReaderOpenReadingsData = null;
        int counter = 1;
        if (ExpertReaderOpenReadingsData == null) {

            ExpertReaderOpenReadingsData = new LinkedList<>();
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet res = null;
            System.out.println("ExpertReaderDAO   here ");

            try {

                conn = DBConn.getConnection();

                ps = conn.prepareStatement("SELECT expertReaderUserID, expertReader.referenceNumber, sampleSentOut, \n"
                        + "library.Title, Author.Name\n"
                        + "FROM ILGAS.expertReader\n"
                        + "INNER JOIN ILGAS.library on expertReader.referenceNumber = library.referenceNumber\n"
                        + "INNER JOIN ILGAS.Application_Author on library.referenceNumber = Application_Author.ReferenceNumber\n"
                        + "INNER JOIN ILGAS.Author on Application_Author.idAuthor = Author.idAuthor\n"
                        + "WHERE expertReaderUserID = ? \n"
                        + "AND expertReader.referenceNumber = library.referenceNumber\n"
                        + "AND reading = 'true' ");

                ps.setString(1, userID);
                res = ps.executeQuery();
                System.out.println("searchQuery ExpertReaderDAO   " + ps);
                while (res.next()) {

                    System.out.println("\n\n================================= Start: " + counter + "  =================================================\n\n");
                    ExpertReader expertReader = new ExpertReader();

                    expertReader.setReferenceNumber(res.getString("referenceNumber"));
                    expertReader.setSampleSentOut(res.getString("sampleSentOut"));
                    expertReader.setBookTitle(res.getString("Title"));
                    expertReader.setAuthorName(res.getString("Name"));

                    ExpertReaderOpenReadingsData.add(expertReader);
                    System.out.println("================================= End: " + counter + "  =================================================>");
                    counter++;
                }
            } catch (ClassNotFoundException | SQLException e) {
                LOGGER.debug(e.getMessage());
                DBConn.close(conn, ps, res);
                throw new DBException("12 Excepion while accessing database");
            }

            DBConn.close(conn, ps, res);
        }

        return ExpertReaderOpenReadingsData;
    }
}
