package ie.irishliterature.dao;

import static ie.irishliterature.dao.ACpublisherDAO_test.disconnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;

import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class GrantApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(GrantApplicationDAO.class.getName());

    static Calendar now = Calendar.getInstance();
    static int year = now.get(Calendar.YEAR);
    static String yearInString = String.valueOf(year);

    // selectApplication
    public static GrantApplication selectApplication(String ReferenceNumber) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        GrantApplication application = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select ReferenceNumber"
                    + "ApplicationYear,\n"
                    + "ApplicationNumber,\n"
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
                    + "Status,\n"
                    + "lastUpdated from GrantApplication where ReferenceNumber = ?");

            ps.setString(1, ReferenceNumber);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    application = new GrantApplication();

                    application.setReferenceNumber(res.getString(1));
                    application.setApplicationYear(res.getString(2));
                    application.setApplicationNumber(res.getInt(3));
                    application.setCompany(res.getString(4));
                    application.setPublisherID(res.getInt(5));
                    application.setUserID(res.getString(6));
                    application.setAgreement(res.getString(7));
                    application.setAgreementDocName(res.getString(8));
                    application.setContract(res.getString(9));
                    application.setContractDocName(res.getString(10));
                    application.setProposedDateOfPublication(res.getDate(11));
                    application.setProposedDateOfPrintRun(res.getDate(12));
                    application.setPlannedPageExtent(res.getInt(13));
                    application.setTranslatorCV(res.getString(14));
                    application.setTranslatorCVDocName(res.getString(15));
                    application.setNumberOfPages(res.getInt(16));
                    application.setFeePerPage(res.getBigDecimal(17));
                    application.setTranslatorFee(res.getBigDecimal(18));
                    application.setNotes(res.getString(19));
                    application.setCopiesSent(res.getInt(20));
                    application.setDateCopiesWereSent(res.getDate(21));
                    application.setCopiesTranslationSample(res.getString(22));
                    application.setCopiesTranslationSampleDocName(res.getString(23));
                    application.setTC_ACCEPTED(res.getInt(24));
                    application.setAPPROVED(res.getInt(25));
                    application.setStatus(res.getString(26));
                    application.setLASTUPDATED(res.getTimestamp(27));
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
    public static boolean isReferenceNumberExists(int ReferenceNumber) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean verified = false;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select 1 from GrantApplication where ReferenceNumber = ?");
            ps.setInt(1, ReferenceNumber);
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
    public static String insertRow(GrantApplication application) throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        java.sql.Timestamp timestamp = getcurrentTimeStamp();

        int ApplicationNumber = getNextApplicationNumber();

        System.out.println(" DAO  ApplicationNumber: " + ApplicationNumber);

        String ReferenceNumber = ApplicationNumber + "/" + yearInString;

        System.out.println(" DAO  ReferenceNumber: " + ReferenceNumber);

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("INSERT INTO  GrantApplication"
                    + "(ReferenceNumber,\n"
                    + "ApplicationYear,\n"
                    + "ApplicationNumber,\n"
                    + "company,\n"
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
                    + "Status,\n"
                    + "lastUpdated)  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            ps1.setString(1, ReferenceNumber);
            ps1.setString(2, yearInString);
            ps1.setInt(3, ApplicationNumber);
            ps1.setString(4, application.getCompany());
            ps1.setInt(5, application.getPublisherID());
            ps1.setString(6, application.getUserID());
            ps1.setString(7, application.getAgreement());
            ps1.setString(8, application.getContract());
            ps1.setDate(9, sqlDate(application.getProposedDateOfPublication()));
            ps1.setDate(10, sqlDate(application.getProposedDateOfPrintRun()));
            ps1.setInt(11, application.getPlannedPageExtent());
            ps1.setString(12, application.getTranslatorCV());
            ps1.setInt(13, application.getNumberOfPages());
            ps1.setBigDecimal(14, application.getFeePerPage());
            ps1.setBigDecimal(15, application.getTranslatorFee());
            ps1.setString(16, application.getNotes());
            ps1.setInt(17, application.getCopiesSent());
            ps1.setDate(18, sqlDate(application.getDateCopiesWereSent()));
            ps1.setString(19, application.getCopiesTranslationSample());
            ps1.setInt(20, application.getTC_ACCEPTED());
            ps1.setInt(21, application.getAPPROVED());
            ps1.setString(22, application.getStatus());
            ps1.setTimestamp(23, application.getLASTUPDATED());

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

        System.out.println("GrantApplicationDAO ApplicationNumber:1:   " + ApplicationNumber);
        return ReferenceNumber;
    }

    public static int insertAuthors(String ReferenceNumber, String Name, String FirstName, String LastName) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idAuthor = 0;
        ResultSet res = null;

        try {

            //check if Author exists
            idAuthor = ifAuthorexist(Name);

            //if not insert the new Author
            if (idAuthor == 0) {
                // ID, Name, FirstName, Space, LastName, DateOfBirth, Biography
                idAuthor = insertNewAuthor(Name, FirstName, LastName);

                System.out.println(">>>>>>>>>>>>. Author: " + Name + " idAuthor: " + idAuthor);

            }
            // then:
            //got idAuthor now insert into Application_Author         

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("INSERT INTO  Application_Author"
                    + "(ReferenceNumber,\n"
                    + "idAuthor) values (?,?)");

            ps1.setString(1, ReferenceNumber);
            ps1.setInt(2, idAuthor);

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

    //updateApplication
    public static boolean updateApplication(GrantApplication application, int ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed;
        ResultSet res = null;
        int applicationNumber = ReferenceNumber;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("UPDATE GrantApplication SET"
                    + "(ReferenceNumber,\n"
                    + "ApplicationYear,\n"
                    + "ApplicationNumber,\n"
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
                    + "Status,\n"
                    + "lastUpdated)  values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
                    + "WHERE ApplicationNumber = " + ReferenceNumber);

            ps1.setString(1, application.getReferenceNumber());
            ps1.setString(2, application.getApplicationYear());
            ps1.setInt(3, application.getApplicationNumber());
            ps1.setString(4, application.getCompany());
            ps1.setInt(5, application.getPublisherID());
            ps1.setString(6, application.getUserID());
            ps1.setString(7, application.getAgreement());
            ps1.setString(8, application.getContract());
            ps1.setDate(9, sqlDate(application.getProposedDateOfPublication()));
            ps1.setDate(10, sqlDate(application.getProposedDateOfPrintRun()));
            ps1.setInt(11, application.getPlannedPageExtent());
            ps1.setString(12, application.getTranslatorCV());
            ps1.setInt(13, application.getNumberOfPages());
            ps1.setBigDecimal(14, application.getFeePerPage());
            ps1.setBigDecimal(15, application.getTranslatorFee());
            ps1.setString(16, application.getNotes());
            ps1.setInt(17, application.getCopiesSent());
            ps1.setDate(18, sqlDate(application.getDateCopiesWereSent()));
            ps1.setString(19, application.getCopiesTranslationSample());
            ps1.setInt(20, application.getTC_ACCEPTED());
            ps1.setInt(21, application.getAPPROVED());
            ps1.setString(22, application.getStatus());
            ps1.setTimestamp(23, application.getLASTUPDATED());

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
    public static boolean updateDocuments(GrantApplication application, String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed;
        ResultSet res = null;

        //  String applicationNumber = ReferenceNumber;
        java.sql.Timestamp timestamp = getcurrentTimeStamp();

        System.out.println("updateDocuments ReferenceNumber:  " + ReferenceNumber);

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
                    + "copiesTranslationSampleDocName = ?,\n"
                    + "lastUpdated =  ?"
                    + " WHERE ReferenceNumber = '" + ReferenceNumber + "'");

            ps1.setString(1, application.getAgreement());
            ps1.setString(2, application.getAgreementDocName());
            ps1.setString(3, application.getContract());
            ps1.setString(4, application.getContractDocName());
            ps1.setString(5, application.getTranslatorCV());
            ps1.setString(6, application.getTranslatorCVDocName());
            ps1.setString(7, application.getCopiesTranslationSample());
            ps1.setString(8, application.getCopiesTranslationSampleDocName());
            ps1.setTimestamp(9, timestamp);

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
            ps = conn.prepareStatement("delete from GrantApplication where ReferenceNumber = ?");
            ps.setString(1, application.getReferenceNumber());
            ps.executeUpdate();
            ps.close();
            DBConn.close(conn, ps);

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
        }
    }

    // updateStatus
    public static void updateStatus(int ReferenceNumber, String status) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("UPDATE GrantApplication set STATUS = ? where ReferenceNumber = ?");
            ps.setString(1, status);
            ps.setInt(2, ReferenceNumber);
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
                System.out.println("GrantApplicationDAO :: getAllApplications   ApplicationNumber:  " + res.getInt(1));
                application.setApplicationYear(res.getString(2));
                System.out.println("GrantApplicationDAO :: getAllApplications   ApplicationYear:  " + res.getString(2));
                application.setReferenceNumber(res.getString(3));
                System.out.println("GrantApplicationDAO :: getAllApplications   ReferenceNumber:  " + res.getString(3));
                application.setCompany(res.getString(4));
                application.setPublisherID(res.getInt(5));
                application.setUserID(res.getString(6));
                application.setAgreement(res.getString(7));
                application.setAgreementDocName(res.getString(8));
                application.setContract(res.getString(9));
                application.setContractDocName(res.getString(10));
                application.setProposedDateOfPublication(res.getDate(11));
                application.setProposedDateOfPrintRun(res.getDate(12));
                application.setPlannedPageExtent(res.getInt(13));
                application.setTranslatorCV(res.getString(14));
                application.setTranslatorCVDocName(res.getString(15));
                application.setNumberOfPages(res.getInt(16));
                application.setFeePerPage(res.getBigDecimal(17));
                application.setTranslatorFee(res.getBigDecimal(18));
                application.setNotes(res.getString(19));
                application.setCopiesSent(res.getInt(20));
                application.setDateCopiesWereSent(res.getDate(21));
                application.setCopiesTranslationSample(res.getString(22));
                application.setCopiesTranslationSampleDocName(res.getString(23));
                application.setTC_ACCEPTED(res.getInt(24));
                application.setAPPROVED(res.getInt(25));
                application.setStatus(res.getString(26));
                application.setApplicationYear(res.getString(27));
                application.setLASTUPDATED(res.getTimestamp(28));

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

    public static java.sql.Timestamp getcurrentTimeStamp() {

        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());

        return currentTimestamp;

    }

    public static int getNextApplicationNumber() throws DBException {

        int nextApplicationNumber = 0;

        Connection conn = null;
        PreparedStatement ps1 = null;
        ResultSet res = null;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("SELECT * FROM GrantApplication where ApplicationYear = '" + yearInString + "' ORDER BY ApplicationNumber DESC");
            res = ps1.executeQuery();

            if (res != null) {
                if (res.next()) {
                    nextApplicationNumber = res.getInt(1) + 1;
                }
            }

            conn.commit();
            DBConn.close(conn, ps1, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            e.printStackTrace();
            DBConn.close(conn, ps1, res);
            throw new DBException("getNextApplicationNumber :: Exception while accessing database");
        }

        System.out.println("getNextApplicationNumber::  " + nextApplicationNumber);
        return nextApplicationNumber;
    }

    public static int ifAuthorexist(String AuthorName) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        int authorId = 0;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT ID FROM A_Author WHERE Name = ?");
            ps.setString(1, AuthorName);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    authorId = res.getInt(1);
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("3 Excepion while accessing database");
        }

        return authorId;
    }

    public static int insertNewAuthor(String FullName, String FirstName, String LastName) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        ResultSet res = null;

        int authorId = 0;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = "INSERT INTO  A_Author (Name, FirstName, LastName) values (?,?,?)";

            ps1 = conn.prepareStatement(sql);

            ps1.setString(1, FullName);
            ps1.setString(2, FirstName);
            ps1.setString(3, LastName);

            ps1.executeUpdate();

            System.out.println("Name  " + FullName + ", FirstName  " + FirstName + ", LastName  " + LastName);

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    authorId = res.getInt(1);
                    System.out.println("GrantApplicationDAO insertNewAuthor  id::   " + authorId);
                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps1, ps2, res);
            throw new DBException("4 Excepion while accessing database");
        }

        return authorId;
    }
}
