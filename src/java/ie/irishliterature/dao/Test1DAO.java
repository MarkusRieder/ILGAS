package ie.irishliterature.dao;

import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.db.EntryDb;
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
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import org.apache.log4j.Logger;

public class Test1DAO {

    private static final Logger LOGGER = Logger.getLogger(Test1DAO.class.getName());

    private static List<GrantApplication> GrantApplicationData = null;

    private static ArrayList<String> titleList = new ArrayList<>();

    @SuppressWarnings("unchecked")
    public static int getSizeOfApplications() throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        int size = 0;

        try {
            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT COUNT(*) FROM ILGAS.GrantApplication");

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    size = res.getInt(1);

                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        //  System.out.println("getSizeOfApplications  " + size);
        return size;
    }

    @SuppressWarnings("unchecked")
    public static List<GrantApplication> getAllApplications() throws ClassNotFoundException, DBException {
        int counter = 1;
        if (GrantApplicationData == null) {

            GrantApplicationData = new LinkedList<GrantApplication>();
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet res = null;

            ArrayList<String> translatorTrackId; // contains array with translator id's
            ArrayList<String> authorList = new ArrayList<>();
            ArrayList<String> translatorNamesList = new ArrayList<>();
            ArrayList<String> singleTranslatorTrackList = new ArrayList<>();
            List<List<String>> translatorTrackList = new ArrayList<>();
            List<List<String>> listOfTranslatorArray;
            List<List<String>> rightsAgreementArray;
            ArrayList<String> pressCoverage = new ArrayList<>();
            ArrayList<String> translatorNameList = new ArrayList<>();

            String searchQuery = "SELECT * FROM ILGAS.GrantApplication ORDER BY ApplicationYear";

            try {

                conn = DBConn.getConnection();

                ps = conn.prepareStatement(searchQuery);

                res = ps.executeQuery(searchQuery);

                while (res.next()) {

                    //  System.out.println("\n\n================================= Start: " + counter + "  =================================================\n\n");
                    GrantApplication application = new GrantApplication();

                    String ReferenceNumber = res.getString("ReferenceNumber");

                    application.setApplicationNumber(res.getInt("ApplicationNumber"));
                    application.setApplicationYear(res.getString("ApplicationYear"));
                    application.setReferenceNumber(ReferenceNumber);
                    application.setCompany(res.getString("company"));
                    application.setPublisherID(res.getInt("publisherID"));
                    application.setUserID(res.getString("userID"));

                    String[] bookTitle = getBookTitle(ReferenceNumber);
                    //  System.out.println("bookTitle:  " + bookTitle[0]);

                    application.setBookTitle(bookTitle[0]);

//                    ArrayList<String[]> documentListing = new ArrayList<>();
//
//                    documentListing = getDocuments(ReferenceNumber);
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
                    String Notes = getBookNotes(ReferenceNumber);
                    application.setBookNotes(Notes);
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
                    application.setPublicationYear(res.getString("publicationYear"));
                    application.setOriginalLanguage(res.getString("originalLanguage"));
                    application.setOriginalPageExtent(res.getInt("originalPageExtent"));
                    application.setCountryOfPublication(res.getString("countryOfPublication"));
                    application.setForeignPublisher(res.getString("foreignPublisher"));
                    application.setForeignCountry(res.getString("foreignCountry"));
                    application.setTargetLanguage(res.getString("targetLanguage"));
                    application.setAmountRequested(res.getBigDecimal("amountRequested"));
                    application.setAward(res.getInt("award"));
                    application.setSalesFigures(res.getInt("salesFigures"));
                    application.setPreviousGrantAid(getPreviousGrantAid(ReferenceNumber));
                    application.setGenre(bookTitle[1]);
                    application.setBoardComments_Instructions(res.getString("boardComments_Instructions"));

                    String expertReaderName = getExpertReaderName(ReferenceNumber);

                    application.setExpertReaderName(expertReaderName);

                    ArrayList<String> rightsAgreementList;
                    rightsAgreementArray = new ArrayList<>();

                    rightsAgreementList = getRightsAgreement(ReferenceNumber);
                    rightsAgreementArray.add(rightsAgreementList);

                    application.setRightsAgreement(rightsAgreementList);
                    /*
                     * get all idTranslator id's for that ReferenceNumber return
                     * ArrayList
                     * translatorTrackId: [500, 1166, 1164, 1165]
                     */
                    translatorTrackId = getTranslatorTrackId(ReferenceNumber);

                    translatorNamesList = new ArrayList<>();

                    authorList = getAuthors(ReferenceNumber);
                    application.setAuthor(authorList);

                    ArrayList<String> translatorDocsList;
                    listOfTranslatorArray = new ArrayList<>();
                    translatorDocsList = getTransDocs(ReferenceNumber);

                    listOfTranslatorArray.add(translatorDocsList);

                    translatorTrackList = new ArrayList<>();
                    /*
                     * iterate through all translators in translatorTrackId
                     */
                    for (int i = 0; i < translatorTrackId.size(); i++) {

                        translatorNameList = new ArrayList<>();

                        titleList = new ArrayList<>();

                        String translatorNameForList = getTranslatorNames(translatorTrackId.get(i));

                        translatorNamesList.add(translatorNameForList);

                        translatorNameList.add(translatorNameForList);

                        singleTranslatorTrackList.clear();
                        singleTranslatorTrackList = getTranslatorTracker(translatorTrackId.get(i));
                        translatorTrackList.add(singleTranslatorTrackList);

                        titleList = getTitles(ReferenceNumber);

                    }

                    application.setTransList(listOfTranslatorArray);
                    application.setTranslatorName(translatorNamesList);
                    application.setTranslatorTrack2(translatorTrackList);

                    List<String[]> expertReaderList;
                    expertReaderList = getExpertReader(ReferenceNumber);
                    application.setExpertReaderList(expertReaderList);
                    //  System.out.println("expertReaderList length:  " + expertReaderList.size());

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

                    pressCoverage = getPressCoverage(ReferenceNumber);
                    application.setPressCoverage(pressCoverage);

                    application.setUnassignedExpertReaderList(unassignedExpertReaderList);
//                    application.setTranslatorTitles(mixedList);

//                   //  System.out.println("==================================================================================>");
//                   //  System.out.println("ReferenceNumber   " + ReferenceNumber);
//                   //  System.out.println("mixedList         " + mixedList);
//                   //  System.out.println("titleList         " + titleList);
//                   //  System.out.println("<==================================================================================");
                    application.setTitles(titleList);
                    application.setStatus(res.getString("Status"));
                    application.setNotesAboutApplication(res.getString("notesAboutApplication"));
                    application.setApproveWithdrawnReject(res.getString("approveWithdrawnReject"));
                    application.setDirectorChairDecision(res.getInt("directorChairDecision"));

                    GrantApplicationData.add(application);
                    //  System.out.println("================================= End: " + counter + "  =================================================>");
                    counter++;
                }

            } catch (ClassNotFoundException | SQLException e) {
                LOGGER.debug(e.getMessage());
                DBConn.close(conn, ps, res);
                throw new DBException("12 Excepion while accessing database");
            }

            DBConn.close(conn, ps, res);
        }

        return GrantApplicationData;
    }

    @SuppressWarnings("unchecked")
    public static List<EntryDb> getEntryDb() throws ClassNotFoundException, DBException {
        System.out.println("getEntryDb");

        List<EntryDb> retList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        String ReferenceNumber = "";
        String company = "";
        String bookTitle = "";
        String Status = "";
        String Author = "";
        int counter = 0;
        String authorList = "";

        String searchQuery;

        searchQuery = "SELECT ReferenceNumber, company, Status  FROM ILGAS.GrantApplication ORDER BY ApplicationYear";
        System.out.println("Test1DAO  getEntryDb searchQuery  " + searchQuery);

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement(searchQuery);

            res = ps.executeQuery(searchQuery);

            while (res.next()) {
                counter++;
                EntryDb entries = new EntryDb(ReferenceNumber, company, bookTitle, Status, Author);

                ReferenceNumber = res.getString("ReferenceNumber");
                entries.setReferenceNumber(ReferenceNumber);
                entries.setCompany(res.getString("company"));

                String[] bookTitles = getBookTitle(ReferenceNumber);
                entries.setBookTitle(bookTitles[0]);
                authorList = getAuthor(ReferenceNumber);
                entries.setAuthor(authorList);
                entries.setStatus(res.getString("Status"));
                retList.add(entries);
            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        System.out.println("Test1DAO  counter  " + counter);

        return retList;
    }

    public static String getAuthor(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * authorList returns a list with all authors for a specific
         * ReferenceNumber
         */
        String authorList = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT DISTINCT Author.Name\n"
                    + "FROM ILGAS.Author, ILGAS.Application_Author\n"
                    + "WHERE Application_Author.idAuthor = Author.idAuthor\n"
                    + "AND Application_Author.ReferenceNumber =  ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    authorList = authorList + " " + res.getString(1);

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(Test1DAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return authorList.trim();
    }

    @SuppressWarnings("unchecked")
    public static List<EntryDb> getEntryDb1(String status) throws ClassNotFoundException, DBException {
        System.out.println("getEntryDb1");

        List<EntryDb> retList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        String ReferenceNumber = "";
        String company = "";
        String bookTitle = "";
        String Status = "";
        String Author = "";
        int counter = 0;
        String authorList = "";

        String searchQuery;

        searchQuery = "SELECT ReferenceNumber, company, Status  FROM ILGAS.GrantApplication WHERE Status ='" + status + "' ORDER BY ApplicationYear";
        System.out.println("Test1DAO  getEntryDb searchQuery  " + searchQuery);

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement(searchQuery);

            res = ps.executeQuery(searchQuery);

            while (res.next()) {
                counter++;
                EntryDb entries = new EntryDb(ReferenceNumber, company, bookTitle, Status, Author);

                ReferenceNumber = res.getString("ReferenceNumber");
                entries.setReferenceNumber(ReferenceNumber);
                entries.setCompany(res.getString("company"));

                String[] bookTitles = getBookTitle(ReferenceNumber);
                entries.setBookTitle(bookTitles[0]);
                authorList = getAuthor(ReferenceNumber);
                entries.setAuthor(authorList);
                entries.setStatus(res.getString("Status"));
                retList.add(entries);
            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        System.out.println("Test1DAO  counter  " + counter);

        return retList;
    }

    public static boolean updateApplicationOld(GrantApplication app, String ApplicationNumber, String applicationYear) throws SQLException, DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id = false;
        int committed = 0;
        ResultSet res = null;

        Set<String> VALUES = new HashSet<>(Arrays.asList(
                new String[]{"ApplicationNumber", "ApplicationYear", "ReferenceNumber", "company", "publisherID", "userID", "agreement", "agreementDocName", "contract", "contractDocName", "proposedDateOfPublication", "proposedPrintRun", "plannedPageExtent", "translatorCV", "translatorCVDocName", "numberOfPages", "translatorFee", "breakDownTranslatorFee", "Notes", "copiesSent", "dateCopiesWereSent", "Original", "OriginalName",
                    "copiesTranslationSample", "copiesTranslationSampleDocName", "gdpr_ACCEPTED", "TC_ACCEPTED", "APPROVED", "Status", "Cover", "CoverName",
                    "originalDateOfPublication", "publicationYear", "originalLanguage", "originalPageExtent", "countryOfPublication", "foreignPublisher", "foreignCountry",
                    "targetLanguage", "boardMeeting", "amountRequested", "amountApproved", "publisherInformedOfMeeting", "boardComments_Instructions",
                    "contractSentToPublisher", "acknowledgementApproved", "datePublishedBooksReceived", "datePaymentMadeToPublisher", "paymentReferenceNumber",
                    "addendumRightsAgreement", "addendumRightsAgreementName", "proofOfPaymentToTranslator", "proofOfPaymentToTranslatorName", "bankDetailsForm",
                    "bankDetailsFormName", "signedLIContract", "signedLIContractName", "paymentStatus", "previousGrantAid", "award", "salesFigures", "lastUpdated",
                    "Recommendation", "Created", "bilingual", "notesAboutApplication", "approveWithdrawnReject", "directorChairDecision"}
        ));
        int counter = 1;
        System.out.printf("we are here  updateApplication   ");

        String prepStat = "UPDATE ILGAS.GrantApplication SET";

        System.out.printf("xxx  app.getClass().getDeclaredFields().length  " + app.getClass().getDeclaredFields().length);
        int setLength = app.getClass().getDeclaredFields().length;
        for (java.lang.reflect.Field field : app.getClass().getDeclaredFields()) {
            try {
                field.setAccessible(true);

                String col = field.getName();
                Object value = field.get(app);
                System.out.printf("xxx  " + counter + ":  Field name: %s, Field value: %s%n", col, value);

                if (VALUES.contains(col)) {
                    if (counter < setLength - 1) {
                        if (!"ApplicationNumber".equals(col) && !"ApplicationYear".equals(col)) {
                            if (value != null) {
                                prepStat = prepStat + " " + col + " = IFNULL(" + col + ",'" + value + "'), ";
                            }
                        }
                    } else {
//                        if (value != null) {
                        prepStat = prepStat + " " + col + " = IFNULL(" + col + ",'" + value + "') ";
                        System.out.printf("xxx last prepStat " + prepStat);
//                        }
                    }
                }

                counter++;

            } catch (IllegalArgumentException | IllegalAccessException ex) {
                java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        prepStat += " WHERE ApplicationYear = " + applicationYear + " ";
        prepStat += " AND ApplicationNumber = " + ApplicationNumber + ";";

        System.out.printf("xxx  prepStat " + prepStat);
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement(prepStat); //      .prepareStatement(prepStat);

            ps1.executeUpdate();

            conn.commit();

            id = committed > 0;

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            throw new DBException("4 Excepion while accessing database" + e);
        }

        return id;

    }

    public static boolean updateApplication(GrantApplication app, String ApplicationNumber, String applicationYear) throws SQLException, DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id = false;
        int committed = 0;
        ResultSet res = null;
        java.sql.Timestamp timestamp = getcurrentTimeStamp();
        System.out.printf("we are here  updateApplication   ");

        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            ps1 = conn.prepareStatement("UPDATE ILGAS.GrantApplication SET "
                    + " boardMeeting = ? ,"
                    + " amountApproved = ? ,"
                    + " publisherInformedOfMeeting = ? ,"
                    + " contractSentToPublisher = ? ,"
                    + " boardComments_Instructions = ? ,"
                    + " acknowledgementApproved = ? ,"
                    + " datePublishedBooksReceived = ? ,"
                    + " datePaymentMadeToPublisher = ? ,"
                    + " paymentReferenceNumber = ? ,"
                    + " paymentStatus = ? ,"
                    + " award = ? ,"
                    + " proposedPrintRun = ?   ,"
                    + " plannedPageExtent = ?  ,"
                    + " notesAboutApplication = ?  ,"
                    + " Status = ? ,"
                    + " approveWithdrawnReject = ? ,"
                    + " directorChairDecision = ? ,"
                    + " APPROVED = ? ,"
                    + " lastUpdated = ?"
                    + "  WHERE ApplicationYear = '" + applicationYear + "'  AND ApplicationNumber = '" + ApplicationNumber + "';");

            if (app.getBoardMeeting() != null) {
                ps1.setDate(1, sqlDate(app.getBoardMeeting()));
                System.out.println("getBoardMeeting != null " + app.getBoardMeeting());
            } else {
                ps1.setNull(1, java.sql.Types.DATE);
                System.out.println("getBoardMeeting == null " + app.getBoardMeeting());
            }

            ps1.setBigDecimal(2, app.getAmountApproved());

            if (app.getPublisherInformedOfMeeting() != null) {
                ps1.setDate(3, sqlDate(app.getPublisherInformedOfMeeting()));
                System.out.println("getPublisherInformedOfMeeting != null " + app.getPublisherInformedOfMeeting());
            } else {
                ps1.setNull(3, java.sql.Types.DATE);
                System.out.println("getPublisherInformedOfMeeting == null " + app.getPublisherInformedOfMeeting());
            }

            if (app.getContractSentToPublisher() != null) {
                ps1.setDate(4, sqlDate(app.getContractSentToPublisher()));
                System.out.println("getContractSentToPublisher != null " + app.getContractSentToPublisher());
            } else {
                ps1.setNull(4, java.sql.Types.DATE);
                System.out.println("getContractSentToPublisher == null " + app.getContractSentToPublisher());
            }

            ps1.setString(5, app.getBoardComments_Instructions());

            if (app.getAcknowledgementApproved() != null) {
                ps1.setDate(6, sqlDate(app.getAcknowledgementApproved()));
                System.out.println("getAcknowledgementApproved != null " + app.getAcknowledgementApproved());
            } else {
                ps1.setNull(6, java.sql.Types.DATE);
                System.out.println("getAcknowledgementApproved == null " + app.getAcknowledgementApproved());
            }

            if (app.getDatePublishedBooksReceived() != null) {
                ps1.setDate(7, sqlDate(app.getDatePublishedBooksReceived()));
                System.out.println("getDatePublishedBooksReceived != null " + app.getDatePublishedBooksReceived());
            } else {
                ps1.setNull(7, java.sql.Types.DATE);
                System.out.println("getDatePublishedBooksReceived == null " + app.getDatePublishedBooksReceived());
            }

            if (app.getDatePaymentMadeToPublisher() != null) {
                ps1.setDate(8, sqlDate(app.getDatePaymentMadeToPublisher()));
                System.out.println("getDatePaymentMadeToPublisher != null " + app.getDatePaymentMadeToPublisher());
            } else {
                ps1.setNull(8, java.sql.Types.DATE);
                System.out.println("getDatePaymentMadeToPublisher == null " + app.getDatePaymentMadeToPublisher());
            }

            ps1.setString(9, app.getPaymentReferenceNumber());
            ps1.setString(10, app.getPaymentStatus());
            ps1.setInt(11, app.getAward());
            ps1.setInt(12, app.getProposedPrintRun());
            System.out.println("getProposedPrintRun " + app.getProposedPrintRun());
            ps1.setInt(13, app.getPlannedPageExtent());
            System.out.println("getPlannedPageExtent " + app.getPlannedPageExtent());
            ps1.setString(14, app.getNotesAboutApplication());
            ps1.setString(15, app.getStatus());
            ps1.setString(16, app.getApproveWithdrawnReject());
            ps1.setInt(17, app.getDirectorChairDecision());
            ps1.setInt(18, app.getAPPROVED());
            ps1.setTimestamp(19, timestamp);

            System.out.println("ps1:  1: " + ps1);

            ps1.executeUpdate();

            conn.commit();

            id = committed > 0;

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            throw new DBException("4 Excepion while accessing database" + e);
        }

        return id;

    }

    @SuppressWarnings("unchecked")
    public static String getBookNotes(String appRef) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String bookNotes = "";

        try {
            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT referenceNumber, Notes FROM ILGAS.library WHERE referenceNumber = ?");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    bookNotes = res.getString(2);

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        //  System.out.println("getBookNotes(String appRef)  " + bookNotes + " referenceNumber " + appRef);
        return bookNotes;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList<String> getPreviousGrantAid(String appRef) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        int idx = 1;

        /*
         * previousGrantAid
         * author name, title, application year, amount awarded, etc
         */
        ArrayList<String> previousGrantAid = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("# previousGrantAid\n"
                    + "# author name, title, application year, amount awarded, etc \n"
                    + "\n"
                    + "\n"
                    + "\n"
                    + "SELECT \n"
                    + "a.Name as Author,\n"
                    + "l.Title  as Booktitle,\n"
                    + "    ApplicationYear,\n"
                    + "    amountApproved\n"
                    + "    \n"
                    + "FROM\n"
                    + "    ILGAS.GrantApplication g,\n"
                    + "    ILGAS.Application_Author aa,\n"
                    + "    ILGAS.Author a,\n"
                    + "    ILGAS.library l\n"
                    + "WHERE\n"
                    + "    g.ReferenceNumber = ?\n"
                    + "    AND\n"
                    + "    l.referenceNumber = g.ReferenceNumber\n"
                    + "    AND aa.ReferenceNumber = g.ReferenceNumber\n"
                    + "    AND a.idAuthor = aa.idAuthor\n"
                    + "    AND g.amountApproved > 0.00 ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    previousGrantAid.add(idx + ".  - " + res.getString(1) + ", " + res.getString(2) + ", " + res.getString(3) + ", " + res.getString(4) + "\n");
                    idx++;
                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        System.out.print("Test1DAO  previousGrantAid :  " + previousGrantAid.toString());

        return previousGrantAid;

    }

    @SuppressWarnings("unchecked")
    public static ArrayList getTranslatorTrack(String TranslatorTrackId) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

//        ArrayList authorList = new ArrayList<>();
        ArrayList testList = new ArrayList<>();
        ArrayList<String> auth = new ArrayList<>();
        TranslatorTracker translatorTracker;

        try {
            conn = DBConn.getConnection();

            translatorTracker = new TranslatorTracker();

            ps = conn.prepareStatement("SELECT DISTINCT Translator.Name, TranslatorTrack.Title, TranslatorTrack.ReferenceNumber FROM ILGAS.Translator, ILGAS.TranslatorTrack WHERE TranslatorTrack.idTranslator = Translator.idTranslator AND TranslatorTrack.idTranslator = ?");
            ps.setString(1, TranslatorTrackId);

            res = ps.executeQuery();

            translatorTracker.setTranslatorID(TranslatorTrackId);

            int idx = 0;

            if (res != null) {
                while (res.next()) {

//                    if (idx == 0) {
//                        translatorTracker.setTranslatorName(res.getString(1));
                    testList.add(res.getString(1));

//                       //  System.out.println("Test1DAO getTranslatorTrack  setTranslatorName: " + res.getString(1) + " for TranslatorTrackId " + TranslatorTrackId);
//                       //  System.out.println("Test1DAO getTranslatorTrack  testList: " + res.getString(1) + " for TranslatorTrackId " + TranslatorTrackId);
//                    }
//
//                    idx++;
//
//                    auth = new ArrayList<>();
//                    auth = getAuthors(res.getString(3));
//                   //  System.out.println("Test1DAO getTranslatorTrack  auth: " + res.getString(3) + " for TranslatorTrackId " + TranslatorTrackId);
//                    testList.add(auth);
//                    titleList.add(res.getString(2));
//                   //  System.out.println("Test1DAO getTranslatorTrack  titleList: " + res.getString(2) + " for TranslatorTrackId " + TranslatorTrackId);
//                    testList.add(res.getString(2));
                    //       //  System.out.println("Application dao testlist: " + testList);
                    //      //  System.out.println("Application dao getTranslatorTrack  titleList: " + res.getString(2) + " RefNo:  " + res.getString(3));
                }

            }

            translatorTracker.setTitles(titleList);
            //  System.out.println("Test1DAO getTranslatorTrack  translatorTracker: " + translatorTracker + " for TranslatorTrackId " + TranslatorTrackId);

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        //  System.out.println("Test1DAO getTranslatorTrack  testList: " + testList + " for TranslatorTrackId " + TranslatorTrackId);

        return testList;
    }

    public static ArrayList<String> getTitles(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * getTitles returns a list with all Titles for a specific
         * ReferenceNumber
         */
        ArrayList<String> titles = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT DISTINCT\n"
                    + " TranslatorTrack.Title\n"
                    + " FROM\n"
                    + " ILGAS.TranslatorTrack\n"
                    + " WHERE\n"
                    + " TranslatorTrack.ReferenceNumber = ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    titles.add(res.getString(1));

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return titles;
    }

    public static String getTranslatorNames(String translatorTrackId) throws ClassNotFoundException, SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * getTranslatorNames returns a list with all translator names for a
         * specific translatorTrackId
         */
        String aTranslatorName = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Translator.Name FROM ILGAS.Translator WHERE  Translator.idTranslator = ? ");

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

    public static ArrayList<String> getTranslatorTrackId(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * translatorTrackID returns a list with all translators for a specific
         * ReferenceNumber
         */
        ArrayList<String> translatorTrackID = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Translator.idTranslator\n"
                    + " FROM ILGAS.Translator, ILGAS.TranslatorTrack\n"
                    + " WHERE TranslatorTrack.idTranslator = Translator.idTranslator\n"
                    + " AND TranslatorTrack.ReferenceNumber = ? ");

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
         * authorList returns a list with all authors for a specific
         * ReferenceNumber
         */
        ArrayList<String> authorList = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Author.Name\n"
                    + "FROM ILGAS.Author, ILGAS.Application_Author\n"
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
        //  System.out.println("getAuthors AuthorList for ReferenceNumber: " + appRef);
        //  System.out.println("Test1DAO  getAuthors authorList: " + authorList);
        return authorList;
    }

    public static String getExpertReaderName(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * expertReaderName returns a list with the expertReaderName for a
         * specific
         * ReferenceNumber
         */
        String expertReaderName = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT CONCAT(first_name, ' ', last_name) AS `expertReaderName` FROM ILGAS.users, ILGAS.expertReader\n"
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
         * getBookTitle returns a String[] with the bookTitle and Genre for a
         * specific ReferenceNumber
         */
        String[] bookTitle = new String[2];

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Title,Genre FROM ILGAS.library\n"
                    + "WHERE library.referenceNumber  = ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    bookTitle[0] = res.getString(1);
                    bookTitle[1] = res.getString(2);

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return bookTitle;
    }

    public static List<String[]> getExpertReader(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * expertReaderList returns a list with the expertReaderName for a
         * specific ReferenceNumber
         */
        List<String[]> expertReaderList = new ArrayList<>();
        String[] indExpertReaderList = new String[5];

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT referenceNumber, fileDestination, sampleSentOut, sampleReturned, summaryReport, "
                    + "CONCAT(first_name, ' ', last_name) AS `expertReaderName` FROM ILGAS.expertReader, ILGAS.users\n"
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

        //  System.out.println("Test1DAO entering expertReader.... ");

        /*
         * getUnassignedExpertReader returns a list with the expertReaderName
         * NOT
         * assigned to any reference number at the moment
         */
        List<String> UnassignedExpertReaderList = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT  CONCAT(first_name, ' ', last_name) AS `expertReaderName` FROM ILGAS.users\n"
                    + "LEFT JOIN ILGAS.expertReader ON users.userID = expertReader.expertReaderUserID\n"
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
        //  System.out.println("UnassignedExpertReaderList " + UnassignedExpertReaderList);
        return UnassignedExpertReaderList;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList<String> getTranslatorTracker(String TranslatorTrackId) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        ArrayList resultList = new ArrayList<>();
        ArrayList testList = new ArrayList<>();

        TranslatorTracker translatorTracker;

        try {
            conn = DBConn.getConnection();

            translatorTracker = new TranslatorTracker();

            ps = conn.prepareStatement("SELECT DISTINCT\n"
                    + "	ILGAS.Translator.Name,\n"
                    + "	ILGAS.TranslatorTrack.Title,\n"
                    + "	ILGAS.Author.Name,\n"
                    + "	ILGAS.TranslatorTrack.ReferenceNumber\n"
                    + "FROM\n"
                    + "	ILGAS.Author\n"
                    + "	INNER JOIN ILGAS.Application_Author\n"
                    + "	 ON ILGAS.Author.idAuthor = ILGAS.Application_Author.idAuthor\n"
                    + "	INNER JOIN ILGAS.TranslatorTrack\n"
                    + "	 ON ILGAS.Application_Author.ReferenceNumber = ILGAS.TranslatorTrack.ReferenceNumber\n"
                    + "	INNER JOIN ILGAS.Translator\n"
                    + "	 ON ILGAS.TranslatorTrack.idTranslator = ILGAS.Translator.idTranslator\n"
                    + "WHERE\n"
                    + "	ILGAS.Translator.idTranslator =  ?");
            ps.setString(1, TranslatorTrackId);

            res = ps.executeQuery();

            translatorTracker.setTranslatorID(TranslatorTrackId);

            while (res.next()) {

                testList = new ArrayList<>();

                //add translator
                testList.add(res.getString(1));

                //add author
                testList.add(res.getString(3));

                //add book title
                testList.add(res.getString(2));

                //add ReferenceNumber
                testList.add(res.getString(4));

                //add record to resultList
                resultList.add(testList);

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return resultList;
    }

    public static User selectUSER(String uname) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        User pojo = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select uname, EMAIL, FIRST_NAME, LAST_NAME, EMAIL_VERIFICATION_HASH, EMAIL_VERIFICATION_ATTEMPTS, STATUS, CREATED_TIME from ILGAS.users where uname = ?");
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
            ps = conn.prepareStatement("select 1 from ILGAS.users where uname = ? and EMAIL_VERIFICATION_HASH = ?");
            ps.setString(1, uname);
            //  System.out.println("username dao verifyEmailHash: " + uname);
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
            ps = conn.prepareStatement("select 1 from ILGAS.users where uname = ?");
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
        //  System.out.println("insertRow:: ");
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);
            ps1 = conn.prepareStatement("insert into ILGAS.users (uname,FIRST_NAME,LAST_NAME,PASSWORD,EMAIL,FUNCTION,ROLE,EMAIL_VERIFICATION_HASH) values (?,?,?,?,?,?,?,?)");
            ps1.setString(1, pojo.getUSERNAME());
            ps1.setString(2, pojo.getFIRST_NAME());
            ps1.setString(3, pojo.getLAST_NAME());
            ps1.setString(4, pojo.getPASSWORD());
            ps1.setString(5, pojo.getEMAIL());
            ps1.setString(6, pojo.getFUNCTION());
            ps1.setString(7, pojo.getROLE());
            ps1.setString(8, pojo.getEMAIL_VERIFICATION_HASH());

            String uname = pojo.getUSERNAME();
            //  System.out.println("uname dao insertRow: " + uname);

            String strF = pojo.getFUNCTION();
            //  System.out.println("strF: " + strF);

            String em = pojo.getEMAIL();
            //  System.out.println("em: " + em);
            //  System.out.println("isEmailExists Not: create new one: ");

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

        //  System.out.println("userID::insertRow:: " + id);
        return id;
    }

    public static void deleteRow(User pojo) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("delete from ILGAS.users where uname = ?");
            ps.setString(1, pojo.getUSERNAME());
            ps.executeUpdate();
            ps.close();
            DBConn.close(conn, ps);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps);
        }
    }

    public static void updateStatus(String uname, String status) throws DBException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("update ILGAS.users set STATUS = ? where uname = ?");
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
            ps = conn.prepareStatement("update ILGAS.users set EMAIL_VERIFICATION_HASH = ?, EMAIL_VERIFICATION_ATTEMPTS = ? where uname = ?");
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
            ps = conn.prepareStatement("update ILGAS.users set EMAIL_VERIFICATION_ATTEMPTS = EMAIL_VERIFICATION_ATTEMPTS + 1 where uname = ?");
            ps.setString(1, uname);
            ps.executeUpdate();

            ps2 = conn.prepareStatement("SELECT EMAIL_VERIFICATION_ATTEMPTS from ILGAS.users");
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
        //  System.out.println("uname before : " + inputUsername);
        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("select uname, EMAIL, FIRST_NAME, LAST_NAME, STATUS, CREATED_TIME, ROLE, FUNCTION from ILGAS.users where uname = ? and PASSWORD = ?");
            ps.setString(1, inputUsername);
            ps.setString(2, inputPassword);
//           //  System.out.println("Userdao 1 verifyLogin");
//           //  System.out.println("uname after: " + inputUsername);
//           //  System.out.println("ps: " + ps);

            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    pojo = new User();

                    //  System.out.println("Userdao 2 verifyLogin");
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
            ps = conn.prepareStatement("select 1 from ILGAS.users where uname = ? and PASSWORD = ?");
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
            ps = conn.prepareStatement("update ILGAS.users set PASSWORD = ? where uname = ?");
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
            ps = conn.prepareStatement("update ILGAS.users set EMAIL_VERIFICATION_HASH = ?, EMAIL_VERIFICATION_ATTEMPTS = ?, STATUS = ? where EMAIL = ?");
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
            ps = conn.prepareStatement("select uname, EMAIL, FIRST_NAME, LAST_NAME, EMAIL_VERIFICATION_HASH, EMAIL_VERIFICATION_ATTEMPTS, STATUS, CREATED_TIME from ILGAS.users where EMAIL = ?");
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

    public static ArrayList<String[]> getDocuments(String appRef) {
        //  System.out.println("We are here getDocuments !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * getDocuments returns a list with all document for a specific
         * ReferenceNumber
         */
        ArrayList<String[]> documentList = new ArrayList<>();
        String[] documentArray = new String[8];

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT \n"
                    + "    translatorCV,\n"
                    + "    translatorCVDocName,\n"
                    + "    Agreement,\n"
                    + "    AgreementDocName,\n"
                    + "    Contract,\n"
                    + "    ContractDocName,\n"
                    + "    AddendumRightsAgreement,\n"
                    + "    AddendumRightsAgreementName\n"
                    + "FROM\n"
                    + "    ILGAS.TranslatorTrack\n"
                    + "WHERE ReferenceNumber =  ? ");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    documentArray[0] = res.getString(1);
                    documentArray[1] = res.getString(2);
                    documentArray[2] = res.getString(3);
                    documentArray[3] = res.getString(4);
                    documentArray[4] = res.getString(5);
                    documentArray[5] = res.getString(6);
                    documentArray[6] = res.getString(7);
                    documentArray[7] = res.getString(8);

                    documentList.add(documentArray);
                    ;
                    documentArray = new String[8];

                }
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(ApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);
        //  System.out.println("Test1DAO getDocuments for ReferenceNumber: " + appRef);

        return documentList;
    }

    public static ArrayList<String> getRightsAgreement(String ReferenceNumber) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        ArrayList<String> rightsAgreementArray = new ArrayList<>();
//        ArrayList<ArrayList<String>> rightsAgreementList = new ArrayList<>();
        String[] columnList;// = new String[4];
//        ArrayList<String> translatorDocsLst = new ArrayList<String>();

        /*
         * getUnassignedExpertReader returns a list with the expertReaderName
         * NOT
         * assigned to any reference number at the moment
         */
        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT "
                    + "Agreement, AgreementDocName, "
                    + "Contract, ContractDocName, "
                    + "AddendumRightsAgreement, AddendumRightsAgreementName"
                    + " FROM ILGAS.TranslatorTrack WHERE referenceNumber = ?");

            ps.setString(1, ReferenceNumber);

            res = ps.executeQuery();

            final ResultSetMetaData meta = res.getMetaData();
            final int columnCount = meta.getColumnCount();
//           //  System.out.println("columnCount .... " + columnCount);

            while (res.next()) {

                columnList = new String[6];

//                      0  Agreement, 
//                      1  AgreementDocName, 
//                      2  Contract, 
//                      3  ContractDocName, 
//                      4  AddendumRightsAgreement, 
//                      5  AddendumRightsAgreementName    
//                      0  translatorCV, 
//                      1  translatorCVDocName, 
//                      2  copiesTranslationSample, 
//                      3  copiesTranslationSampleDocName, 
//                      4  Agreement, 
//                      5  AgreementDocName, 
//                      6  Contract, 
//                      7  ContractDocName, 
//                      8  AddendumRightsAgreement, 
//                      9  AddendumRightsAgreementName
                columnList[0] = res.getString(1);
//               //  System.out.println("getRightsAgreement Agreement columnList[0] " + res.getString("Agreement"));
                columnList[1] = res.getString(2);
//               //  System.out.println("getRightsAgreement AgreementDocName columnList[1] " + res.getString("AgreementDocName"));
                columnList[2] = res.getString(3);
//               //  System.out.println("getRightsAgreement Contract columnList[2] " + res.getString("Contract"));
                columnList[3] = res.getString(4);
//               //  System.out.println("getRightsAgreement ContractDocName columnList[3] " + res.getString("ContractDocName"));
                columnList[4] = res.getString(5);
//               //  System.out.println("getRightsAgreement AddendumRightsAgreement columnList[4] " + res.getString("AddendumRightsAgreement"));
                columnList[5] = res.getString(6);
//               //  System.out.println("getRightsAgreement AddendumRightsAgreementName columnList[5] " + res.getString("AddendumRightsAgreementName"));

//                columnList[6] = res.getString(7);
//                columnList[7] = res.getString(8);
//                columnList[8] = res.getString(9);
//                columnList[9] = res.getString(10);
//                    translatorCVLst = new String[5];
//                    translatorCVLst[0] = res.getString(1);
//                    translatorCVLst[1] = res.getString(2);
//                    translatorCVLst[2] = res.getString(3);
//                    translatorCVLst[3] = "TEST"; //res.getString(3);
//                    translatorCVLst[4] = "TEST"; //res.getString(4);
//
////                   //  System.out.println("getTransDocs translatorCVDoc path " + res.getString(2));
//                    translatorDocsLst.add(Arrays.toString(translatorCVLst));
//               //  System.out.println("1  getRightsAgreement .... columnCount  " + columnCount);
//                int col = 0;
//                for (int column = 1; column <= columnCount; ++column) {
//                    String columnName = meta.getColumnName(column);
////                   //  System.out.println("0  getRightsAgreement \t columnName " + columnName + "\t col  " + col + "\t column " + column + " == " + res.getString(columnName));
//                    if (res.getString(column) != null) {
//                       //  System.out.println("1  getRightsAgreement \t columnName " + columnName + "\t col  " + col + "\t column " + column + " == " + res.getString(columnName));
//                        columnList[col] = res.getString(columnName);
//
////                       //  System.out.println("2  getRightsAgreement .... columnList[" + col + "] " +  columnList[col] +
////                               " res.getString(" + column + ") == " + res.getString(column));
//                        col++;
//                    }
//                }
                rightsAgreementArray.add(Arrays.toString(columnList));

                for (int s = 0; s < columnList.length; s++) {
//                   //  System.out.println("getRightsAgreement columnList[" + s + "] " + columnList[s]);

                }

//               //  System.out.println("getRightsAgreement columnList " + Arrays.toString(columnList));
//Info:   1  getRightsAgreement .... 5 == /~markus/test/2018/Discworld Publishers/191/Agreement/Translator Name1/agreement with the translation rights holder.docx
//Info:   1  getRightsAgreement .... 6 == agreement with the translation rights holder.docx
//Info:   1  getRightsAgreement .... 7 == /~markus/test/2018/Discworld Publishers/191/Contract/Translator Name1/contract with the translator.docx
//Info:   1  getRightsAgreement .... 8 == contract with the translator.docx
//Info:   1  getRightsAgreement .... 9 == /~markus/test/2018/Discworld Publishers/191/Addendum/Translator Name1/addendum to the rights agreement.docx
//Info:   1  getRightsAgreement .... 10 == addendum to the rights agreement.docx
//
//Info:   1  getRightsAgreement .... 5 == /~markus/test/2018/Discworld Publishers/191/Agreement/Translator Name2/agreement with the translation rights holder 2.docx
//Info:   1  getRightsAgreement .... 6 == agreement with the translation rights holder 2.docx
//Info:   1  getRightsAgreement .... 7 == /~markus/test/2018/Discworld Publishers/191/Contract/Translator Name2/contract with the translator 2.docx
//Info:   1  getRightsAgreement .... 8 == contract with the translator 2.docx
//Info:   1  getRightsAgreement .... 9 == /~markus/test/2018/Discworld Publishers/191/Addendum/Translator Name2/addendum to the rights agreement 2.docx
//Info:   1  getRightsAgreement .... 10 == addendum to the rights agreement 2.docx
//
//Info:   1  getRightsAgreement .... 1 == /~markus/test/2018/Discworld Publishers/191/Translator_CV/Translator Name1/translator cv 1.docx
//Info:   1  getRightsAgreement .... 2 == translator cv 1.docx
//Info:   1  getRightsAgreement .... 1 == /~markus/test/2018/Discworld Publishers/191/Translator_CV/Translator Name2/translator cv 2.docx
//Info:   1  getRightsAgreement .... 2 == translator cv 2.docx
//
//Info:   2  rightsAgreementList.size .... 2
//Info:   3  getRightsAgreement .... 0 == /~markus/test/2018/Discworld Publishers/191/Translator_CV/Translator Name2/translator cv 2.docx
//Info:   3  getRightsAgreement .... 1 == translator cv 2.docx
            }

        } catch (ClassNotFoundException | SQLException ex) {
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return rightsAgreementArray;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList<String> getTransDocs(String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        // ArrayList<String> translatorCVLst = new ArrayList<>();
        String[] translatorCVLst;// = new String[4];
        ArrayList<String> translatorDocsLst = new ArrayList<>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Translator.Name, TranslatorTrack.translatorCVDocName, TranslatorTrack.translatorCV, TranslatorTrack.copiesTranslationSample, TranslatorTrack.copiesTranslationSampleDocName \n"
                    + "FROM ILGAS.TranslatorTrack\n"
                    + "INNER JOIN ILGAS.Translator ON TranslatorTrack.idTranslator = Translator.idTranslator\n"
                    + "WHERE TranslatorTrack.translatorCVDocName IS NOT NULL  \n"
                    + "AND  TranslatorTrack.ReferenceNumber = ? \n"
                    + "order by TranslatorTrack.idTranslator");

//            ps = conn.prepareStatement("SELECT translatorCVDocName, translatorCV, copiesTranslationSample, copiesTranslationSampleDocName FROM TranslatorTrack "
//                    + "WHERE ReferenceNumber = ?");
            ps.setString(1, ReferenceNumber);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    translatorCVLst = new String[5];
                    translatorCVLst[0] = res.getString(1);
                    translatorCVLst[1] = res.getString(2);
                    translatorCVLst[2] = res.getString(3);
                    translatorCVLst[3] = "TEST"; //res.getString(3);
                    translatorCVLst[4] = "TEST"; //res.getString(4);

//                   //  System.out.println("getTransDocs translatorCVDoc path " + res.getString(2));
                    translatorDocsLst.add(Arrays.toString(translatorCVLst));
                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        //  System.out.println("getTrans translatorDocsLst  " + translatorDocsLst.toString());
        return translatorDocsLst;
    }

    @SuppressWarnings("unchecked")
    public static ArrayList<String> getPressCoverage(String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        ArrayList<String> pressCoverageLst = new ArrayList<>();
        String[] pressCoverageArray;
        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT PressCuttings, PressCuttingsName \n"
                    + "FROM ILGAS.PressCuttings\n"
                    + "WHERE ReferenceNumber = ?");

//            ps = conn.prepareStatement("SELECT translatorCVDocName, translatorCV, copiesTranslationSample, copiesTranslationSampleDocName FROM TranslatorTrack "
//                    + "WHERE ReferenceNumber = ?");
            ps.setString(1, ReferenceNumber);

            res = ps.executeQuery();
            pressCoverageArray = new String[4];
            int idx = 1;
            if (res != null) {
                while (res.next()) {

                    System.out.println("idx  " + idx);
                    System.out.println("getPressCoverage pressCoverageLst Loop res.getString(1)  " + res.getString(1));
                    System.out.println("getPressCoverage pressCoverageLst Loop res.getString(2)  " + res.getString(2));

//                    if (!res.getString(1).contains("Thumbs") || res.getString(1).contains("_thumb.jpg")) {
                    if (!res.getString(1).contains("_thumb.jpg")) {
                        pressCoverageArray[0] = "http://localhost" + res.getString(1).trim();
                        pressCoverageArray[1] = res.getString(2).trim();
                        System.out.println(" !Thumbs res.getString(1)   " + res.getString(1));
                        System.out.println(" !Thumbs  res.getString(2)  " + res.getString(2));
                    } else {
                        pressCoverageArray[2] = "http://localhost" + res.getString(1).trim();
                        pressCoverageArray[3] = res.getString(2).trim();
                        System.out.println(" _thumb.jpg  res.getString(1)  " + res.getString(1));
                        System.out.println(" _thumb.jpg  res.getString(2)  " + res.getString(2));
                        pressCoverageLst.add(Arrays.toString(pressCoverageArray));
                        pressCoverageArray = new String[4];
                    }

                    idx++;

//                    System.out.println("getPressCoverage pressCoverageLst  " + pressCoverageLst.toString());
                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        System.out.println("getPressCoverage pressCoverageLst  " + pressCoverageLst.toString());
        return pressCoverageLst;
    }

    public static java.sql.Timestamp getCurrentTimeStamp() {

        java.util.Date today = new java.util.Date();
        return new java.sql.Timestamp(today.getTime());

    }

    public static java.sql.Timestamp getcurrentTimeStamp() {

        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());

        return currentTimestamp;

    }

    // convert Java Date to SQL Date
    public static java.sql.Date sqlDate(java.util.Date javaDate) {
        System.out.println("convert Java Date to SQL Date  " + javaDate);
        java.util.Date utilStartDate = javaDate;
        java.sql.Date convertSqlDate = new java.sql.Date(utilStartDate.getTime());

        return convertSqlDate;
    }
}
