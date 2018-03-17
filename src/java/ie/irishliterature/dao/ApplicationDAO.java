package ie.irishliterature.dao;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.model.TranslatorTracker;
import ie.irishliterature.model.User;
import ie.irishliterature.util.GlobalConstants;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import org.apache.log4j.Logger;

public class ApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(ApplicationDAO.class.getName());
    private static String translatorName;
    private static String AuthorName = "";
    private static ArrayList titleList = new ArrayList<>();

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
//            System.out.println("Userdao 1 verifyLogin");
//            System.out.println("uname after: " + inputUsername);
//            System.out.println("ps: " + ps);

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

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        ArrayList listApplications = new ArrayList();
        ArrayList<String> translatorTrackId = new ArrayList<>();
        ArrayList<String> authorList = new ArrayList<>();
        //  ArrayList<String> list = new ArrayList<>();

        ArrayList<String> translatorList = new ArrayList<>();

        String searchQuery = "SELECT * FROM GrantApplication";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement(searchQuery);

            res = ps.executeQuery(searchQuery);

            ResultSetMetaData rsmd = res.getMetaData();
            int columnsNumber = rsmd.getColumnCount();

            if (res != null) {
                while (res.next()) {

                    for (int i = 1; i <= columnsNumber; i++) {
                        if (i > 1) {
                            System.out.print(",  ");
                        }
                        String columnValue = res.getString(i);
                        System.out.print(columnValue + " " + rsmd.getColumnName(i));
                    }
                    System.out.println("");

                    GrantApplication application = new GrantApplication();

                    String ReferenceNumber = res.getString("ReferenceNumber");

                    application.setApplicationNumber(res.getInt("ApplicationNumber"));
                    application.setApplicationYear(res.getString("ApplicationYear"));
                    application.setReferenceNumber(ReferenceNumber);
                    application.setCompany(res.getString("company"));
                    application.setPublisherID(res.getInt("publisherID"));
                    application.setUserID(res.getString("userID"));

                    String[] bookTitle = getBookTitle(ReferenceNumber);

                    application.setBookTitle(bookTitle[0]);
                    application.setAgreement(res.getString("agreement"));
                    application.setAgreementDocName(res.getString("agreementDocName"));
                    application.setContract(res.getString("contract"));
                    application.setContractDocName(res.getString("contractDocName"));
                    application.setProposedDateOfPublication(res.getDate("proposedDateOfPublication"));
                    application.setProposedPrintRun(res.getInt("proposedPrintRun"));
                    application.setPlannedPageExtent(res.getInt("plannedPageExtent"));
                    application.setTranslatorCV(res.getString("translatorCV"));
                    application.setTranslatorCVDocName(res.getString("translatorCVDocName"));
                    application.setBreakDownTranslatorFee(res.getString("breakDownTranslatorFee"));
                    application.setTranslatorFee(res.getBigDecimal("translatorFee"));
                    application.setNotes(res.getString("Notes"));
                    application.setCopiesSent(res.getInt("copiesSent"));
                    application.setDateCopiesWereSent(res.getDate("dateCopiesWereSent"));
                    application.setCopiesTranslationSample(res.getString("copiesTranslationSample"));
                    application.setCopiesTranslationSampleDocName(res.getString("copiesTranslationSampleDocName"));
                    application.setTC_ACCEPTED(res.getInt("TC_ACCEPTED"));
                    application.setAPPROVED(res.getInt("APPROVED"));
                    application.setCover(res.getString("cover"));
                    application.setCoverName(res.getString("coverName"));

                    application.setOriginal(res.getString("original"));
                    application.setOriginalName(res.getString("originalName"));

                    application.setAddendumRightsAgreement(res.getString("addendumRightsAgreement"));
                    application.setAddendumRightsAgreementName(res.getString("addendumRightsAgreementName"));
                    application.setProofOfPaymentToTranslator(res.getString("proofOfPaymentToTranslator"));
                    application.setProofOfPaymentToTranslatorName(res.getString("proofOfPaymentToTranslatorName"));
                    application.setBankDetailsForm(res.getString("bankDetailsForm"));
                    application.setBankDetailsFormName(res.getString("bankDetailsFormName"));
                    application.setSignedLIContract(res.getString("signedLIContract"));
                    application.setSignedLIContractName(res.getString("signedLIContractName"));
                    application.setOriginalDateOfPublication(res.getDate("originalDateOfPublication"));
                    application.setOriginalLanguage(res.getString("originalLanguage"));
                    application.setOriginalPageExtent(res.getInt("originalPageExtent"));
                    application.setCountryOfPublication(res.getString("countryOfPublication"));
                    application.setForeignPublisher(res.getString("foreignPublisher"));
                    application.setForeignCountry(res.getString("foreignCountry"));
                    application.setTargetLanguage(res.getString("targetLanguage"));
                    application.setAmountRequested(res.getBigDecimal("amountRequested"));
                    application.setAward(res.getInt("award"));
                    application.setSalesFigures(res.getInt("salesFigures"));

                    application.setGenre(bookTitle[1]);

                    String expertReaderName = getExpertReaderName(ReferenceNumber);

                    application.setExpertReaderName(expertReaderName);

                    //get all idTranslator / Translator.Name  for that ReferenceNumber return ArrayList
                    translatorTrackId = getTranslatorTrackId(ReferenceNumber);

                    translatorList = new ArrayList<>();
                    ArrayList<ArrayList<String>> mixedList = new ArrayList<>();
                    ArrayList<String> testList; // = new ArrayList<>();
                    titleList = new ArrayList<>();

                    authorList = getAuthors(ReferenceNumber);

                    for (int i = 0; i < translatorTrackId.size(); i++) {

                        String translatorNameForList = getTranslatorNames(translatorTrackId.get(i));

                        testList = getTranslatorTrack(translatorTrackId.get(i));

                        System.out.println("getTranslatorTrack:  " + getTranslatorTrack(translatorTrackId.get(i)));

                        translatorList.add(translatorNameForList);

                        // mixedList contains [0] Translator [1..] Titles
                        mixedList.add(testList);

                    }

                    List<String[]> expertReaderList;
                    expertReaderList = getExpertReader(ReferenceNumber);
                    application.setExpertReaderList(expertReaderList);
                    System.out.println("expertReaderList length:  " + expertReaderList.size());

                    for (int d = 0; d < expertReaderList.size(); d++) {
                        String[] strings = expertReaderList.get(d);
                        System.out.println("Array:  " + d);
                        application.setExpertReaderList(expertReaderList);
                        for (int j = 0; j < strings.length; j++) {
                            System.out.print("expertReaderList :  " + strings[j] + " j: " + j);
                        }
                        System.out.println();
                    }

                    List<String> unassignedExpertReaderList;
                    unassignedExpertReaderList = getUnassignedExpertReader();

                    application.setUnassignedExpertReaderList(unassignedExpertReaderList);
                    application.setTranslatorTitles(mixedList);
                    application.setTitles(titleList);
                    application.setTranslatorName(translatorList);
                    application.setAuthor(authorList);
                    application.setStatus(res.getString("Status"));

                    listApplications.add(application);

                    System.out.println("Application dao listApplications: " + listApplications);

                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return listApplications;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList getTranslatorTrack(String TranslatorTrackId) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        ArrayList authorList = new ArrayList<>();
        ArrayList testList = new ArrayList<>();
        TranslatorTracker translatorTracker;

        try {
            conn = DBConn.getConnection();

            translatorTracker = new TranslatorTracker();

            ps = conn.prepareStatement("SELECT Translator.Name, TranslatorTrack.Title, TranslatorTrack.ReferenceNumber FROM Translator, TranslatorTrack WHERE TranslatorTrack.idTranslator = Translator.idTranslator AND TranslatorTrack.idTranslator = ?");
            ps.setString(1, TranslatorTrackId);

            res = ps.executeQuery();

            translatorTracker.setTranslatorID(TranslatorTrackId);

            int idx = 0;

            if (res != null) {
                while (res.next()) {

                    if (idx == 0) {

                        translatorTracker.setTranslatorName(res.getString(1));
                        testList.add(res.getString(1));

                        System.out.println("Application dao getTranslatorTrack  setTranslatorName: " + res.getString(1));
                    }

                    idx++;

                    ArrayList<String> auth;
                    auth = getAuthors(res.getString(3));
                    testList.add(auth);
                    titleList.add(res.getString(2));
                    testList.add(res.getString(2));

                    System.out.println("Application dao testlist: " + testList);
                    System.out.println("Application dao getTranslatorTrack  auth: " + auth.toString());
                }

            }

            translatorTracker.setTitles(titleList);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return testList;
    }

    public static String getTranslatorNames(String translatorTrackId) throws ClassNotFoundException, SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * translatorTrackID returns a list with all translators for a specific translatorTrackId
         */
        String aTranslatorName = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Translator.Name FROM Translator WHERE  Translator.idTranslator = ? ");

            ps.setString(1, translatorTrackId);

            res = ps.executeQuery();

            if (res != null) {
                if (res.next()) {

                    aTranslatorName = res.getString(1);

                }
            }

        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return aTranslatorName;
    }


    /* 
    * gets ReferenceNumber
    * produces List idTranslator ID's : idTranslatorList
    * uses idTranslatorList to produce List TranslatorTrack containing Translator.Name
    * returns ArrayList with Translator.Name
     */
    public static ArrayList<String> getTranslatorTrackId(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * translatorTrackID returns a list with all translators for a specific ReferenceNumber
         */
        ArrayList<String> translatorTrackID = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Translator.idTranslator\n"
                    + "                    FROM Translator, TranslatorTrack\n"
                    + "                    WHERE TranslatorTrack.idTranslator = Translator.idTranslator\n"
                    + "                    AND TranslatorTrack.ReferenceNumber = ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    translatorTrackID.add(res.getString(1));

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return translatorTrackID;
    }

    public static ArrayList<String> getAuthors(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * authorList returns a list with all authors for a specific ReferenceNumber
         */
        ArrayList<String> authorList = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Author.Name\n"
                    + "FROM Author, Application_Author\n"
                    + "WHERE Application_Author.idAuthor = Author.idAuthor\n"
                    + "AND Application_Author.ReferenceNumber =  ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    authorList.add(res.getString(1));

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return authorList;
    }

    public static String getExpertReaderName(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * authorList returns a list with the expertReaderName for a specific ReferenceNumber
         */
        String expertReaderName = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT CONCAT(first_name, ' ', last_name) AS `expertReaderName` FROM users, expertReader\n"
                    + "WHERE expertReader.expertReaderUserID = users.userID\n"
                    + "AND expertReader.referenceNumber = ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    expertReaderName = res.getString(1);

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return expertReaderName;
    }

    public static String[] getBookTitle(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * getBookTitle returns a String[] with the bookTitle and Genre for a specific ReferenceNumber
         */
        String bookTitle = "";
        String Genre = "";
        String[] ret = new String[2];

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Title,Genre FROM library\n"
                    + "WHERE library.referenceNumber  = ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    ret[0] = res.getString(1);
                    ret[1] = res.getString(2);

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return ret;
    }

    public static List<String[]> getExpertReader(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * expertReaderList returns a list with the expertReaderName for a specific ReferenceNumber
         */
        List<String[]> expertReaderList = new ArrayList<>();
        String[] indExpertReaderList = new String[5];

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT referenceNumber, fileDestination, sampleSentOut, sampleReturned, summaryReport, "
                    + "CONCAT(first_name, ' ', last_name) AS `expertReaderName` FROM expertReader, users\n"
                    + "WHERE expertReaderUserID = userID\n"
                    + "AND referenceNumber  = ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            ResultSetMetaData metadata = res.getMetaData();
            int numcols = metadata.getColumnCount();

            while (res.next()) {

                indExpertReaderList = new String[7];

                int i = 1;

                while (i <= numcols) {

                    indExpertReaderList[i] = res.getString(i++);

                }

                expertReaderList.add(indExpertReaderList);

            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return expertReaderList;
    }

    public static List<String> getUnassignedExpertReader() {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        System.out.println("entering expertReader.... ");

        /*
         * getUnassignedExpertReader returns a list with the expertReaderName NOT 
         * assigned to any reference number at the moment
         */
        List<String> UnassignedExpertReaderList = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT  CONCAT(first_name, ' ', last_name) AS `expertReaderName` FROM users\n"
                    + "LEFT JOIN expertReader ON users.userID = expertReader.expertReaderUserID\n"
                    + "WHERE expertReader.expertReaderUserID IS NULL\n"
                    + "AND users.function = 'Expert Reader'");

            res = ps.executeQuery();

            while (res.next()) {

                UnassignedExpertReaderList.add(res.getString(1));

            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return UnassignedExpertReaderList;
    }
}
