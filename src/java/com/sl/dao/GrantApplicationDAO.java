package com.sl.dao;

import static com.sl.dao.ACpublisherDAO_test.disconnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;

import com.sl.model.GrantApplication;
import com.sl.db.DBConn;
import com.sl.db.DBException;
import java.util.ArrayList;
import java.util.List;

public class GrantApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(GrantApplicationDAO.class.getName());

    // selectApplication
    public static GrantApplication selectApplication(String ApplicationNumber) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        GrantApplication application = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select ApplicationNumber"
                    + "company,\n"
                    + "publisherID,\n"
                    + "userID,\n"
                    + "agreement,\n"
                    + "agreementDocName,\n"
                    + "contract,\n"
                    + "contractDocName,\n"
                    + "proposedDateOfPublication,\n"
                    + "proposedDateOfPrintRun,\n"
                    + "plannedPageExtent,\n"
                    + "translatorCV,\n"
                    + "translatorCVDocName,\n"
                    + "numberOfPages,\n"
                    + "feePerPage,\n"
                    + "translatorFee,\n"
                    + "Notes,\n"
                    + "copiesSent,\n"
                    + "dateCopiesWereSent,\n"
                    + "copiesTranslationSample,\n"
                    + "copiesTranslationSampleDocName,\n"
                    + "TC_ACCEPTED,\n"
                    + "APPROVED,\n"
                    + "Status from GrantApplication where ApplicationNumber = ?");
            
            ps.setString(1, ApplicationNumber);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    application = new GrantApplication();
                    application.setApplicationNumber(res.getInt(1));
                    application.setCompany(res.getString(2));
                    application.setPublisherID(res.getString(3));
                    application.setUserID(res.getString(4));
                    application.setAgreement(res.getString(5));
                    application.setAgreementDocName(res.getString(6));
                    application.setContract(res.getString(7));
                    application.setContractDocName(res.getString(8));
                    application.setProposedDateOfPublication(res.getDate(9));
                    application.setProposedDateOfPrintRun(res.getDate(10));
                    application.setPlannedPageExtent(res.getInt(11));
                    application.setTranslatorCV(res.getString(12));
                    application.setTranslatorCVDocName(res.getString(13));
                    application.setNumberOfPages(res.getInt(14));
                    application.setFeePerPage(res.getBigDecimal(15));
                    application.setTranslatorFee(res.getBigDecimal(16));
                    application.setNotes(res.getString(17));
                    application.setCopiesSent(res.getInt(18));
                    application.setDateCopiesWereSent(res.getDate(19));
                    application.setCopiesTranslationSample(res.getString(20));
                    application.setCopiesTranslationSampleDocName(res.getString(21));
                    application.setTC_ACCEPTED(res.getInt(22));
                    application.setAPPROVED(res.getInt(23));
                    application.setStatus(res.getString(24));
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            LOGGER.debug(e.getMessage());
            e.printStackTrace();
            throw new DBException("1 Excepion while accessing database");
        }

        return application;
    }

    // isApplicationNumberExists
    public static boolean isApplicationNumberExists(int ApplicationNumber) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean verified = false;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select 1 from GrantApplication where ApplicationNumber = ?");
            ps.setInt(1, ApplicationNumber);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    verified = true;
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("3 Excepion while accessing database");
        }

        return verified;
    }

    // insertRow
    public static int insertRow(GrantApplication application) throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("INSERT INTO  GrantApplication"
                    + "(company,\n"
                    + "publisherID,\n"
                    + "userID,\n"
                    + "agreement,\n"
                    + "contract,\n"
                    + "proposedDateOfPublication,\n"
                    + "proposedDateOfPrintRun,\n"
                    + "plannedPageExtent,\n"
                    + "translatorCV,\n"
                    + "numberOfPages,\n"
                    + "feePerPage,\n"
                    + "translatorFee,\n"
                    + "Notes,\n"
                    + "copiesSent,\n"
                    + "dateCopiesWereSent,\n"
                    + "copiesTranslationSample,\n"
                    + "TC_ACCEPTED,\n"
                    + "APPROVED,\n"
                    + "Status)  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            ps1.setString(1, application.getCompany());
            ps1.setString(2, application.getPublisherID());
            ps1.setString(3, application.getUserID());
            ps1.setString(4, application.getAgreement());
            ps1.setString(5, application.getContract());
            ps1.setDate(6, sqlDate(application.getProposedDateOfPublication()));
            ps1.setDate(7, sqlDate(application.getProposedDateOfPrintRun()));
            ps1.setInt(8, application.getPlannedPageExtent());
            ps1.setString(9, application.getTranslatorCV());
            ps1.setInt(10, application.getNumberOfPages());
            ps1.setBigDecimal(11, application.getFeePerPage());
            ps1.setBigDecimal(12, application.getTranslatorFee());
            ps1.setString(13, application.getNotes());
            ps1.setInt(14, application.getCopiesSent());
            ps1.setDate(15, sqlDate(application.getDateCopiesWereSent()));
            ps1.setString(16, application.getCopiesTranslationSample());
            ps1.setInt(17, application.getTC_ACCEPTED());
            ps1.setInt(18, application.getAPPROVED());
            ps1.setString(19, application.getStatus());

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();;

            if (res != null) {
                while (res.next()) {
                    id = res.getInt(1);
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

    //updateApplication
    public static boolean updateApplication(GrantApplication application, int ApplicationNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed;
        ResultSet res = null;
        int applicationNumber = ApplicationNumber;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("UPDATE GrantApplication SET"
                    + "company,\n"
                    + "publisherID,\n"
                    + "userID,\n"
                    + "agreement,\n"
                    + "agreementDocName,\n"
                    + "contract,\n"
                    + "contractDocName,\n"
                    + "proposedDateOfPublication,\n"
                    + "proposedDateOfPrintRun,\n"
                    + "plannedPageExtent,\n"
                    + "translatorCV,\n"
                    + "translatorCVDocName,\n"
                    + "numberOfPages,\n"
                    + "feePerPage,\n"
                    + "translatorFee,\n"
                    + "Notes,\n"
                    + "copiesSent,\n"
                    + "dateCopiesWereSent,\n"
                    + "copiesTranslationSample,\n"
                    + "copiesTranslationSampleDocName,\n"
                    + "TC_ACCEPTED,\n"
                    + "APPROVED,\n"
                    + "Status)  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
                    + "WHERE ApplicationNumber = " + applicationNumber);

            ps1.setString(1, application.getCompany());
            ps1.setString(2, application.getPublisherID());
            ps1.setString(3, application.getUserID());
            ps1.setString(4, application.getAgreement());
            ps1.setString(5, application.getAgreementDocName());
            ps1.setString(6, application.getContract());
            ps1.setString(7, application.getContractDocName());
            ps1.setDate(8, sqlDate(application.getProposedDateOfPublication()));
            ps1.setDate(9, sqlDate(application.getProposedDateOfPrintRun()));
            ps1.setInt(10, application.getPlannedPageExtent());
            ps1.setString(11, application.getTranslatorCV());
            ps1.setString(12, application.getTranslatorCVDocName());
            ps1.setInt(13, application.getNumberOfPages());
            ps1.setBigDecimal(14, application.getFeePerPage());
            ps1.setBigDecimal(15, application.getTranslatorFee());
            ps1.setString(16, application.getNotes());
            ps1.setInt(17, application.getCopiesSent());
            ps1.setDate(18, sqlDate(application.getDateCopiesWereSent()));
            ps1.setString(19, application.getCopiesTranslationSample());
            ps1.setString(20, application.getCopiesTranslationSampleDocName());
            ps1.setInt(21, application.getTC_ACCEPTED());
            ps1.setInt(22, application.getAPPROVED());
            ps1.setString(23, application.getStatus());

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
            throw new DBException("4 Excepion while accessing database");
        }

        return id;
    }

    //updateDocuments
    public static boolean updateDocuments(GrantApplication application, int ApplicationNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed;
        ResultSet res = null;
        int applicationNumber = ApplicationNumber;
        System.out.println("ApplicationNumber:  " + applicationNumber);
        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("UPDATE GrantApplication SET "
                    + "agreement = ?,\n"
                    + "agreementDocName = ?,\n"
                    + "contract = ?,\n"
                    + "contractDocName = ?,\n"
                    + "translatorCV = ?,\n"
                    + "translatorCVDocName = ?,\n"
                    + "copiesTranslationSample = ?,\n"
                    + "copiesTranslationSampleDocName = ?"
                    + " WHERE ApplicationNumber = " + applicationNumber);

            ps1.setString(1, application.getAgreement());
            ps1.setString(2, application.getAgreementDocName());
            ps1.setString(3, application.getContract());
            ps1.setString(4, application.getContractDocName());
            ps1.setString(5, application.getTranslatorCV());
            ps1.setString(6, application.getTranslatorCVDocName());
            ps1.setString(7, application.getCopiesTranslationSample());
            ps1.setString(8, application.getCopiesTranslationSampleDocName());

               System.out.println("ps1:: " + ps1);
               
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
            throw new DBException("4 Excepion while accessing database");
        }

        return id;
    }

    // deleteRow
    public static void deleteRow(GrantApplication application) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("delete from GrantApplication where ApplicationNumber = ?");
            ps.setInt(1, application.getApplicationNumber());
            ps.executeUpdate();
            ps.close();
            DBConn.close(conn, ps);

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
        }
    }

    // updateStatus
    public static void updateStatus(int ApplicationNumber, String status) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("UPDATE GrantApplication set STATUS = ? where ApplicationNumber = ?");
            ps.setString(1, status);
            ps.setInt(2, ApplicationNumber);
            ps.executeUpdate();
            DBConn.close(conn, ps);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
            throw new DBException("5 Excepion while accessing database");
        }
    }

    // listAllApplications
    public static List<GrantApplication> listAllApplications() throws DBException {
        List<GrantApplication> listApplications = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT * FROM GrantApplication");
            res = ps.executeQuery();

            while (res.next()) {
                GrantApplication application = new GrantApplication();

                application.setApplicationNumber(res.getInt(1));
                application.setCompany(res.getString(2));
                application.setPublisherID(res.getString(3));
                application.setUserID(res.getString(4));
                application.setAgreement(res.getString(5));
                application.setAgreementDocName(res.getString(6));
                application.setContract(res.getString(7));
                application.setContractDocName(res.getString(8));
                application.setProposedDateOfPublication(res.getDate(9));
                application.setProposedDateOfPrintRun(res.getDate(10));
                application.setPlannedPageExtent(res.getInt(11));
                application.setTranslatorCV(res.getString(12));
                application.setTranslatorCVDocName(res.getString(13));
                application.setNumberOfPages(res.getInt(14));
                application.setFeePerPage(res.getBigDecimal(15));
                application.setTranslatorFee(res.getBigDecimal(16));
                application.setNotes(res.getString(17));
                application.setCopiesSent(res.getInt(18));
                application.setDateCopiesWereSent(res.getDate(19));
                application.setCopiesTranslationSample(res.getString(20));
                application.setCopiesTranslationSampleDocName(res.getString(21));
                application.setTC_ACCEPTED(res.getInt(22));
                application.setAPPROVED(res.getInt(23));
                application.setStatus(res.getString(24));

                listApplications.add(application);
            }

            conn.commit();
            DBConn.close(conn, ps, res);

            disconnect();

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            throw new DBException("4 Excepion while accessing database");
        }

        return listApplications;
    }

    // convert Java Date to SQL Date
    public static java.sql.Date sqlDate(java.util.Date javaDate) {

        java.util.Date utilStartDate = javaDate;
        java.sql.Date convertSqlDate = new java.sql.Date(utilStartDate.getTime());

        return convertSqlDate;
    }

    public static int getLastRecordID() throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;

        int id = 0;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("SELECT max(ApplicationNumber) FROM GrantApplication");
            res = ps1.executeQuery();

            if (res != null) {
                while (res.next()) {
                    id = res.getInt(1);
                }
            }

            conn.commit();
            DBConn.close(conn, ps1, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            e.printStackTrace();
            DBConn.close(conn, ps1, res);
            throw new DBException("getLastRecordID :: Exception while accessing database");
        }

        return id;
    }
}
