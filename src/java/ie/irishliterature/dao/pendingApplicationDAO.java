package ie.irishliterature.dao;

import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.model.Library;
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

public class pendingApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(pendingApplicationDAO.class.getName());
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

        ArrayList<String> translatorList;
        List<List<String>> listOfTranslatorArray;
        List<List<String>> rightsAgreementArray;
//        what I want:
//        
//        [TranslatorName1, TranslatorCVName,TranslatorCV]

        String searchQuery = "SELECT * FROM GrantApplication WHERE Status = 'pending' AND publisherID = " + parameter + " ORDER BY ApplicationYear ";

        //        String searchQuery = "SELECT * FROM GrantApplication WHERE Status = 'pending' AND publisherID = " + parameter + " ORDER BY ApplicationYear ";
//        
//        SELECT * FROM GrantApplication WHERE Status = 'pending' AND publisherID = " + parameter
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
                
                
                String[] covers = getCover(ReferenceNumber);
            
                application.setCover(covers[0]);
                application.setCoverName(covers[1]);
                System.out.println("res.getString(cover) " + covers[0] + "  " + covers[1]);
                
                
                

                application.setOriginal(res.getString("original"));
                application.setOriginalName(res.getString("originalName"));

                application.setAgreement(res.getString("agreement"));
                application.setAgreementDocName(res.getString("agreementDocName"));
                application.setContract(res.getString("contract"));
                application.setContractDocName(res.getString("contractDocName"));

                application.setAddendumRightsAgreement(res.getString("addendumRightsAgreement"));
                application.setAddendumRightsAgreementName(res.getString("addendumRightsAgreementName"));

                ArrayList<String> rightsAgreementList;
                rightsAgreementArray = new ArrayList<>();

                rightsAgreementList = getRightsAgreement(ReferenceNumber);
                rightsAgreementArray.add(rightsAgreementList);

                application.setRightsAgreement(rightsAgreementList);

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
                ArrayList<String> translatorDocsList;
                translatorList = new ArrayList<>();
                listOfTranslatorArray = new ArrayList<>();

                authorList = getAuthors(ReferenceNumber);
                application.setAuthor(authorList);
                translatorDocsList = getTransDocs(ReferenceNumber);

                listOfTranslatorArray.add(translatorDocsList);

                application.setTitles(TITLELIST);
                application.setTranslatorName(translatorList);
                application.setTransList(listOfTranslatorArray);
                System.out.println("application.setTransList(listOfTranslatorArray)  " + listOfTranslatorArray);
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

            ps = conn.prepareStatement("SELECT lang FROM languages_Library WHERE ReferenceNumber = ?");

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

            ps = conn.prepareStatement("SELECT Translator.Name, TranslatorTrack.translatorCVDocName, TranslatorTrack.translatorCV, TranslatorTrack.copiesTranslationSample, TranslatorTrack.copiesTranslationSampleDocName \n"
                    + "FROM TranslatorTrack\n"
                    + "INNER JOIN Translator ON TranslatorTrack.idTranslator = Translator.idTranslator\n"
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return aTranslatorName;
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
                    + " FROM TranslatorTrack WHERE referenceNumber = ?");

            ps.setString(1, ReferenceNumber);

            res = ps.executeQuery();

            final ResultSetMetaData meta = res.getMetaData();
            final int columnCount = meta.getColumnCount();
            System.out.println("columnCount .... " + columnCount);

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
                System.out.println("getRightsAgreement Agreement columnList[0] " + res.getString("Agreement"));
                columnList[1] = res.getString(2);
                System.out.println("getRightsAgreement AgreementDocName columnList[1] " + res.getString("AgreementDocName"));
                columnList[2] = res.getString(3);
                System.out.println("getRightsAgreement Contract columnList[2] " + res.getString("Contract"));
                columnList[3] = res.getString(4);
                System.out.println("getRightsAgreement ContractDocName columnList[3] " + res.getString("ContractDocName"));
                columnList[4] = res.getString(5);
                System.out.println("getRightsAgreement AddendumRightsAgreement columnList[4] " + res.getString("AddendumRightsAgreement"));
                columnList[5] = res.getString(6);
                System.out.println("getRightsAgreement AddendumRightsAgreementName columnList[5] " + res.getString("AddendumRightsAgreementName"));

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
////                    System.out.println("getTransDocs translatorCVDoc path " + res.getString(2));
//                    translatorDocsLst.add(Arrays.toString(translatorCVLst));
//                System.out.println("1  getRightsAgreement .... columnCount  " + columnCount);
//                int col = 0;
//                for (int column = 1; column <= columnCount; ++column) {
//                    String columnName = meta.getColumnName(column);
////                    System.out.println("0  getRightsAgreement \t columnName " + columnName + "\t col  " + col + "\t column " + column + " == " + res.getString(columnName));
//                    if (res.getString(column) != null) {
//                        System.out.println("1  getRightsAgreement \t columnName " + columnName + "\t col  " + col + "\t column " + column + " == " + res.getString(columnName));
//                        columnList[col] = res.getString(columnName);
//
////                        System.out.println("2  getRightsAgreement .... columnList[" + col + "] " +  columnList[col] +
////                               " res.getString(" + column + ") == " + res.getString(column));
//                        col++;
//                    }
//                }
                rightsAgreementArray.add(Arrays.toString(columnList));

                for (int s = 0; s < columnList.length; s++) {
                    System.out.println("getRightsAgreement columnList[" + s + "] " + columnList[s]);

                }

                System.out.println("getRightsAgreement columnList " + Arrays.toString(columnList));

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

        System.out.println("2  rightsAgreementArray.size .... " + rightsAgreementArray.size());

        for (int i = 0; i < rightsAgreementArray.size(); i++) {
            System.out.println("3  getRightsAgreement .... " + i + " == " + rightsAgreementArray.get(i));
        }
        return rightsAgreementArray;
    }

    public static ArrayList<String> getTranslatorTrackId(String appRef) {
        
    /*
     * gets ReferenceNumber
     * produces List idTranslator ID's : idTranslatorList
     * uses idTranslatorList to produce List TranslatorTrack containing
     * Translator.Name
     * returns ArrayList with Translator.Name
     */

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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    @SuppressWarnings("unchecked")
    public static String getCompanyNotes(int Company_Number) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String companyNotes = "";

        try {
            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Notes FROM international_publishers WHERE Company_Number = ?");

            ps.setInt(1, Company_Number);

            res = ps.executeQuery();

            if (res != null) {
                while (res.next()) {

                    companyNotes = res.getString(1);

                }

            }

        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.debug(e.getMessage());
            DBConn.close(conn, ps, res);
            throw new DBException("12 Excepion while accessing database");
        }

        DBConn.close(conn, ps, res);
        System.out.println("getCompanyNotes(String Company_Number)  " + companyNotes + " Company_Number " + Company_Number);
        return companyNotes;
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return UnassignedExpertReaderList;
    }
    
        public static String[] getCover(String appRef) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        /*
         * getCover returns a String[] with the Cover and Genre for a
         * specific ReferenceNumber
         */

        String[] ret = new String[2];

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT Cover,CoverName FROM library\n"
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
            java.util.logging.Logger.getLogger(pendingApplicationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        DBConn.close(conn, ps, res);

        return ret;
    }
        
     public static int updateCover(String ApplicationNumber, String moveFileName, String moveFileNameReplaced) throws DBException {
             Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        int id = 0;
        int idTranslator = 0;
        ResultSet res = null;

        try {

            System.out.println("updateCover......................:");

            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String query = "UPDATE library SET  Cover = ?, CoverName = ? WHERE ApplicationNumber = ?";
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
       //updateLibrary
    public static boolean updateLibrary(Library library, String referenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps1 = null;
        boolean id;
        int committed = 0;
        ResultSet res = null;

        System.out.println("doing updateLibrary::  ");
        try {
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = ("UPDATE library SET "
                    + "Title = ?,"
                    + "Publisher = ?,"
                    + "publishingYear = ?,"
                    + "Genre = ?,"
                    + "Series = ?,"
                    + "translationPublisher = ?,"
                    + "translationTitle = ?,"
                    + "translationPublisherYear = ?,"
                    + "physicalDescription = ?,"
                    + "Duplicates = ?,"
                    + "Copies = ?,"
                    + "Notes = ?,"
                    + "ISBN = ?,"
                    + "ISSN = ?,"
                    + "lastUpdated = ?");

            sql += " WHERE referenceNumber = " + referenceNumber;

            ps1 = conn.prepareStatement(sql);

            ps1.setString(1, library.getTitle());
            ps1.setString(2, library.getPublisher());
            ps1.setString(3, library.getPublisheryear());
            ps1.setString(4, library.getGenre());
            ps1.setString(5, library.getSeries());
            ps1.setString(6, library.getTranslationPublisher());
            ps1.setString(7, library.getTranslationTitle());
            ps1.setString(8, library.getTranslationPublisherYear());
            ps1.setString(9, library.getPhysicalDescription());
            ps1.setInt(10, library.getDuplicates());
            ps1.setString(11, library.getCopies());
            ps1.setString(12, library.getNotes());
            ps1.setString(13, library.getISBN());
            ps1.setString(14, library.getISSN());
            ps1.setTimestamp(15, getcurrentTimeStamp());

            ps1.executeUpdate();

            conn.commit();

            id = committed > 0;

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            throw new DBException("4 Excepion while accessing database" + e);
        }
        //    System.out.println("return id::  " + id);
        return id;
    }
}
