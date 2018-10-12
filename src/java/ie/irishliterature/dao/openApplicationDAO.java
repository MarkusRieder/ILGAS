package ie.irishliterature.dao;

import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.model.TranslatorTracker;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import org.apache.log4j.Logger;

public class openApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(openApplicationDAO.class.getName());
    private static final String TRANSLATORNAME = "";
    private static final ArrayList TITLELIST = new ArrayList<>();

    @SuppressWarnings("unchecked")
    public static ArrayList getAllApplications(String parameter) throws ClassNotFoundException, DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        ArrayList listApplications = new ArrayList();
        ArrayList<String> translatorTrackId = new ArrayList<>();
        ArrayList<String> authorList;// = new ArrayList<>();
        //  ArrayList<String> list = new ArrayList<>();

        ArrayList<String> translatorList = new ArrayList<>();
        ArrayList<String> translatorList1 = new ArrayList<>();
        List<List<String>> transList = new ArrayList<List<String>>();
//        what I want:
//        
//        [TranslatorName1, TranslatorCVName,TranslatorCV]

        String searchQuery = "SELECT * FROM GrantApplication WHERE Status = 'open' AND publisherID = " + parameter + " ORDER BY ApplicationYear ";
        System.out.println("SELECT * FROM GrantApplication WHERE Status = 'open' AND publisherID = " + parameter);

        
      //        String searchQuery = "SELECT * FROM GrantApplication WHERE Status = 'open' AND publisherID = " + parameter + " ORDER BY ApplicationYear ";
//        
//        SELECT * FROM GrantApplication WHERE Status = 'open' AND publisherID = " + parameter
//
//bookTitle = getBookTitle(ReferenceNumber);
//
//String bNotes = getBookNotes(ReferenceNumber);
//
//String publicationYear = getPublicationYear(ReferenceNumber);
//
//String expertReaderName = getExpertReaderName(ReferenceNumber);
//
//translatorTrackId = getTranslatorTrackId(ReferenceNumber);
//
//authorList = getAuthors(ReferenceNumber);
//
//expertReaderList = getExpertReader(ReferenceNumber);
//
//unassignedExpertReaderList = getUnassignedExpertReader();
        try {
            //   add contact details 
            conn = DBConn.getConnection();

            ps = conn.prepareStatement(searchQuery);

            res = ps.executeQuery(searchQuery);

            ResultSetMetaData rsmd = res.getMetaData();
            int columnsNumber = rsmd.getColumnCount();

            while (res.next()) {

                for (int i = 1; i <= columnsNumber; i++) {
                    if (i > 1) {
                        //          System.out.print(",  ");
                    }
                    String columnValue = res.getString(i);
                    //      System.out.print("getAllApplications >> i: " + i + " " + rsmd.getColumnName(i) + " :: " + columnValue);
                }
                //  System.out.println("");

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

                String bNotes = getBookNotes(ReferenceNumber);

                application.setBookNotes(bNotes.trim());
                //     application.setTranslatorNotes("translatorNotes");

                application.setCopiesSent(res.getInt("copiesSent"));     
                 
                application.setDateCopiesWereSent(res.getDate("dateCopiesWereSent"));                
                System.out.println("dateCopiesWereSent " + res.getDate("dateCopiesWereSent"));
                
                application.setCopiesTranslationSample(res.getString("copiesTranslationSample"));
                application.setCopiesTranslationSampleDocName(res.getString("copiesTranslationSampleDocName"));
                
                System.out.println("setCopiesTranslationSample " + res.getString("copiesTranslationSample"));
                System.out.println("setCopiesTranslationSampleDocName " + res.getString("copiesTranslationSampleDocName"));
                
                application.setDateCopiesWereSent(res.getDate("dateCopiesWereSent"));
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
//                application.setOriginalDateOfPublication(res.getDate("originalDateOfPublication"));
                application.setOriginalLanguage(res.getString("originalLanguage"));
                application.setOriginalPageExtent(res.getInt("originalPageExtent"));
                application.setCountryOfPublication(res.getString("countryOfPublication"));
                application.setForeignPublisher(res.getString("foreignPublisher"));
                application.setForeignCountry(res.getString("foreignCountry"));
//                application.setTargetLanguage(res.getString("targetLanguage"));
//                System.out.println("targetLanguage   " + res.getString("targetLanguage"));
                application.setAmountRequested(res.getBigDecimal("amountRequested"));
                application.setAward(res.getInt("award"));
                application.setSalesFigures(res.getInt("salesFigures"));

                String publicationYear = getPublicationYear(ReferenceNumber);
                application.setPublicationYear(publicationYear);

                application.setSeries(getSeries(ReferenceNumber));

                application.setLASTUPDATED(getcurrentTimeStamp());
                application.setPublisherID(columnsNumber);
                application.setTranslationTitle(getTranslationTitle(ReferenceNumber));

////                                application.setTargetLanguage(res.getString("targetLanguage"));
//                System.out.println("targetLanguage   " + res.getString("targetLanguage"));
                application.setTargetLanguage(getLanguages(ReferenceNumber));

                application.setGenre(bookTitle[1]);

//                String expertReaderName = getExpertReaderName(ReferenceNumber);
//                application.setExpertReaderName(expertReaderName);
                //get all idTranslator / Translator.Name  for that ReferenceNumber return ArrayList
                translatorTrackId = getTranslatorTrackId(ReferenceNumber);
                ArrayList<String> translatorDocsList = new ArrayList<String>();
                translatorList = new ArrayList<>();
                transList = new ArrayList<>();
                translatorList1 = new ArrayList<>();
//                ArrayList<ArrayList<String>> mixedList = new ArrayList<>();
//                ArrayList<String> testList = new ArrayList<>();
//                titleList = new ArrayList<>();
//
                authorList = getAuthors(ReferenceNumber);
                application.setAuthor(authorList);
                translatorDocsList = getTransDocs(ReferenceNumber);

                for (int i = 0; i < translatorTrackId.size(); i++) {
//                    translatorDocsLst = new ArrayList();
                    String translatorNameForList = getTranslatorNames(translatorTrackId.get(i));
//                    String[] singleArray = new String[5];
                    String[] translatorNameForArray = new String[1];
                    translatorNameForArray[0] = translatorNameForList;

//                    testList = getTranslatorTrack(translatorTrackId.get(i));
                    System.out.println("================================================================================================================");
//                    System.out.println("translatorNameForList  i=" + i + " " + translatorNameForList);
//                    System.out.println("translatorTrackId length   " + translatorTrackId.size());
                    translatorList.add(translatorNameForList);
//                    System.out.println("translatorNameForList length   " + translatorNameForList.length());
//                    System.out.println("translatorNameForList          " + translatorNameForList);
//                    System.out.println("translatorDocsList length        " + translatorDocsList.size());

                    if (translatorDocsList.size() > 0) {
//                        System.out.println("translatorDocsList               " + translatorDocsList.toString());
//                         System.out.println("translatorDocsList.get(i=" + i + "  " + translatorDocsList.get(i));
                        String translatorName = translatorDocsList.get(i).replaceFirst("null", translatorNameForList);
                        System.out.println("translatorName  " + translatorName);
                        translatorList1.add(translatorName);
                        System.out.println("translatorList1 " + translatorList1);
//                  Info:   transList  
//                [
//                    [
//                        [Translator Name5, 
//                        /~markus/test/2018/Discworld Publishers/177/Translator_CV/Translator Name5/translator cv 5.docx, 
//                        translator cv 5.docx, , 
//                        ], 
//                        [Translator Name6, 
//                        /~markus/test/2018/Discworld Publishers/177/Translator_CV/Translator Name6/translator cv 6.docx, 
//                        translator cv 6.docx, , 
//                        ], 
//                        [Translator Name7, 
//                        /~markus/test/2018/Discworld Publishers/177/Translator_CV/Translator Name7/translator cv 7.docx, 
//                        translator cv 7.docx, , 
//                        ], 
//                        [Translator Name8, 
//                        /~markus/test/2018/Discworld Publishers/177/Translator_CV/Translator Name8/translator cv 8.docx, 
//                        translator cv 8.docx, , ]
//                    ]
//                ]
                    }

                    System.out.println("================================================================================================================");

//                    translatorCVList.add(1,translatorNameForList);
//                          what I want:
//        
//        [TranslatorName1, TranslatorCVName,TranslatorCV]
                    // mixedList contains [0] Translator [1..] Titles
//                    mixedList.add(testList);
                }
                transList.add(translatorList1);
//                System.out.println("transList  " + transList.toString());

//                List<String[]> expertReaderList;
//                expertReaderList = getExpertReader(ReferenceNumber);
//                application.setExpertReaderList(expertReaderList);
//                System.out.println("expertReaderList length:  " + expertReaderList.size());
//
//                for (int d = 0; d < expertReaderList.size(); d++) {
//                    String[] strings = expertReaderList.get(d);
//                    System.out.println("Array:  " + d);
//                    application.setExpertReaderList(expertReaderList);
//                    for (int j = 0; j < strings.length; j++) {
//                        System.out.print("expertReaderList :  " + strings[j] + " j: " + j);
//                    }
//                    System.out.println();
//                }
//transList
//                List<String> unassignedExpertReaderList;
//                unassignedExpertReaderList = getUnassignedExpertReader();
//
//                application.setUnassignedExpertReaderList(unassignedExpertReaderList);
//                application.setTranslatorTitles(mixedList);
                application.setTitles(TITLELIST);
                application.setTranslatorName(translatorList);
                application.setTransList(transList);
                System.out.println("application.setTransList(transList)  " + transList);
                application.setStatus(res.getString("Status"));

                listApplications.add(application);

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
    public static String getLanguages(String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String languages = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT lang FROM ILGAS.Languages_Library WHERE ReferenceNumber = ?");

            ps.setString(1, ReferenceNumber);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {
                    languages = languages + " " + res.getString(1);
                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return languages.trim();
    }

    @SuppressWarnings("unchecked")
    public static ArrayList<String> getTransDocs(String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String trans = "";

        // ArrayList<String> translatorCVLst = new ArrayList<>();
        String[] translatorCVLst;// = new String[4];
        ArrayList<String> translatorDocsLst = new ArrayList<String>();

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT translatorCVDocName, translatorCV, copiesTranslationSample, copiesTranslationSampleDocName FROM ILGAS.TranslatorTrack WHERE ReferenceNumber = ?");

            ps.setString(1, ReferenceNumber);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {
                    translatorCVLst = new String[5];
                    translatorCVLst[1] = res.getString(1);
                    translatorCVLst[2] = res.getString(2);
                    translatorCVLst[3] = "TEST"; //res.getString(3);
                    translatorCVLst[4] = "TEST"; //res.getString(4);

                    System.out.println("getTransDocs translatorCVDoc path " + res.getString(2));
                    translatorDocsLst.add(Arrays.toString(translatorCVLst));

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        System.out.println("getTrans translatorDocsLst  " + translatorDocsLst.toString());
        return translatorDocsLst;
    }

    @SuppressWarnings("unchecked")
    public static String getSeries(String referenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String series = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT \n"
                    + "    Series\n"
                    + "FROM\n"
                    + "    library\n"
                    + "WHERE\n"
                    + "    referenceNumber = ?");

            ps.setString(1, referenceNumber);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    series = res.getString(1);

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return series;
    }

    public static String getTranslationTitle(String referenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String translationTitle = "";

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT \n"
                    + "    translationTitle\n"
                    + "FROM\n"
                    + "    library\n"
                    + "WHERE\n"
                    + "    referenceNumber = ?");

            ps.setString(1, referenceNumber);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    translationTitle = res.getString(1);

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return translationTitle;

    }

    @SuppressWarnings("unchecked")
    public static ArrayList getTranslatorTrack(String TranslatorTrackId) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        ArrayList authorList = new ArrayList<>();
        ArrayList testList = new ArrayList<>();
        ArrayList<String> auth = new ArrayList<>();
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
                    System.out.println("Application dao getTranslatorTrack  setTranslatorName: " + res.getString(1));
//                    auth = new ArrayList<>();
                    auth = getAuthors(res.getString(3));
                    testList.add(auth);
                    TITLELIST.add(res.getString(2));
                    testList.add(res.getString(2));

                    //        System.out.println("Application dao testlist: " + testList);
                    //       System.out.println("Application dao getTranslatorTrack  titleList: " + res.getString(2) + " RefNo:  " + res.getString(3));
                }

            }

            translatorTracker.setTitles(TITLELIST);

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
         * translatorTrackID returns a list with all translators for a specific
         * translatorTrackId
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return aTranslatorName;
    }


    /*
     * gets ReferenceNumber
     * produces List idTranslator ID's : idTranslatorList
     * uses idTranslatorList to produce List TranslatorTrack containing
     * Translator.Name
     * returns ArrayList with Translator.Name
     */
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return authorList;
    }

    public static String getExpertReaderName(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * authorList returns a list with the expertReaderName for a specific
         * ReferenceNumber
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return ret;
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return expertReaderList;
    }

    @SuppressWarnings("unchecked")
    public static String getPublicationYear(String appRef) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String publicationYear = "";

        try {
            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT \n"
                    + "    publishingYear\n"
                    + "FROM\n"
                    + "    library\n"
                    + "WHERE\n"
                    + "    referenceNumber = ?");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    publicationYear = res.getString(1);

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);

        return publicationYear;
    }

    @SuppressWarnings("unchecked")
    public static String getBookNotes(String appRef) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String bookNotes = "";

        try {
            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Notes FROM library WHERE referenceNumber = ?");

            ps.setString(1, appRef);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    bookNotes = res.getString(1);

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        System.out.println("getBookNotes(String appRef)  " + bookNotes + " referenceNumber " + appRef);
        return bookNotes;
    }

    public static List<String> getUnassignedExpertReader() {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        System.out.println("entering getUnassignedExpertReader.... ");

        /*
         * getUnassignedExpertReader returns a list with the expertReaderName
         * NOT
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
            java.util.logging.Logger.getLogger(openApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return UnassignedExpertReaderList;
    }
}
