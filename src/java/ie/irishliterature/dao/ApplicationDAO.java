package ie.irishliterature.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.model.User;
import ie.irishliterature.util.GlobalConstants;
import java.util.ArrayList;

public class ApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(ApplicationDAO.class.getName());

    public static User selectUSER(String uname) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        User pojo = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select uname, EMAIL, FIRST_NAME, LAST_NAME, EMAIL_VERIFICATION_HASH, EMAIL_VERIFICATION_ATTEMPTS, STATUS, CREATED_TIME from users where uname = ?");
            ps.setString(1, uname);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    pojo = new User();
                    pojo.setUSERNAME(res.getString(1));
                    pojo.setEMAIL(res.getString(2));
                    pojo.setFIRST_NAME(res.getString(3));
                    pojo.setLAST_NAME(res.getString(4));
                    pojo.setEMAIL_VERIFICATION_HASH(res.getString(5));
                    pojo.setEMAIL_VERIFICATION_ATTEMPTS(res.getInt(6));
                    pojo.setSTATUS(res.getString(7));
                    pojo.setCREATED_TIME(res.getString(8));
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            LOGGER.debug(e.getMessage());
            e.printStackTrace();
            throw new DBException("1 Excepion while accessing database");
        }
        return pojo;
    }

    public static boolean verifyEmailHash(String uname, String hash) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean verified = false;
        ResultSet res = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select 1 from users where uname = ? and EMAIL_VERIFICATION_HASH = ?");
            ps.setString(1, uname);
            System.out.println("username dao verifyEmailHash: " + uname);
            ps.setString(2, hash);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    verified = true;
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            LOGGER.debug(e.getMessage());
            throw new DBException("2 Excepion while accessing database");
        }
        return verified;
    }

    public static boolean isEmailExists(String uname) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean verified = false;
        ResultSet res = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select 1 from users where uname = ?");
            ps.setString(1, uname);
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

    public static int insertRow(User pojo) throws DBException {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;
        System.out.println("insertRow:: ");
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("insert into users (uname,FIRST_NAME,LAST_NAME,PASSWORD,EMAIL,FUNCTION,ROLE,EMAIL_VERIFICATION_HASH) values (?,?,?,?,?,?,?,?)");
            ps1.setString(1, pojo.getUSERNAME());
            ps1.setString(2, pojo.getFIRST_NAME());
            ps1.setString(3, pojo.getLAST_NAME());
            ps1.setString(4, pojo.getPASSWORD());
            ps1.setString(5, pojo.getEMAIL());
            ps1.setString(6, pojo.getFUNCTION());
            ps1.setString(7, pojo.getROLE());
            ps1.setString(8, pojo.getEMAIL_VERIFICATION_HASH());

            String uname = pojo.getUSERNAME();
            System.out.println("uname dao insertRow: " + uname);

            String strF = pojo.getFUNCTION();
            System.out.println("strF: " + strF);

            String em = pojo.getEMAIL();
            System.out.println("em: " + em);
            System.out.println("isEmailExists Not: create new one: ");

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

        System.out.println("userID::insertRow:: " + id);
        return id;
    }

    public static void deleteRow(User pojo) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("delete from users where uname = ?");
            ps.setString(1, pojo.getUSERNAME());
            ps.executeUpdate();
            ps.close();
            DBConn.close(conn, ps);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
        }
    }

    public static void updateStaus(String uname, String status) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("update users set STATUS = ? where uname = ?");
            ps.setString(1, status);
            ps.setString(2, uname);
            ps.executeUpdate();
            DBConn.close(conn, ps);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
            throw new DBException("5 Excepion while accessing database");
        }
    }

    public static void updateEmailVerificationHash(String uname, String hash) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("update users set EMAIL_VERIFICATION_HASH = ?, EMAIL_VERIFICATION_ATTEMPTS = ? where uname = ?");
            ps.setString(1, hash);
            ps.setInt(2, 0);
            ps.setString(3, uname);
            ps.executeUpdate();
            DBConn.close(conn, ps);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
            throw new DBException(" 6 Excepion while accessing database");
        }
    }

    public static int incrementVerificationAttempts(String uname) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet res = null;
        int attempts = 0;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("update users set EMAIL_VERIFICATION_ATTEMPTS = EMAIL_VERIFICATION_ATTEMPTS + 1 where uname = ?");
            ps.setString(1, uname);
            ps.executeUpdate();

            ps2 = conn.prepareStatement("SELECT EMAIL_VERIFICATION_ATTEMPTS from users");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {
                    attempts = res.getInt(1);
                }
            }
            DBConn.close(conn, ps, ps2, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, ps2, res);
            throw new DBException("7 Excepion while accessing database");
        }
        return attempts;
    }

    public static User verifyLogin(String inputUsername, String inputPassword) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        User pojo = null;
        ResultSet res = null;
        System.out.println("uname before : " + inputUsername);
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select uname, EMAIL, FIRST_NAME, LAST_NAME, STATUS, CREATED_TIME, ROLE, FUNCTION from users where uname = ? and PASSWORD = ?");
            ps.setString(1, inputUsername);
            ps.setString(2, inputPassword);
            System.out.println("Userdao 1 verifyLogin");
            System.out.println("uname after: " + inputUsername);
            System.out.println("ps: " + ps);

            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    pojo = new User();

                    System.out.println("Userdao 2 verifyLogin");

                    pojo.setUSERNAME(res.getString(1));
                    pojo.setEMAIL(res.getString(2));
                    pojo.setFIRST_NAME(res.getString(3));
                    pojo.setLAST_NAME(res.getString(4));
                    pojo.setSTATUS(res.getString(5));
                    pojo.setCREATED_TIME(res.getString(6));
                    pojo.setROLE(res.getString(7));
                    pojo.setFUNCTION(res.getString(8));
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("8 Excepion while accessing database");
        }
        return pojo;
    }

    public static boolean verifyUserIdAndPassword(String uname,
            String inputCurrentPassword) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean verified = false;
        ResultSet res = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select 1 from users where uname = ? and PASSWORD = ?");
            ps.setString(1, uname);
            ps.setString(2, inputCurrentPassword);
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
            throw new DBException("9 Excepion while accessing database");
        }
        return verified;
    }

    public static void updatePassword(String uname, String inputPassword) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("update users set PASSWORD = ? where uname = ?");
            ps.setString(1, inputPassword);
            ps.setString(2, uname);
            ps.executeUpdate();
            DBConn.close(conn, ps);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
            throw new DBException("10 Excepion while accessing database");
        }
    }

    public static void updateEmailVerificationHashForResetPassword(String inputEmail,
            String hash) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("update users set EMAIL_VERIFICATION_HASH = ?, EMAIL_VERIFICATION_ATTEMPTS = ?, STATUS = ? where EMAIL = ?");
            ps.setString(1, hash);
            ps.setInt(2, 0);
            ps.setString(3, GlobalConstants.IN_RESET_PASSWORD);
            ps.setString(4, inputEmail);
            ps.executeUpdate();
            DBConn.close(conn, ps);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
            throw new DBException("11 Excepion while accessing database");
        }
    }

    public static User selectUSERbyEmail(String inputEmail) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        User pojo = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select uname, EMAIL, FIRST_NAME, LAST_NAME, EMAIL_VERIFICATION_HASH, EMAIL_VERIFICATION_ATTEMPTS, STATUS, CREATED_TIME from users where EMAIL = ?");
            ps.setString(1, inputEmail);
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    pojo = new User();
                    pojo.setUSERNAME(res.getString(1));
                    pojo.setEMAIL(res.getString(2));
                    pojo.setFIRST_NAME(res.getString(3));
                    pojo.setLAST_NAME(res.getString(4));
                    pojo.setEMAIL_VERIFICATION_HASH(res.getString(5));
                    pojo.setEMAIL_VERIFICATION_ATTEMPTS(res.getInt(6));
                    pojo.setSTATUS(res.getString(7));
                    pojo.setCREATED_TIME(res.getString(8));
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }
        return pojo;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList getAllApplications() throws ClassNotFoundException, DBException {

        ArrayList listApplications = new ArrayList();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String searchQuery = "SELECT * FROM GrantApplication";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement(searchQuery);

            res = ps.executeQuery(searchQuery);

            if (res != null) {
                while (res.next()) {
                    GrantApplication application = new GrantApplication();

                    application.setApplicationNumber(res.getInt("ApplicationNumber"));
                    application.setApplicationYear(res.getString("ApplicationYear"));
                    application.setReferenceNumber(res.getString("ReferenceNumber"));
                    application.setCompany(res.getString("company"));
                    application.setPublisherID(res.getInt("publisherID"));
                    application.setUserID(res.getString("userID"));
                    application.setAgreement(res.getString("agreement"));
                    application.setAgreementDocName(res.getString("agreementDocName"));
                    application.setContract(res.getString("contract"));
                    application.setContractDocName(res.getString("contractDocName"));
                    application.setProposedDateOfPublication(res.getDate("proposedDateOfPublication"));
                    application.setProposedDateOfPrintRun(res.getDate("proposedDateOfPrintRun"));
                    application.setPlannedPageExtent(res.getInt("plannedPageExtent"));
                    application.setTranslatorCV(res.getString("translatorCV"));
                    application.setTranslatorCVDocName(res.getString("translatorCVDocName"));
                    application.setNumberOfPages(res.getInt("numberOfPages"));
                    application.setFeePerPage(res.getBigDecimal("feePerPage"));
                    application.setTranslatorFee(res.getBigDecimal("translatorFee"));
                    application.setNotes(res.getString("Notes"));
                    application.setCopiesSent(res.getInt("copiesSent"));
                    application.setDateCopiesWereSent(res.getDate("dateCopiesWereSent"));
                    application.setCopiesTranslationSample(res.getString("copiesTranslationSample"));
                    application.setCopiesTranslationSampleDocName(res.getString("copiesTranslationSampleDocName"));
                    application.setTC_ACCEPTED(res.getInt("TC_ACCEPTED"));
                    application.setAPPROVED(res.getInt("APPROVED"));
                    application.setStatus(res.getString("Status"));

                    listApplications.add(application);
                }
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        return listApplications;
    }
}
