package ie.irishliterature.dao;

import static ie.irishliterature.dao.ACpublisherDAO_test.disconnect;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.ExpertReader;
import ie.irishliterature.model.GrantApplication;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.apache.log4j.Logger;

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
                    //                    + "numberOfPages,\n"
                    + "originalPageExtent,\n"
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
                    application.setProposedPrintRun(res.getInt(12));
                    application.setPlannedPageExtent(res.getInt(13));
                    application.setTranslatorCV(res.getString(14));
                    application.setTranslatorCVDocName(res.getString(15));
                    application.setOriginalPageExtent(res.getInt(16));
                    application.setBreakDownTranslatorFee(res.getString(17));
                    application.setTranslatorFee(res.getBigDecimal(18));
                    application.setBookNotes(res.getString(19));
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
            ps1 = conn.prepareStatement("INSERT INTO  GrantApplication "
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
                    + "proposedPrintRun,\n"
                    + "plannedPageExtent,\n"
                    + "translatorCV,\n"
                    + "translatorCVDocName,\n"
                    + "numberOfPages,\n"
                    + "translatorFee,\n"
                    + "breakDownTranslatorFee,\n"
                    + "Notes,\n"
                    + "copiesSent,\n"
                    + "dateCopiesWereSent,\n"
                    + "Original,\n"
                    + "OriginalName,\n"
                    + "copiesTranslationSample,\n"
                    + "copiesTranslationSampleDocName,\n"
                    + "TC_ACCEPTED,\n"
                    + "gdpr_ACCEPTED,\n"
                    + "APPROVED,\n"
                    + "Status,\n"
                    + "Cover,\n"
                    + "CoverName,\n"
                    + "originalLanguage,\n"
                    + "originalPageExtent,\n"
                    + "countryOfPublication,\n"
                    + "foreignPublisher,\n"
                    + "foreignCountry,\n"
                    + "targetLanguage,\n"
                    //           + "amountRequested,\n"
                    + "paymentReferenceNumber,\n"
                    + "addendumRightsAgreement,\n"
                    + "addendumRightsAgreementName,\n"
                    + "proofOfPaymentToTranslator,\n"
                    + "proofOfPaymentToTranslatorName,\n"
                    + "bankDetailsForm,\n"
                    + "bankDetailsFormName,\n"
                    + "signedLIContract,\n"
                    + "signedLIContractName,\n"
                    + "award,\n"
                    + "salesFigures,\n"
                    + "created)  values  (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            //                                              1                   2                   3                   4                   5                   6
            //                            1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0      
            //  (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            //       (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?");"
            ps1.setString(1, ReferenceNumber);
            ps1.setString(2, yearInString);
            ps1.setInt(3, ApplicationNumber);
            ps1.setString(4, application.getCompany());
            ps1.setInt(5, application.getPublisherID());
            ps1.setString(6, application.getUserID());
            ps1.setString(7, application.getAgreement());
            ps1.setString(8, application.getAgreementDocName());
            ps1.setString(9, application.getContract());
            ps1.setString(10, application.getContractDocName());
            ps1.setDate(11, sqlDate(application.getProposedDateOfPublication()));
            ps1.setInt(12, application.getProposedPrintRun());
            ps1.setInt(13, application.getPlannedPageExtent());
            ps1.setString(14, application.getTranslatorCV());
            ps1.setString(15, application.getTranslatorCVDocName());
            ps1.setInt(16, application.getNumberOfPages());
            ps1.setBigDecimal(17, application.getTranslatorFee());
            ps1.setString(18, application.getBreakDownTranslatorFee());
            ps1.setString(19, application.getBookNotes());
            ps1.setInt(20, application.getCopiesSent());
            ps1.setDate(21, sqlDate(application.getDateCopiesWereSent()));
            ps1.setString(22, application.getOriginal());
            ps1.setString(23, application.getOriginalName());
            ps1.setString(24, application.getCopiesTranslationSample());
            ps1.setString(25, application.getCopiesTranslationSampleDocName());
            ps1.setInt(26, application.getTC_ACCEPTED());
            ps1.setInt(27, application.getGdprACCEPTED());
            ps1.setInt(28, application.getAPPROVED());
            ps1.setString(29, application.getStatus());
            ps1.setString(30, application.getCover());
            ps1.setString(31, application.getCoverName());
//            ps1.setDate(31, sqlDate(application.getOriginalDateOfPublication()));
            ps1.setString(32, application.getOriginalLanguage());
            ps1.setInt(33, application.getOriginalPageExtent());
            ps1.setString(34, application.getCountryOfPublication());
            ps1.setString(35, application.getForeignPublisher());
            ps1.setString(36, application.getForeignCountry());
            ps1.setString(37, application.getTargetLanguage());

            //    System.out.println("getBoardMeeting:  " + application.getBoardMeeting());
            //  ps1.setDate(38, sqlDate(application.getBoardMeeting()));
            //      ps1.setBigDecimal(37, application.getAmountRequested());
            //      ps1.setBigDecimal(39, application.getAmountApproved());
            //        System.out.println("getPublisherInformedOfMeeting:  " + application.getPublisherInformedOfMeeting());
            //        ps1.setDate(41, sqlDate(application.getPublisherInformedOfMeeting()));
            //     ps1.setString(39, application.getBoardComments_Instructions());
            //      ps1.setDate(43, sqlDate(application.getContractSentToPublisher()));
            //      ps1.setDate(44, sqlDate(application.getAcknowledgementApproved()));
            //      ps1.setDate(45, sqlDate(application.getDatePublishedBooksReceived()));
            //      ps1.setDate(46, sqlDate(application.getDatePaymentMadeToPublisher()));
            ps1.setString(38, application.getPaymentReferenceNumber());
            ps1.setString(39, application.getAddendumRightsAgreement());
            ps1.setString(40, application.getAddendumRightsAgreementName());
            ps1.setString(41, application.getProofOfPaymentToTranslator());
            ps1.setString(42, application.getProofOfPaymentToTranslatorName());
            ps1.setString(43, application.getBankDetailsForm());
            ps1.setString(44, application.getBankDetailsFormName());
            ps1.setString(45, application.getSignedLIContract());
            ps1.setString(46, application.getSignedLIContractName());
            // ps1.setString(49, application.getPaymentStatus());
            // ps1.setString(57, application.getPreviousGrantAid());
            ps1.setInt(47, application.getAward());
            ps1.setInt(48, application.getSalesFigures());
            ps1.setTimestamp(49, getCurrentTimeStamp());

            System.out.println("ps1:  1: " + ps1);
            ps1.executeUpdate();
            System.out.println("ps1:  2: " + ps1);
            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    id = res.getInt(1);
//                    System.out.println("GrantApplicationDAO id::   " + id);
                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps1, ps2, res);
            throw new DBException("4 Excepion while accessing database");
        }

//        System.out.println("GrantApplicationDAO ApplicationNumber:1:   " + ApplicationNumber);
        return ReferenceNumber;
    }

    public static int insertAuthors(String ReferenceNumber, String Name, String FirstName, String LastName) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idAuthor = 0;
        ResultSet res = null;

        System.out.println("insertAuthors --------------->>  ReferenceNumber " + ReferenceNumber + " Name " + Name + " FirstName  " + FirstName + " LastName " + LastName);

        try {

            /*
             * check if Author exists
             */
            idAuthor = ifAuthorExist(Name);

            /*
             * if not insert the new Author
             */
            if (idAuthor == 0) {

                /*
                 * Name, FirstName, LastName
                 */
                idAuthor = insertNewAuthor(ReferenceNumber, Name, FirstName, LastName);

                System.out.println(">>>>>>>>>>>>. Author: " + Name + " idAuthor: " + idAuthor);

            }

            /*
             * then:
             * got idAuthor now insert into Application_Author
             */
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            System.out.println("Receiving from GrantApplicationServlet  ReferenceNumber: " + ReferenceNumber + " , Name: "
                    + Name + " , FirstName: " + FirstName + " , LastName: " + LastName);

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

    public static int insertTranslators(String ReferenceNumber, String Name, String Title, String moveFile, String moveFileName, String copiesTranslationSample, String copiesTranslationSampleDocName) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idTranslator = 0;
        ResultSet res = null;

        try {

            System.out.println("insertTranslators......................:");

            //check if Translator exists
            idTranslator = ifTranslatorExist(Name);

            //if not insert the new Translator
            if (idTranslator == 0) {
                // idTranslatorTrack, idTranslator, Author, Title, ReferenceNumber
                idTranslator = insertNewTranslator(Name);

                System.out.println(">>>>>>>>>>>>. Translator: " + Name + " idTranslator: " + idTranslator);

            }
            // then:
            //got idTranslator now insert into TranslatorTrack         

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);


            ps1 = conn.prepareStatement("INSERT INTO  TranslatorTrack"
                    + "(idTranslator,\n"
                    + "Title,\n"
                    + "ReferenceNumber,\n"
                    + "translatorCV,\n"
                    + "translatorCVDocName,\n"
                    + "copiesTranslationSample,\n"
                    + "copiesTranslationSampleDocName) values (?,?,?,?,?,?,?)");

            ps1.setInt(1, idTranslator);
            ps1.setString(2, Title);
            ps1.setString(3, ReferenceNumber);
            ps1.setString(4, moveFileName);
            ps1.setString(5, moveFile);
            ps1.setString(6, copiesTranslationSample);
            ps1.setString(7, copiesTranslationSampleDocName);
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

    public static int insertAgreement(String ReferenceNumber, String Name, String Title, String moveFileName, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idTranslator = 0;
        ResultSet res = null;

        try {

            System.out.println("insertTranslators......................:");

            //check if Translator exists
            idTranslator = ifTranslatorExist(Name);

            //if not insert the new Translator
            if (idTranslator == 0) {
                // idTranslatorTrack, idTranslator, Author, Title, ReferenceNumber
                idTranslator = insertNewTranslator(Name);

                System.out.println(">>>>>>>>>>>>. Translator: " + Name + " idTranslator: " + idTranslator);

            }
            // then:
            //got idTranslator now insert into TranslatorTrack         

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("INSERT INTO  TranslatorTrack"
                    + "(idTranslator,\n"
                    + "Title,\n"
                    + "ReferenceNumber,\n"
                    + "Agreement,\n"
                    + "AgreementDocName) values (?,?,?,?,?)");

            ps1.setInt(1, idTranslator);
            ps1.setString(2, Title);
            ps1.setString(3, ReferenceNumber);
            ps1.setString(4, moveFileNameReplaced);
            ps1.setString(5, moveFileName);

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

    public static int insertContract(String ReferenceNumber, String Name, String Title, String moveFileName, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idTranslator = 0;
        ResultSet res = null;

        try {

            System.out.println("insertTranslators......................:");

            //check if Translator exists
            idTranslator = ifTranslatorExist(Name);

            //if not insert the new Translator
            if (idTranslator == 0) {
                // idTranslatorTrack, idTranslator, Author, Title, ReferenceNumber
                idTranslator = insertNewTranslator(Name);

                System.out.println(">>>>>>>>>>>>. Translator: " + Name + " idTranslator: " + idTranslator);

            }
            // then:
            //got idTranslator now insert into TranslatorTrack         

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("INSERT INTO  TranslatorTrack"
                    + "(idTranslator,\n"
                    + "Title,\n"
                    + "ReferenceNumber,\n"
                    + "Contract,\n"
                    + "ContractDocName) values (?,?,?,?,?)");

            ps1.setInt(1, idTranslator);
            ps1.setString(2, Title);
            ps1.setString(3, ReferenceNumber);
            ps1.setString(4, moveFileNameReplaced);
            ps1.setString(5, moveFileName);

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

    public static int insertAddendum(String ReferenceNumber, String Name, String Title, String moveFileName, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idTranslator = 0;
        ResultSet res = null;

        try {

            System.out.println("insertTranslators......................:");

            //check if Translator exists
            idTranslator = ifTranslatorExist(Name);

            //if not insert the new Translator
            if (idTranslator == 0) {
                // idTranslatorTrack, idTranslator, Author, Title, ReferenceNumber
                idTranslator = insertNewTranslator(Name);

                System.out.println(">>>>>>>>>>>>. Translator: " + Name + " idTranslator: " + idTranslator);

            }
            // then:
            //got idTranslator now insert into TranslatorTrack         

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("INSERT INTO  TranslatorTrack"
                    + "(idTranslator,\n"
                    + "Title,\n"
                    + "ReferenceNumber,\n"
                    + "AddendumRightsAgreement,\n"
                    + "AddendumRightsAgreementName) values (?,?,?,?,?)");

            ps1.setInt(1, idTranslator);
            ps1.setString(2, Title);
            ps1.setString(3, ReferenceNumber);
            ps1.setString(4, moveFileNameReplaced);
            ps1.setString(5, moveFileName);

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

    public static int insertOriginal(String ApplicationNumber, String moveFileName, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idTranslator = 0;
        ResultSet res = null;

        try {

            System.out.println("insertOriginal......................:");

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);


            String query = "UPDATE GrantApplication SET  Original = ?, OriginalName = ? WHERE ApplicationNumber = ?";
            ps1 = conn.prepareStatement(query);

            ps1.setString(1, moveFileNameReplaced);
            ps1.setString(2, moveFileName);
            ps1.setString(3, ApplicationNumber);

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    id = res.getInt(1);
//                    System.out.println("GrantApplicationDAO id::   " + id);
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

    public static int insertTranslationSample(String ApplicationNumber, String moveFileName, String moveFileNameReplaced) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        ResultSet res = null;

        try {

            System.out.println("insertTranslationSample......................:");

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            System.out.println("ApplicationNumber: " + ApplicationNumber);

            System.out.println("moveFile: " + moveFileNameReplaced);
            System.out.println("moveFileName: " + moveFileName);
            
                        String query = "UPDATE GrantApplication SET  copiesTranslationSample = ?, copiesTranslationSampleDocName = ? WHERE ApplicationNumber = ?";
            ps1 = conn.prepareStatement(query);
            
              
//
//            ps1 = conn.prepareStatement("UPDATE GrantApplication SET"
//                    + "(copiesTranslationSample,\n"
//                    + "copiesTranslationSampleDocName) values (?,?)"
//                    + " WHERE ApplicationNumber = " + ApplicationNumber);

            ps1.setString(1, moveFileNameReplaced);
            ps1.setString(2, moveFileName);
            ps1.setString(3, ApplicationNumber);

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
                    + "proposedPrintRun,\n"
                    + "plannedPageExtent,\n"
                    + "translatorCV,\n"
                    + "translatorCVDocName,\n"
                    //                    + "numberOfPages,\n"
                    + "translatorFee,\n"
                    + "breakDownTranslatorFee,\n"
                    + "Notes,\n"
                    + "copiesSent,\n"
                    + "dateCopiesWereSent,\n"
                    + "Original,\n"
                    + "OriginalName,\n"
                    + "copiesTranslationSample,\n"
                    + "copiesTranslationSampleDocName,\n"
                    + "TC_ACCEPTED,\n"
                    + "APPROVED,\n"
                    + "Status,\n"
                    + "Cover,\n"
                    + "CoverName,\n"
                    + "originalDateOfPublication,\n"
                    + "originalLanguage,\n"
                    + "originalPageExtent,\n"
                    + "countryOfPublication,\n"
                    + "foreignPublisher,\n"
                    + "foreignCountry,\n"
                    + "targetLanguage,\n"
                    + "boardMeeting,\n"
                    + "amountRequested,\n"
                    + "amountApproved,\n"
                    + "publisherInformedOfMeeting,\n"
                    + "boardComments_Instructions,\n"
                    + "contractSentToPublisher,\n"
                    + "acknowledgementApproved,\n"
                    + "datePublishedBooksReceived,\n"
                    + "datePaymentMadeToPublisher,\n"
                    + "paymentReferenceNumber,\n"
                    + "addendumRightsAgreement,\n"
                    + "addendumRightsAgreementName,\n"
                    + "proofOfPaymentToTranslator,\n"
                    + "proofOfPaymentToTranslatorName,\n"
                    + "bankDetailsForm,\n"
                    + "bankDetailsFormName,\n"
                    + "signedLIContract,\n"
                    + "signedLIContractName,\n"
                    + "paymentStatus,\n"
                    + "award,\n"
                    + "salesFigures,\n"
                    + "lastUpdated)  values  (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?"
                    + " WHERE ApplicationNumber = " + ReferenceNumber);

            ps1.setString(1, application.getReferenceNumber());
            ps1.setString(2, yearInString);
            ps1.setInt(3, application.getApplicationNumber());
            ps1.setString(4, application.getCompany());
            ps1.setInt(5, application.getPublisherID());
            ps1.setString(6, application.getUserID());
            ps1.setString(7, application.getAgreement());
            ps1.setString(8, application.getAgreementDocName());
            ps1.setString(9, application.getContract());
            ps1.setString(10, application.getContractDocName());
            ps1.setDate(11, sqlDate(application.getProposedDateOfPublication()));
            ps1.setInt(12, application.getProposedPrintRun());
            ps1.setInt(13, application.getPlannedPageExtent());
            ps1.setString(14, application.getTranslatorCV());
            ps1.setString(15, application.getTranslatorCVDocName());
            ps1.setInt(16, application.getNumberOfPages());
            ps1.setBigDecimal(17, application.getTranslatorFee());
            ps1.setString(18, application.getBreakDownTranslatorFee());
            ps1.setString(19, application.getBookNotes());
            ps1.setInt(20, application.getCopiesSent());
            ps1.setDate(21, sqlDate(application.getDateCopiesWereSent()));
            ps1.setString(22, application.getOriginal());
            ps1.setString(23, application.getOriginalName());
            ps1.setString(24, application.getCopiesTranslationSample());
            ps1.setString(25, application.getCopiesTranslationSampleDocName());
            ps1.setInt(26, application.getTC_ACCEPTED());
            ps1.setInt(27, application.getAPPROVED());
            ps1.setString(28, application.getStatus());
            ps1.setString(29, application.getCover());
            ps1.setString(30, application.getCoverName());
//            ps1.setDate(31, sqlDate(application.getOriginalDateOfPublication()));
            ps1.setString(31, (application.getPublicationYear()));
            ps1.setString(32, application.getOriginalLanguage());
            ps1.setInt(33, application.getOriginalPageExtent());
            ps1.setString(34, application.getCountryOfPublication());
            ps1.setString(35, application.getForeignPublisher());
            ps1.setString(36, application.getForeignCountry());
            ps1.setString(37, application.getTargetLanguage());
            ps1.setDate(38, sqlDate(application.getBoardMeeting()));
            ps1.setBigDecimal(39, application.getAmountRequested());
            ps1.setBigDecimal(40, application.getAmountApproved());
            ps1.setDate(41, sqlDate(application.getPublisherInformedOfMeeting()));
            ps1.setString(42, application.getBoardComments_Instructions());
            ps1.setDate(43, sqlDate(application.getContractSentToPublisher()));
            ps1.setDate(44, sqlDate(application.getAcknowledgementApproved()));
            ps1.setDate(45, sqlDate(application.getDatePublishedBooksReceived()));
            ps1.setDate(46, sqlDate(application.getDatePaymentMadeToPublisher()));
            ps1.setString(47, application.getPaymentReferenceNumber());
            ps1.setString(48, application.getAddendumRightsAgreement());
            ps1.setString(49, application.getAddendumRightsAgreementName());
            ps1.setString(50, application.getProofOfPaymentToTranslator());
            ps1.setString(51, application.getProofOfPaymentToTranslatorName());
            ps1.setString(52, application.getBankDetailsForm());
            ps1.setString(53, application.getBankDetailsFormName());
            ps1.setString(54, application.getSignedLIContract());
            ps1.setString(55, application.getSignedLIContractName());
            ps1.setString(56, application.getPaymentStatus());
            // ps1.setString(57, application.getPreviousGrantAid());
            ps1.setInt(57, application.getAward());
            ps1.setInt(58, application.getSalesFigures());
            ps1.setTimestamp(59, application.getLASTUPDATED());

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
                    + "Original = ?,\n"
                    + "OriginalName = ?,\n"
                    + "copiesTranslationSample = ?,\n"
                    + "copiesTranslationSampleDocName = ?,\n"
                    + "cover = ?,\n"
                    + "coverName = ?,\n"
                    + "addendumRightsAgreement = ?,\n"
                    + "addendumRightsAgreementName = ?,\n"
                    + "proofOfPaymentToTranslator = ?,\n"
                    + "proofOfPaymentToTranslatorName = ?,\n"
                    + "bankDetailsForm = ?,\n"
                    + "bankDetailsFormName = ?,\n"
                    + "signedLIContract = ?,\n"
                    + "signedLIContractName = ?,\n"
                    + "lastUpdated =  ?"
                    + " WHERE ReferenceNumber = '" + ReferenceNumber + "'"
            );

            ps1.setString(1, application.getAgreement());
            ps1.setString(2, application.getAgreementDocName());
            ps1.setString(3, application.getContract());
            ps1.setString(4, application.getContractDocName());
            ps1.setString(5, application.getTranslatorCV());
            ps1.setString(6, application.getTranslatorCVDocName());
            ps1.setString(7, application.getOriginal());
            ps1.setString(8, application.getOriginalName());
            ps1.setString(9, application.getCopiesTranslationSample());
            ps1.setString(10, application.getCopiesTranslationSampleDocName());
            ps1.setString(11, application.getCover());
            ps1.setString(12, application.getCoverName());
            ps1.setString(13, application.getAddendumRightsAgreement());
            ps1.setString(14, application.getAddendumRightsAgreementName());
            ps1.setString(15, application.getProofOfPaymentToTranslator());
            ps1.setString(16, application.getProofOfPaymentToTranslatorName());
            ps1.setString(17, application.getBankDetailsForm());
            ps1.setString(18, application.getBankDetailsFormName());
            ps1.setString(19, application.getSignedLIContract());
            ps1.setString(20, application.getSignedLIContractName());
            ps1.setTimestamp(21, getcurrentTimeStamp());

            System.out.println("updateDocuments :: ps1:: " + ps1);
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
//                
//                        >>> Order of fieldnames:
// 1 - ApplicationNumber, 
// 2 - ApplicationYear, 
// 3 - ReferenceNumber, 
// 4 - company, 
// 5 - publisherID, 
// 6 - userID, 
// 7 - agreement, 
// 8 - agreementDocName, 
// 9 - contract, 
//10 - contractDocName, 
//11 - proposedDateOfPublication, 
//12 - proposedPrintRun, 
//13 - plannedPageExtent, 
//14 - translatorCV, 
//15 - translatorCVDocName, 
//16 - numberOfPages, 
//17 - translatorFee, 
//18 - breakDownTranslatorFee, 
//19 - Notes, 
//20 - copiesSent, 
//21 - dateCopiesWereSent, 
//22 - Original, 
//23 - OriginalName, 
//24 - copiesTranslationSample, 
//25 - copiesTranslationSampleDocName, 
//26 - TC_ACCEPTED, 
//27 - APPROVED, 
//28 - Status, 
//29 - Cover, 
//30 - CoverName, 
//31 - originalDateOfPublication, 
//32 - originalLanguage, 
//33 - originalPageExtent, 
//34 - countryOfPublication, 
//35 - foreignPublisher, 
//36 - foreignCountry, 
//37 - targetLanguage, 
//38 - boardMeeting, 
//39 - amountRequested, 
//40 - amountApproved, 
//41 - publisherInformedOfMeeting, 
//42 - boardComments_Instructions, 
//43 - contractSentToPublisher, 
//44 - acknowledgementApproved, 
//45 - datePublishedBooksReceived, 
//46 - datePaymentMadeToPublisher, 
//47 - paymentReferenceNumber, 
//48 - addendumRightsAgreement, 
//49 - addendumRightsAgreementName, 
//50 - proofOfPaymentToTranslator, 
//51 - proofOfPaymentToTranslatorName, 
//51 - bankDetailsForm, 
//53 - bankDetailsFormName, 
//54 - signedLIContract, 
//55 - signedLIContractName, 
//56 - paymentStatus, 
//57 - previousGrantAid, 
//58 - award, 
//59 - salesFigures 
//60 - lastUpdated application

                application.setApplicationNumber(res.getInt(1));
//                System.out.println("GrantApplicationDAO :: getAllApplications   ApplicationNumber:  " + res.getInt(1));
                application.setApplicationYear(res.getString(2));
//                System.out.println("GrantApplicationDAO :: getAllApplications   ApplicationYear:  " + res.getString(2));
                application.setReferenceNumber(res.getString(3));
//                System.out.println("GrantApplicationDAO :: getAllApplications   ReferenceNumber:  " + res.getString(3));
                application.setCompany(res.getString(4));
                application.setPublisherID(res.getInt(5));
                application.setUserID(res.getString(6));
                application.setAgreement(res.getString(7));
                application.setAgreementDocName(res.getString(8));
                application.setContract(res.getString(9));
                application.setContractDocName(res.getString(10));
                application.setProposedDateOfPublication(res.getDate(11));
                application.setProposedPrintRun(res.getInt(12));
                application.setPlannedPageExtent(res.getInt(13));
                application.setTranslatorCV(res.getString(14));
                application.setTranslatorCVDocName(res.getString(15));
                application.setNumberOfPages(res.getInt(16));
                application.setTranslatorFee(res.getBigDecimal(17));
                application.setBreakDownTranslatorFee(res.getString(18));
                application.setBookNotes(res.getString(19));
                application.setCopiesSent(res.getInt(20));
                application.setDateCopiesWereSent(res.getDate(21));
                application.setOriginal(res.getString(22));
                application.setOriginalName(res.getString(23));
                application.setCopiesTranslationSample(res.getString(24));
                application.setCopiesTranslationSampleDocName(res.getString(25));
                application.setTC_ACCEPTED(res.getInt(26));
                application.setAPPROVED(res.getInt(27));
                application.setStatus(res.getString(28));
//                application.setApplicationYear(res.getString(27));
                application.setCover(res.getString(29));
                application.setCoverName(res.getString(30));
//                application.setOriginalDateOfPublication(res.getDate(31));
                application.setPublicationYear(res.getString(31));
                application.setOriginalLanguage(res.getString(32));
                application.setOriginalPageExtent(res.getInt(33));
                application.setCountryOfPublication(res.getString(34));
                application.setForeignPublisher(res.getString(35));
                application.setForeignCountry(res.getString(36));
                application.setTargetLanguage(res.getString(37));
                application.setBoardMeeting(res.getDate(38));
                application.setAmountRequested(res.getBigDecimal(39));
                application.setAmountApproved(res.getBigDecimal(40));
                application.setPublisherInformedOfMeeting(res.getDate(41));
                application.setBoardComments_Instructions(res.getString(42));
                application.setContractSentToPublisher(res.getDate(43));
                application.setAcknowledgementApproved(res.getDate(44));
                application.setDatePublishedBooksReceived(res.getDate(45));
                application.setDatePaymentMadeToPublisher(res.getDate(46));
                application.setPaymentReferenceNumber(res.getString(47));
                application.setAddendumRightsAgreement(res.getString(48));
                application.setAddendumRightsAgreementName(res.getString(49));
                application.setProofOfPaymentToTranslator(res.getString(50));
                application.setProofOfPaymentToTranslatorName(res.getString(51));
                application.setBankDetailsForm(res.getString(52));
                application.setBankDetailsFormName(res.getString(53));
                application.setSignedLIContract(res.getString(54));
                application.setSignedLIContractName(res.getString(55));
                application.setPaymentStatus(res.getString(56));
                //        application.setPreviousGrantAid(previousGrantAid);
                application.setAward(res.getInt(58));
                application.setSalesFigures(res.getInt(59));
                application.setLASTUPDATED(res.getTimestamp(60));

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
        System.out.println("convert Java Date to SQL Date  " + javaDate);
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

        if (nextApplicationNumber == 0) {
            nextApplicationNumber++;
        }

        return nextApplicationNumber;
    }

    public static int ifAuthorExist(String authorName) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        int authorId = 0;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT idAuthor FROM Author WHERE Name = ?");
            ps.setString(1, authorName);
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

    public static int ifTranslatorExist(String translatorName) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        int idTranslator = 0;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT idTranslator FROM Translator WHERE Name = ?");
            ps.setString(1, translatorName);
            res = ps.executeQuery();

            if (res != null) {

                while (res.next()) {
                    idTranslator = res.getInt(1);
                }
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {

            LOGGER.debug(e.getMessage());

            DBConn.close(conn, ps, res);

            throw new DBException("3 Excepion while accessing database");
        }

        return idTranslator;
    }

    public static int ifLanguageExist(String language) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        int idLanguage = 0;

        language = language.trim();

        try {

            System.out.println("ifLanguageExist: language:: " + language);

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT id FROM Languages WHERE lang = ?");

            ps.setString(1, language);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {
                    idLanguage = res.getInt(1);

                }
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {

            LOGGER.debug(e.getMessage());

            DBConn.close(conn, ps, res);

            throw new DBException("3 Excepion while accessing database");
        }

        return idLanguage;
    }

    public static int insertNewAuthor(String ReferenceNumber, String FullName, String FirstName, String LastName) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        ResultSet res = null;

        int authorId = 0;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = "INSERT INTO  Author (ReferenceNumber, Name, FirstName, LastName) values (?,?,?,?)";

            ps1 = conn.prepareStatement(sql);
            ps1.setString(1, ReferenceNumber);
            ps1.setString(2, FullName);
            ps1.setString(3, FirstName);
            ps1.setString(4, LastName);

            ps1.executeUpdate();

            System.out.println("Name  " + FullName + ", FirstName  " + FirstName + ", LastName  " + LastName);

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    authorId = res.getInt(1);

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

    public static int insertNewTranslator(String Name) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        ResultSet res = null;

        int idTranslator = 0;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = "INSERT INTO  Translator (Name) values (?)";

            ps1 = conn.prepareStatement(sql);

            ps1.setString(1, Name);

            ps1.executeUpdate();

            System.out.println("Name  " + Name);

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    idTranslator = res.getInt(1);
                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {

            LOGGER.debug(e.getMessage());

            DBConn.close(conn, ps1, ps2, res);

            throw new DBException("4 Excepion while accessing database");
        }

        return idTranslator;
    }

    public static int insertLanguages_Library(int idLanguages, String lang, int bookID, String ReferenceNumber) throws DBException {
        System.out.println("GrantApplicationDAO.insertLanguages_Library(  " + idLanguages + " languages " + lang + " bookID " + bookID + " ReferenceNumber " + ReferenceNumber);
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        ResultSet res = null;

        int idLanguages_Library = 0;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = "INSERT INTO  Languages_Library (idLanguages, lang, bookID, ReferenceNumber) values (?,?,?,?)";

            ps1 = conn.prepareStatement(sql);

            ps1.setInt(1, idLanguages);
            ps1.setString(2, lang);
            ps1.setInt(3, bookID);
            ps1.setString(4, ReferenceNumber);

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    idLanguages_Library = res.getInt(1);
                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {

            LOGGER.debug(e.getMessage());

            DBConn.close(conn, ps1, ps2, res);

            throw new DBException("4 Excepion while accessing database");
        }

        return idLanguages_Library;
    }

    public static int getExpertReaderUserID(String expertReaderName) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        int idExpertReaderUserID = 0;

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT userID FROM users WHERE fullName LIKE ?");

            ps.setString(1, "%" + expertReaderName + "%");
            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {
                    idExpertReaderUserID = res.getInt(1);
                }
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {

            LOGGER.debug(e.getMessage());

            DBConn.close(conn, ps, res);

            throw new DBException("3 Excepion while accessing database");
        }

        return idExpertReaderUserID;
    }

    public static int updateExpertReader(ExpertReader expertReader, java.sql.Date today) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        ResultSet res = null;

        int idExpertReader = 0;

        try {

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = "INSERT INTO expertReader (expertReaderUserID, referenceNumber, sampleSentOut) values (?,?,?)";

            ps1 = conn.prepareStatement(sql);

            ps1.setInt(1, expertReader.getExpertReaderUserID());
            ps1.setString(2, expertReader.getReferenceNumber());
            ps1.setDate(3, today);

            ps1.executeUpdate();

            ps2 = conn.prepareStatement("SELECT LAST_INSERT_ID()");
            res = ps2.executeQuery();

            if (res != null) {
                while (res.next()) {

                    idExpertReader = res.getInt(1);

                }
            }

            conn.commit();

            DBConn.close(conn, ps1, ps2, res);

        } catch (ClassNotFoundException | SQLException e) {

            LOGGER.debug(e.getMessage());

            DBConn.close(conn, ps1, ps2, res);

            throw new DBException("4 Excepion while accessing database");
        }

        return idExpertReader;
    }

    public static String getExpertReaderEmail(String expertReaderName) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String expertReaderEmail = "";

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT email FROM users WHERE fullName LIKE ?");

            ps.setString(1, "%" + expertReaderName + "%");
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    expertReaderEmail = res.getString(1);
                }
            }
            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("3 Excepion while accessing database");
        }

        return expertReaderEmail;
    }

    public static List<String[]> getAttachments(String newAssignedReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        List<String[]> attachments = new ArrayList<>();

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT Original, OriginalName, copiesTranslationSample, copiesTranslationSampleDocName "
                    + "FROM GrantApplication WHERE ReferenceNumber = ?");

            ps.setString(1, newAssignedReferenceNumber);

            res = ps.executeQuery();

            ResultSetMetaData metadata = res.getMetaData();
            int numcols = metadata.getColumnCount();

            while (res.next()) {

                String[] attachmentDetails = new String[6];

                int i = 1;

                while (i <= numcols) {

                    attachmentDetails[i] = res.getString(i++);

                }

                attachments.add(attachmentDetails);
            }

            DBConn.close(conn, ps, res);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("3 Excepion while accessing database");
        }

        return attachments;
    }

    private static java.sql.Timestamp getCurrentTimeStamp() {

        java.util.Date today = new java.util.Date();
        return new java.sql.Timestamp(today.getTime());

    }
}
