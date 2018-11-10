package ie.irishliterature.servlets;

import static ie.irishliterature.dao.ACpublisherDAO_test.updatePublisher;
import ie.irishliterature.dao.GrantApplicationDAO;
import static ie.irishliterature.dao.GrantApplicationDAO.getAttachments;
import static ie.irishliterature.dao.GrantApplicationDAO.getExpertReaderEmail;
import static ie.irishliterature.dao.GrantApplicationDAO.getExpertReaderUserID;
import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import static ie.irishliterature.dao.GrantApplicationDAO.ifTranslatorExist;
import static ie.irishliterature.dao.GrantApplicationDAO.updateExpertReader;
import static ie.irishliterature.dao.openApplicationDAO.updateApplication;
import static ie.irishliterature.dao.openApplicationDAO.updateLibrary;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.ExpertReader;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.model.Library;
import ie.irishliterature.model.Publisher;
import ie.irishliterature.util.MailUtil;
import java.io.*;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

@WebServlet(name = "OpenApplicationServlet", urlPatterns = {"/OpenApplicationServlet"})
public class OpenApplicationServlet extends HttpServlet {

    private final static Logger LOGGER
            = Logger.getLogger(OpenApplicationServlet.class.getCanonicalName());
    private static final long serialVersionUID = 7908187011456392847L;

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For file upload
    ///
    ////////////////////////////////////////////////////////////////////////////
    private boolean isMultipart;
    private String filePath;
    private String rootPath;
    private final int maxFileSize = 50 * 1024;
    private final int maxMemSize = 4 * 1024;
    //  private File file;
    private String tempPath = "";

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For Application
    ///
    ////////////////////////////////////////////////////////////////////////////
    private int ApplicationNumber = 0;
    private String ReferenceNumber;
    private String company;
    private int publisherID;
    private String userID;
    private String agreement; // path to file
    private String contract;  // path to file
    private String proposedDateOfPublication;
    private int proposedPrintRun;
    private String plannedPageExtent;
    private String translatorCV;
    private String translatorName;
    private String languages;
    private String appTargetLanguage;
    private String translatorNotes;
    private String numberOfPages;
    private String breakDownTranslatorFee;
    private String translatorFee;
    private String bookNotes;
    private String copySent;
    private String dateCopiesWereSent;
    private String copiesTranslationSample;  // path to file
    private String TCACCEPTED;
    private String gdprACCEPTED;
    private String ieAPPROVED;
    private String Status;
    private int copiesSent = 0;
    private int TC_ACCEPTED = 0;
    private int gdpr_ACCEPTED = 0;
    private int APPROVED = 0;
    private String Type;

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For Publisher Contact details Update
    ///
    ////////////////////////////////////////////////////////////////////////////
    private String firstname;
    private String lastname;
    private String Address1;
    private String Address2;
    private String Address3;
    private String Address4;
    private String postCode;
    private String City;
    private String country;
    private String countryCode;
    private String Telephone;
    private String Email;
    private String Fax;
    private String WWW;
    private String DoNotMail;
    private String Bursaries;
    private String Founded;
    private String NumberOfTitles;
    private String companyNotes;
    private String DateModified;

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For Book details
    ///
    ////////////////////////////////////////////////////////////////////////////
    private int bookID;

    private String referenceNumber;

    private ArrayList Author;

    private String authorName;

    private String AuthorFirstName;

    private String AuthorLastName;

    private ArrayList Translator;

    private String writerType;  // options Author, Editor, Translator

    private String Title;

    private String Publisher;

    private String publicationYear;

    private String Genre;

    private String Original;  //file path

    private String Addendum;  //file path

    private String ProofPayment;  //file path

    private String BankDetails;  //file path

    private String SignedLIContract;  //file path

    private String translationTitle;

    private String translationPublisher;

    private String translationPublisherYear;

    private String[] translatorArrayContent;

    private String[] authorArray;  //Array of Author/Title

    private String[] languageArray;

    private ArrayList Languages;

    private String physicalDescription;

    private int Duplicates;

    private String Copies;

    private String originalLanguage;

    private String originalPageExtent;

    private String amountRequested;

    private String targetLanguage;

    private String foreignPublisher;

    private String countryOfPublication;

    private String originalDateOfPublication;

    private String ISBN;

    private String ISSN;

    private String Series = "";

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For Irish Literature Staff
    ///
    ////////////////////////////////////////////////////////////////////////////
    private String TranslatorTrackRecord;  //Array of Author/Title
    private String Cover;                   // path to file
    private String Sample_Sent_out; //  Date
    private String Sample_Returned; //  Date
    private String Reader_Report;
    private String Date_Contract_Sent_to_Publisher; //  Date
    private String Date_ILE_Acknowlegement_Approved; //  Date
    private String Date_Published_Books_Received; //  Date
    private String Date_Payment_Made_to_Publisher; //  Date
    private String Payment_Reference_Number;
    private String Comments_re_Application;
    private String Board_Meeting;
    private String Date_publisher_informed_of_meeting; //  Date 
    private String Award;
    private String Bilingual;
    private int award = 0; //    boolean
    private int bilingual = 0; //    boolean
    private String Amount_Requested;
    private String Amount_Approved;
    private String Comments_about_Meeting;
    private String Proposed_Publication_Date; //  Date
    private String Previous_Grant_Aid; // Array of Author/Title
    private String Press_cuttings;  //  boolean
    private String Sales_figures;
    private String Anthology; //Array of Author/Title
    private String message = "";

    @Override
    public void init() {

        // Get the file location where they would be stored.
        tempPath = "/home/markus/test/tempDir";
        rootPath = "/home/markus/public_html/test";

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        //  String task = "Start New Application";
        //  String[] authorArray;
        //  String task = request.getParameter("AssignExpertReader");
        //  String task = request.getParameter("task");
        //  String name = request.getParameter("name");
        //  String value = request.getParameter("value");
        String task = String.valueOf(request.getSession().getAttribute("task"));

        System.out.println("GrantApplicationServlet :: ");
        System.out.println("HttpSession session :: sess: " + task);
  System.out.println("Here we are >>>>>>>>>.   Open Applications :: OpenApplicationServlet");
        switch (task) {
            case "openApplications":
                System.out.println("openApplicationsn :: ");

                //set Status
                Status = "pending";
                int translatorArrayLength = 0;
                int languageArrayLength = 0;
                //set Timestamp and format
                String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
                Calendar now = Calendar.getInstance();

                //set Year used in filePath
                int year = now.get(Calendar.YEAR);
                String yearInString = String.valueOf(year);
//                String fn;

                int idxFolderNames = 0;
                java.sql.Timestamp timestamp = getcurrentTimeStamp();

                String[] fileNames = new String[6];
                //   String[] justFiles = new String[6];
                List<String> filesToBeMoved = new ArrayList<>();
//                List<String> fileDir = new ArrayList<>();
                List<String> longArrayList = new ArrayList<>();
                List<String> shortArrayList = new ArrayList<>();

//                String[] folderNames = {
//                    "Agreement",
//                    "Contract",
//                    "Addendum",
//                    "Translator_CV",
//                    "Original",
//                    "TranslationSample"
//                };
                try {

                    /*
                     * Check that we have a file upload request
                     */
                    isMultipart = ServletFileUpload.isMultipartContent(request);
                    System.out.println("isMultipart:: " + isMultipart);
                    response.setContentType("text/html;charset=UTF-8");

                    DiskFileItemFactory factory = new DiskFileItemFactory();

                    /*
                     * maximum size that will be stored in memory
                     */
                    factory.setSizeThreshold(maxMemSize);

                    /*
                     * Location to save data that is larger than maxMemSize.
                     */
                    factory.setRepository(new File(tempPath));

                    /*
                     * Create a new file upload handler
                     */
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    /*
                     * maximum file size to be uploaded.
                     */
                    //  upload.setSizeMax(maxFileSize);

                    /*
                     * Parse the request to get file items.
                     */
                    List<FileItem> items = upload.parseRequest(request);

                    for (FileItem item : items) {
                        if (item.isFormField()) {

                            /*
                             * Process regular form field (input
                             * type="text|radio|checkbox|etc", select, etc).
                             * collect all data input from input fileds
                             */
                            String fieldname = item.getFieldName();
                            String fieldvalue = item.getString();

                            System.out.println(fieldname + " >> " + fieldvalue);

                            switch (fieldname) {
                                case "company":
                                    company = fieldvalue;
                                    break;
                                case "Company_Number":
                                    publisherID = Integer.parseInt(fieldvalue);
                                    break;
                                case "firstname":
                                    firstname = fieldvalue;
                                    break;
                                case "lastname":
                                    lastname = fieldvalue;
                                    break;
                                case "Address1":
                                    Address1 = fieldvalue;
                                    break;
                                case "Address2":
                                    Address2 = fieldvalue;
                                    break;
                                case "Address3":
                                    Address3 = fieldvalue;
                                    break;
                                case "Address4":
                                    Address4 = fieldvalue;
                                    break;
                                case "City":
                                    City = fieldvalue;
                                    break;
                                case "postCode":
                                    postCode = fieldvalue;
                                    break;
                                case "Country":
                                    country = fieldvalue;
                                    break;
                                case "Country_Code":
                                    countryCode = fieldvalue;
                                    break;
                                case "Email":
                                    Email = fieldvalue;
                                    break;
                                case "Telephone":
                                    Telephone = fieldvalue;
                                    break;
                                case "Fax":
                                    Fax = fieldvalue;
                                    break;
                                case "WWW":
                                    WWW = fieldvalue;
                                    break;
                                case "doNotMail":
                                    DoNotMail = fieldvalue;
                                    break;
                                case "Bursaries":
                                    Bursaries = fieldvalue;
                                    break;
                                case "Founded":
                                    Founded = fieldvalue;
                                    break;
                                case "NumberOfTitles":
                                    NumberOfTitles = fieldvalue;
                                    break;
                                case "companyNotes":
                                    companyNotes = fieldvalue;
                                    break;
                                case "destination":
                                    Type = fieldvalue;
                                    break;
                                case "userID":
                                    userID = fieldvalue;
                                    break;
                                case "publisherID":
                                    publisherID = Integer.parseInt(fieldvalue);
                                    break;
                                case "proposedDateOfPublication":
                                    proposedDateOfPublication = fieldvalue;
                                    break;
                                case "proposedPrintRun":
                                    String propPrintRun = fieldvalue.replaceAll("[^0-9]", "");
                                    proposedPrintRun = Integer.parseInt(propPrintRun);
                                    break;
                                case "plannedPageExtent":
                                    plannedPageExtent = fieldvalue;
                                    break;
                                case "BreakDownOfTranslatorFee":
                                    breakDownTranslatorFee = fieldvalue;
                                    break;
                                case "translatorName":
                                    translatorName = fieldvalue;
                                    //                 System.out.println("translatorName:: " + translatorName);
                                    break;
                                case "ReferenceNumber":
                                    ReferenceNumber = fieldvalue;
                               System.out.println("ReferenceNumber:: " + ReferenceNumber);
                                    break;                                    
                                case "translatorFee":
                                    translatorFee = fieldvalue;
                                    break;
                                case "translatorNotes":
                                    translatorNotes = fieldvalue;
                                    break;
                                case "copiesSent":
                                    copySent = fieldvalue;
                                    if ("ticked".equals(copySent)) {
                                        copiesSent = 1;
                                    } else {
                                        copiesSent = 0;
                                    }
                                    break;
                                case "dateCopiesWereSent":
                                    dateCopiesWereSent = fieldvalue;
                                    break;
                                case "TCACCEPTED":
                                    TCACCEPTED = fieldvalue;
                                    if ("ticked".equals(TCACCEPTED)) {
                                        TC_ACCEPTED = 1;
                                    } else {
                                        TC_ACCEPTED = 0;
                                    }
                                    break;
                                case "gdprACCEPTED":
                                    gdprACCEPTED = fieldvalue;
                                    //          System.out.println(" gdprACCEPTED  " + gdprACCEPTED);
                                    if ("ticked".equals(gdprACCEPTED)) {
                                        gdpr_ACCEPTED = 1;
                                    } else {
                                        gdpr_ACCEPTED = 0;
                                    }
                                    break;
                                case "Award":
                                    Award = fieldvalue;
                                    if ("ticked".equals(Award)) {
                                        award = 1;
                                    } else {
                                        award = 0;
                                    }
                                    break;
                                case "bilingual":
                                    Bilingual = fieldvalue;
                                    if ("ticked".equals(Bilingual)) {
                                        bilingual = 1;
                                    } else {
                                        bilingual = 0;
                                    }
                                    break;
                                case "APPROVED":
                                    ieAPPROVED = fieldvalue;
                                    if ("ticked".equals(ieAPPROVED)) {
                                        APPROVED = 1;
                                    } else {
                                        APPROVED = 0;
                                    }
                                    break;
                                case "authorArray":
                                    authorArray = fieldvalue.split(","); //split string by ,
                                    //                System.out.println("authorArraylength  GrantApplicationServlet:: " + authorArray.length);
                                    for (String individualValue : authorArray) {
                                        //                    System.out.println("authorArray  GrantApplicationServlet:: " + individualValue);
                                    }
                                    break;
                                case "AuthorFirstName":
                                    AuthorFirstName = fieldvalue;
                                    //                 System.out.println("AuthorFirstName GrantApplicationServlet:: " + AuthorFirstName);
                                    break;
                                case "AuthorLastName":
                                    AuthorLastName = fieldvalue;
                                    //              System.out.println("AuthorLastName GrantApplicationServlet:: " + AuthorLastName);
                                    break;
                                case "bookTitle":
                                    Title = fieldvalue;
                                    System.out.println("Process library Title " + Title);
                                    break;
                                case "copies":
                                    Copies = fieldvalue;
                                    break;
                                case "publicationYear":
                                    publicationYear = fieldvalue;
                                    break;
                                case "genre":
                                    Genre = fieldvalue;
                                    break;
                                case "addendum":
                                    Addendum = fieldvalue;
                                    break;
                                case "proofPayment":
                                    ProofPayment = fieldvalue;
                                    break;
                                case "bankDetailForm":
                                    BankDetails = fieldvalue;
                                    break;
                                case "signedLIcontract":
                                    SignedLIContract = fieldvalue;
                                    break;
                                case "originalSample":
                                    Original = fieldvalue;
                                    break;
                                case "translationTitle":
                                    translationTitle = fieldvalue;
                                    break;
                                case "translationPublicationYear":
                                    translationPublisherYear = fieldvalue;
                                    break;
                                case "translatorArray":
                                    System.out.println("translatorArray >>>> HERE ");
                                    translatorArrayContent = fieldvalue.split(","); //split string by ","
                                    translatorArrayLength = translatorArrayContent.length;
                                    System.out.println("translatorArray >>>> translatorArray.length " + translatorArrayContent.length);
                                    for (String individualValue : translatorArrayContent) {
                                        System.out.println("translatorArray  GrantApplicationServlet:: " + individualValue + " ----------> translatorArrayLength::  " + translatorArrayLength);
                                    }
                                    break;
                                case "languages":
                                    languageArray = fieldvalue.split(","); //split string by ,
                                    for (String individualValue : languageArray) {
                                        //                  System.out.println("languageArray  GrantApplicationServlet:: " + individualValue);
                                    }
                                    break;
                                case "physicalDescription":
                                    physicalDescription = fieldvalue;
                                    break;
                                case "duplicates":
                                    if ("".equals(fieldvalue)) {
                                        fieldvalue = "0";
                                    }
                                    Duplicates = Integer.parseInt(fieldvalue);
                                    break;
                                case "translationPublisher":
                                    translationPublisher = fieldvalue;
                                    break;
                                case "bookNotes":
                                    bookNotes = fieldvalue;
                                    break;
                                case "series":
                                    Series = fieldvalue;
                                    break;
                                case "isbn":
                                    ISBN = fieldvalue;
                                    break;
                                case "issn":
                                    ISSN = fieldvalue;
                                    break;
                                case "languageOfTheOriginal":
                                    originalLanguage = fieldvalue;
                                    break;
                                case "originalPageExtent":
                                    originalPageExtent = fieldvalue;
                                    break;
                                case "countryOfPublication":
                                    countryOfPublication = fieldvalue;
                                    break;
                                case "amountRequested":
                                    amountRequested = fieldvalue;
                                    break;
                                case "appTargetLanguage":
                                    targetLanguage = fieldvalue;
                                    languageArray = fieldvalue.split(","); //split string by ,
                                    languageArrayLength = languageArray.length;
                                    for (String individualValue : languageArray) {
                                        System.out.println("languageArray  GrantApplicationServlet:: " + individualValue);
                                    }
                                    break;
                                case "appForeignCountry":
                                    countryOfPublication = fieldvalue;
                                    break;
                                case "appForeignPublisher":
                                    foreignPublisher = fieldvalue;
                                    break;
                                case "DateOfPublicationOriginal":
                                    originalDateOfPublication = fieldvalue;
                                    break;

                            } // end switch

                        } else {

                            //////////////////////////////////////////////////////////////
                            //  Process Application Form file field (input type="file") //
                            //////////////////////////////////////////////////////////////
                            String fieldname = item.getFieldName();
                            String filename = FilenameUtils.getName(item.getName());
                            System.out.println("filename zero   " + filename);

                            int counter = getCounter(fieldname);
                            String fileName = getFdname(fieldname);
                            System.out.println("translatorArrayContent.length " + translatorArrayContent.length);

                            System.out.println("translatorArrayContent 0  " + translatorArrayContent[0]);

                            for (int g = 0; g < translatorArrayContent.length; g++) {
                                System.out.println("translatorArrayContent before replace  " + translatorArrayContent[g]);
                                translatorArrayContent[g] = translatorArrayContent[g].replaceAll("\\[", "").replaceAll("\\]", "");
                                System.out.println("translatorArrayContent after replace   " + translatorArrayContent[g]);
                            }

                            System.out.println("translatorArrayContent company " + company);
       
                            switch (fileName) {

                                case "Agreement":
                                    if (filename.isEmpty()) {
                                        System.out.println("Agreement zero  filename " + filename);
                                    } else {
                                        filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                                + "Agreement" + File.separator + translatorArrayContent[counter] + File.separator;
                                        fileNames[idxFolderNames] = filePath + filename;
                                        filesToBeMoved.add(fileNames[idxFolderNames]);
                                    }
                                    break;

                                case "Contract":
                                    if (filename.isEmpty()) {
                                        System.out.println("Contract zero  filename " + filename);
                                    } else {
                                        filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                                + "Contract" + File.separator + translatorArrayContent[counter] + File.separator;
                                        fileNames[idxFolderNames] = filePath + filename;
                                        filesToBeMoved.add(fileNames[idxFolderNames]);
                                    }
                                    break;

                                case "Addendum":
                                    if (filename.isEmpty()) {
                                        System.out.println("Addendum zero  filename " + filename);
                                    } else {
                                        filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                                + "Addendum" + File.separator + translatorArrayContent[counter] + File.separator;
                                        fileNames[idxFolderNames] = filePath + filename;
                                        filesToBeMoved.add(fileNames[idxFolderNames]);
                                    }
                                    break;

                                case "Original":
                                    if (filename.isEmpty()) {
                                        System.out.println("Original zero  filename " + filename);
                                    } else {
                                        filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                                + "Original" + File.separator;
                                        fileNames[idxFolderNames] = filePath + filename;
                                        filesToBeMoved.add(fileNames[idxFolderNames]);
                                    }
                                    break;

                                case "TranslationSample":
                                    if (filename.isEmpty()) {
                                        System.out.println("TranslationSample zero  filename " + filename);
                                    } else {
                                        filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                                + "TranslationSample" + File.separator;
                                        fileNames[idxFolderNames] = filePath + filename;
                                        filesToBeMoved.add(fileNames[idxFolderNames]);
                                    }
                                    break;

                                case "Translator_CV":
                                    if (filename.isEmpty()) {
                                        System.out.println("Translator_CV zero  filename " + filename);
                                    } else {
                                        filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                                + "Translator_CV" + File.separator + translatorArrayContent[counter] + File.separator;
                                        fileNames[idxFolderNames] = filePath + filename;
                                        filesToBeMoved.add(fileNames[idxFolderNames]);
                                    }
                                    break;

                            } // end switch

                            /*
                             * create temporary Directory if it does not exist
                             */
                            System.out.println("fileName.equals 1 zero " + fileName + " filePath " + filePath);
                            if (filename.isEmpty()) {
                                System.out.println("fileName.equals 2 zero filename.isEmpty " + fileName + " filePath " + filePath);
                            } else {
                                File file = new File(filePath);
                                if (!file.exists()) {

                                    file.mkdirs();
                                }
                                System.out.println("createTemporaryDirectory");
                                System.out.println("filePath: " + filePath + " filename: " + filename);
                                OutputStream outS = null;
                                InputStream filecontent = null;

                                try {
                                    outS = new FileOutputStream(new File(filePath + filename));

                                    filecontent = item.getInputStream();

                                    message = message + " '" + filename + "' has been uploaded <br/>";

                                    int read;
                                    final byte[] bytes = new byte[1024];

                                    while ((read = filecontent.read(bytes)) != -1) {
                                        outS.write(bytes, 0, read);

                                    }

                                } catch (FileNotFoundException fne) {

                                    String errMsg = "<br/><br/>You either did not specify a file to upload or are "
                                            + "trying to upload a file to a protected or nonexistent "
                                            + "location.<br/> <br/><strong> ERROR:<strong> '" + fne.getMessage() + "' ";

                                    request.setAttribute("message", " '<strong>" + filename + "</strong>" + errMsg);
                                    request.getRequestDispatcher("/WEB-INF/views/uploadErrorResponse.jsp").forward(request, response);
                                    LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}",
                                            new Object[]{fne.getMessage()});

                                } finally {

                                    if (outS != null) {
                                        outS.close();
                                    }

                                    if (filecontent != null) {
                                        filecontent.close();
                                    }
                                }
                            }
                        } // else

                    }  // for (FileItem item : items)

                    ////////////////////////////////////////////////////////////
                    //  Process Application
                    ////////////////////////////////////////////////////////////
                    GrantApplication application = new GrantApplication();

                    application.setReferenceNumber(ReferenceNumber);
                    application.setApplicationYear(yearInString);
                    application.setCompany(company);
                    application.setPublisherID(publisherID);
                    application.setUserID(userID);

                    /*
                     * Book Details
                     */
                    application.setOriginalLanguage(originalLanguage);
                    application.setCountryOfPublication(countryOfPublication);
                    application.setOriginalPageExtent(Integer.parseInt(originalPageExtent));


                    application.setPublicationYear(publicationYear);
                    application.setForeignCountry(countryOfPublication);
                    application.setForeignPublisher(foreignPublisher);

                    /*
                     * Rights Agreement & Contracts
                     */
                    /*
                     * Publication Details
                     */
                    application.setProposedDateOfPublication(convertDate(proposedDateOfPublication));
                    application.setProposedPrintRun(proposedPrintRun);
                    application.setPlannedPageExtent(Integer.parseInt(plannedPageExtent));
                    application.setTargetLanguage(targetLanguage); // we get that from the Languages_Library table
                    application.setBilingual_edition(bilingual);
                    /*
                     * Translator Details
                     */

                    application.setBreakDownTranslatorFee(breakDownTranslatorFee);
                    BigDecimal tf = new BigDecimal(translatorFee.replaceAll(",", ""));
                    application.setTranslatorFee(tf);

                    /*
                     * Original Work & Sample Translation
                     */
                    application.setCopiesSent(copiesSent);
                    application.setDateCopiesWereSent(convertDate(dateCopiesWereSent));
                    application.setTranslatorNotes(translatorNotes);
                    application.setBookNotes(bookNotes);
                    application.setTC_ACCEPTED(TC_ACCEPTED);
                    application.setGdprACCEPTED(gdpr_ACCEPTED);
                    application.setAPPROVED(APPROVED);
                    application.setStatus(Status);

                    System.out.println("send to updateApplication");
                    updateApplication(application, ReferenceNumber);

  
                                                                                                           

                        /*
                         * ReferenceNumber contains ApplicationNumber seperated
                         * by a "/"
                         * find the first occurrence of "/"
                         */
                        int iend = ReferenceNumber.indexOf("/");

                        /*
                         * get ApplicationNumber from ReferenceNumber
                         */
                        if (iend != -1) {
                            ApplicationNumber = Integer.parseInt(ReferenceNumber.substring(0, iend));
                            System.out.println("ApplicationNumber ---->> " + ApplicationNumber);
                        }
                            
                } catch (ParseException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                } catch (FileUploadException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                ////////////////////////////////////////////////////////////
                //  Process Publisher
                ////////////////////////////////////////////////////////////
                Publisher publisher = new Publisher();

                publisher.setCompany(company);
                publisher.setCompany_Number(publisherID);
                publisher.setAddress1(Address1);
                publisher.setAddress2(Address2);
                publisher.setAddress3(Address3);
                publisher.setAddress4(Address4);
                publisher.setPostCode(postCode);
                publisher.setCity(City);
                publisher.setCountry(country);
                publisher.setCountryCode(countryCode);
                publisher.setTelephone(Telephone);
                publisher.setEmail(Email);
                publisher.setFax(Fax);
                publisher.setWWW(WWW);

                String doNotMail;

                if ("true".equals(DoNotMail)) {
                    doNotMail = "1";
                } else {
                    doNotMail = "0";
                }

                publisher.setDoNotMail(doNotMail);

                String bursaries;

                if ("true".equals(Bursaries)) {
                    bursaries = "1";
                } else {
                    bursaries = "0";
                }

                publisher.setBursaries(bursaries);
                publisher.setFounded(Founded);
                publisher.setNumberOfTitles(NumberOfTitles);

                publisher.setDateModified(timeStamp);
                publisher.setNotes(companyNotes);
                publisher.setStatus(Status);

                 {
                    try {
                        updatePublisher(publisher, publisherID);
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                /*
                 * Update GrantApplication to contain the filePaths
                 * =================================================
                 * path = path + File.separator + yearInString + File.separator
                 * + Company + File.separator + Type + ApplicationNumber;
                 * upload to temp dir then move to final directory
                 */
                List<String> translatorFileDetails = new ArrayList<>();

//                der looped sich nen Wolf when inserting into table see filesToBeMoved 4.txt and  TranslatorTrack.csv
//                Run and see System.out.println(" ");
                System.out.println("####################### creating the lists ##################################################");

                System.out.println("filesToBeMoved.size()  " + filesToBeMoved.size());

                for (int i = 0; i < filesToBeMoved.size(); i++) {
                    System.out.println("ffilesToBeMoved.get(i) " + filesToBeMoved.get(i));
                }

                for (int i = 0; i < filesToBeMoved.size(); i++) {

                    String moveFile = "";
                    String moveFileName = "";
                    String destinationDirectory = "";

                    String[] subDirs = filesToBeMoved.get(i).split("(?<!^)/");
                    System.out.println("ffilesToBeMoved.get(i) " + filesToBeMoved.get(i));
                    String decider = subDirs[6];

                    switch (decider) {

                        case "Agreement":
                        case "Contract":
                        case "Addendum":
                        case "Translator_CV":
                            String subDirectory = subDirs[6];  // Addendum
                            String subNameDirectory = subDirs[7];  // Translator Name2
                            moveFileName = subDirs[8];  // addendum to the rights agreement 2.docx 

                            destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator
                                    + ApplicationNumber + File.separator + subDirectory + File.separator + subNameDirectory + File.separator;

                            moveFile = destinationDirectory + moveFileName;
                            translatorFileDetails.add(moveFile);
                            translatorFileDetails.add(moveFileName);

                            System.out.println("filesToBeMoved--" + decider + "--->>>> " + moveFile);

                            longArrayList.add(moveFile);
                            break;

                        case "Original":
                        case "TranslationSample":
                            String Directory = subDirs[6];      // TranslationSample
                            moveFileName = subDirs[7];      // translation sample.docx
                            destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator
                                    + ApplicationNumber + File.separator + Directory + File.separator;
                            System.out.println("filesToBeMoved--Directory--->>>> " + Directory);
                            System.out.println("filesToBeMoved--moveFileName--->>>> " + moveFileName);
                            moveFile = destinationDirectory + moveFileName;
                            shortArrayList.add(moveFile);
                            System.out.println("filesToBeMoved--" + decider + "--->>>> " + moveFile);
                            break;

                    } // switch (decider)


                    /*
                     * create directory if it does not exist
                     */
                    File directory = new File(destinationDirectory);
                    if (!directory.exists()) {
                        directory.mkdirs();
                    }

                    File sFile = new File(filesToBeMoved.get(i));
                    File destDir = new File(destinationDirectory);
//                    fileDir.add(moveFile);
                    FileUtils.moveFileToDirectory(sFile, destDir, true);
                }
                System.out.println("####################### End creating the lists ##################################################");
                ////////////////////////////////////////////////////////////
                //  Process Application Translators
                ////////////////////////////////////////////////////////////
                System.out.println("translatorArray.length: -------------------------->>>> " + translatorArrayContent.length);
                // if we have an array
                if (translatorArrayContent.length > 0) {

                    /*
                     * convert translatorArray to ArrayList Translator
                     */
                    System.out.println("####################### sending files to tables ##################################################");


                    /*
                     * loop through the Translators and insert each into
                     * TranslatorTrack
                     */
                    for (int i = 0; i < longArrayList.size(); i++) {

                        System.out.println("longArrayList---i:[" + i + "]-->>>> " + longArrayList.get(i));

                        String[] elements = longArrayList.get(i).split("(?<!^)/");

                        String moveFile = longArrayList.get(i);
                        String decider = elements[7];
                        translatorName = elements[8];
                        String moveFileName = elements[9];
                        String moveFileNameReplaced = moveFile.replace("/home/markus/public_html", "/~markus");

                        /*
                         * moveFile = the whole path including the file name
                         * = longArrayList.get(i)
                         * moveFileName = fille name = fileName
                         * moveTheFileName = moveFile but with
                         * replace("/home/markus/public_html", "/~markus") =
                         * String moveTheFileName =
                         * moveFile.replace("/home/markus/public_html",
                         * "/~markus");
                         */
                        try {

                            /*
                             * set the variables and
                             * translatorName =
                             * processingTranslatorArray[0];
                             */
                            int idTranslator = ifTranslatorExist(translatorName);

                            /*
                             * insert them into the table TranslatorTrack
                             */
                            switch (decider) {

                                case "Agreement":
                                    System.out.println("insertAgreement:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                                    GrantApplicationDAO.insertAgreement(ReferenceNumber, translatorName, Title, moveFileName, moveFileNameReplaced);
                                    break;
                                case "Contract":
                                    System.out.println("insertContract:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                                    GrantApplicationDAO.insertContract(ReferenceNumber, translatorName, Title, moveFileName, moveFileNameReplaced);
                                    break;
                                case "Addendum":
                                    System.out.println("insertAddendum:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                                    GrantApplicationDAO.insertAddendum(ReferenceNumber, translatorName, Title, moveFileName, moveFileNameReplaced);
                                    break;
                                case "Translator_CV":
                                    // String Translator_CV , String Translator_CV_DocName , fn copiesTranslationSample, fname copiesTranslationSampleDocName
                                    // fn copiesTranslationSample, fname copiesTranslationSampleDocName
                                    // fn and fname are empty at the moment!!!
                                    String fname = "";
                                    String fn = "";
                                    System.out.println("insertTranslators:: translatorName " + translatorName + " longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                                    GrantApplicationDAO.insertTranslators(ReferenceNumber, translatorName, Title, moveFileName, moveFileNameReplaced, fn, fname);
                                    break;

                            } // switch (decider)

                        } catch (DBException ex) {
                            Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }

                } else {  // no array - single Translator
                    System.out.println("===================  no array - single Translator ======================== ");
//                    System.out.println("insertTranslators:: translatorName " + translatorName + " ReferenceNumber " + ReferenceNumber + "Title" + Title + 
//                            "moveFileName " + moveFileName + "moveFileNameReplaced " + moveFileNameReplaced);
                }  // end else

                // Process Original TranslationSample
                for (int i = 0; i < shortArrayList.size(); i++) {
                    System.out.println("shortArrayList---i:[" + i + "]-->>>> " + shortArrayList.get(i));

                    String[] elements = shortArrayList.get(i).split("(?<!^)/");

                    String AppNumber = Integer.toString(ApplicationNumber);   // '195/2018' ---> 195

//                    for (int l = 0; l < elements.length; l++) {
                    try {
//                            System.out.println("elements---i:[" + l + "]-->>>> " + elements[l]);

                        String moveFile = shortArrayList.get(i);
                        String decider = elements[7];      // Original
                        String moveFileName = elements[8]; // copy of original work.docx
                        String moveFileNameReplaced = moveFile.replace("/home/markus/public_html", "/~markus");

                        switch (decider) {

                            case "Original":
                                System.out.println("insertOriginal:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                                GrantApplicationDAO.insertOriginal(AppNumber, moveFileName, moveFileNameReplaced);

                                break;
                            case "TranslationSample":
                                System.out.println("insertTranslationSample:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                                GrantApplicationDAO.insertTranslationSample(AppNumber, moveFileName, moveFileNameReplaced);
                                break;

                        } // switch (decider)
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
//                    }
                }
                System.out.println("####################### End sending files to tables ##################################################");
                ////////////////////////////////////////////////////////////
                //  Process Library
                ////////////////////////////////////////////////////////////
                Library library = new Library();
                System.out.println("Process library");

                library.setTitle(Title);
                library.setPublisher(company);
                library.setPublisheryear(publicationYear);
                library.setGenre(Genre);
                library.setSeries(Series);
                library.setTranslationPublisher(translationPublisher);
                library.setTranslationTitle(translationTitle);
                library.setTranslationPublisherYear(translationPublisherYear);
                library.setPhysicalDescription(physicalDescription);
                library.setDuplicates(Duplicates);
                library.setCopies(Copies);
                library.setNotes(bookNotes);
                library.setISBN(ISBN);
                library.setISSN(ISSN);
              

                 {
                    try {
                        boolean succ = updateLibrary(library, referenceNumber);
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                /*
                 * reset session
                 */
                session.removeAttribute("task");

                request.setAttribute("message", message);
                request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);
                break;

            case "New Applications":
                System.out.println("New Applications :: ");
                System.out.println("task: GrantApplicationServlet:: 1 " + task);
                request.getRequestDispatcher("/WEB-INF/views/newApplications.jsp").forward(request, response);
                break;

            case "Open Applications":
                System.out.println("Open Applications :: ");
                System.out.println("task: GrantApplicationServlet:: 2 " + task);
                request.getRequestDispatcher("/WEB-INF/views/openApplications.jsp").forward(request, response);
                break;

            case "Pending Applications":
                System.out.println("Pending Applications :: ");
                System.out.println("task: GrantApplicationServlet:: 3 " + task);
                request.getRequestDispatcher("/WEB-INF/views/pendingApplications.jsp").forward(request, response);
                break;

            case "Closed Applications":
                System.out.println("Closed Applications :: ");
                System.out.println("task: GrantApplicationServlet:: 4 " + task);
                request.getRequestDispatcher("/WEB-INF/views/closedApplications.jsp").forward(request, response);
                break;

            case "AssignExpertReader":
                String expertReaderEmail = "";
                List<String[]> fileAttachment = new ArrayList<>();

                String expertReaderName = request.getParameter("selectedUnassignedER");
                String expectedReturnDate = request.getParameter("expectedReturnDate");

                String newAssignedReferenceNumber = request.getParameter("NewAssignedERRefNo");

                int expertReaderUserID = 0;
                try {

                    expertReaderUserID = getExpertReaderUserID(expertReaderName);
                    expertReaderEmail = getExpertReaderEmail(expertReaderName);
                    fileAttachment = getAttachments(newAssignedReferenceNumber);

                } catch (DBException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                String originalPath;
                String originalName = "";
                String translationPath;
                String translationName = "";

                ////////////////////////////////////////////////////////////
                //  Process Application - INSERT new ExpertReader
                ////////////////////////////////////////////////////////////
                ExpertReader expertReader = new ExpertReader();

                expertReader.setExpertReaderUserID(expertReaderUserID);
                expertReader.setExpertReaderName(expertReaderName);
                expertReader.setReferenceNumber(newAssignedReferenceNumber);

                 {
                    try {
                        String[] attachFiles = new String[2];

                        for (String[] filePath : fileAttachment) {

                            originalPath = filePath[1].replace("/~markus", "/home/markus/public_html");
                            originalName = filePath[2];

                            translationPath = filePath[3].replace("/~markus", "/home/markus/public_html");
                            translationName = filePath[4];

                            attachFiles[0] = originalPath;
                            attachFiles[1] = translationPath;

                        }

                        java.sql.Date today = getTodaySQL();
                        int result = updateExpertReader(expertReader, today);

                        if (result > 0) {

                            try {

                                /*
                                 * send email with attachment
                                 */
                                MailUtil.sendEmailWithAttachmentExpertReader(expertReaderName, expertReaderEmail, attachFiles, expectedReturnDate);

                            } catch (MessagingException ex) {
                                Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }

                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                message = "The email to '" + expertReaderName + "' has been sent/ <br/>"
                        + "electronic copies of " + originalName + " and " + translationName + "have been attached";
                request.setAttribute("message", message);
                request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);

                break;

            ////////////////////////////////////////////////////////////
            //  Process openApplications
            ////////////////////////////////////////////////////////////
            case "openApplications213":

                System.out.println("case openApplications: 123");
                Status = "open";
                timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
                now = Calendar.getInstance();
                year = now.get(Calendar.YEAR);
                yearInString = String.valueOf(year);

                timestamp = getcurrentTimeStamp();

                fileNames = new String[10];
                // = new String[10];
                //folderNames = {"Cover", "Agreement", "Contract", "Addendum", "ProofPayment", "BankDetails", "SignedLIContract", "Translator_CV", "Original", "TranslationSample"};
                message = "";

                idxFolderNames = 0;

                try {
                    /*
                     * Check that we have a file upload request
                     */
                    isMultipart = ServletFileUpload.isMultipartContent(request);
                    System.out.println("isMultipart:: " + isMultipart);
                    response.setContentType("text/html;charset=UTF-8");

                    DiskFileItemFactory factory = new DiskFileItemFactory();

                    /*
                     * maximum size that will be stored in memory
                     */
                    factory.setSizeThreshold(maxMemSize);

                    /*
                     * Location to save data that is larger than maxMemSize.
                     */
                    factory.setRepository(new File(tempPath));

                    /*
                     * Create a new file upload handler
                     */
                    ServletFileUpload upload = new ServletFileUpload(factory);

                    /*
                     * maximum file size to be uploaded.
                     */
                    //  upload.setSizeMax(maxFileSize);

                    /*
                     * Parse the request to get file items.
                     */
                    List<FileItem> items = null;
                    try {
                        items = upload.parseRequest(request);
                    } catch (FileUploadException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    for (FileItem item : items) {
                        if (item.isFormField()) {
                            /*
                             * Process regular form field (input
                             * type="text|radio|checkbox|etc", select, etc).
                             * collect all data input from input fileds
                             */
                            String fieldname = item.getFieldName();
                            String fieldvalue = item.getString();

                            System.out.println("fieldname " + fieldname + " fieldvalue >> " + fieldvalue);
                            switch (fieldname) {
                                case "Company":
                                    company = fieldvalue;
                                    break;
                                case "Company_Number":
                                    publisherID = Integer.parseInt(fieldvalue);
                                    break;
                                case "firstname":
                                    firstname = fieldvalue;
                                    break;
                                case "lastname":
                                    lastname = fieldvalue;
                                    break;
                                case "Address1":
                                    Address1 = fieldvalue;
                                    break;
                                case "Address2":
                                    Address2 = fieldvalue;
                                    break;
                                case "Address3":
                                    Address3 = fieldvalue;
                                    break;
                                case "Address4":
                                    Address4 = fieldvalue;
                                    break;
                                case "City":
                                    City = fieldvalue;
                                    break;
                                case "postCode":
                                    postCode = fieldvalue;
                                    break;
                                case "Country":
                                    country = fieldvalue;
                                    break;
                                case "Country_Code":
                                    countryCode = fieldvalue;
                                    break;
                                case "Email":
                                    Email = fieldvalue;
                                    break;
                                case "Telephone":
                                    Telephone = fieldvalue;
                                    break;
                                case "Fax":
                                    Fax = fieldvalue;
                                    break;
                                case "WWW":
                                    WWW = fieldvalue;
                                    break;
                                case "doNotMail":
                                    DoNotMail = fieldvalue;
                                    break;
                                case "Bursaries":
                                    Bursaries = fieldvalue;
                                    break;
                                case "Founded":
                                    Founded = fieldvalue;
                                    break;
                                case "NumberOfTitles":
                                    NumberOfTitles = fieldvalue;
                                    break;
                                case "companyNotes":
                                    companyNotes = fieldvalue;
                                    break;
                                case "destination":
                                    Type = fieldvalue;
                                    break;
                                case "userID":
                                    userID = fieldvalue;
                                    break;
                                case "publisherID":
                                    publisherID = Integer.parseInt(fieldvalue);
                                    break;
                                case "proposedDateOfPublication":
                                    proposedDateOfPublication = fieldvalue;
                                    break;
                                case "proposedPrintRun":
                                    String propPrintRun = fieldvalue.replaceAll("[^0-9]", "");
                                    proposedPrintRun = Integer.parseInt(propPrintRun);
                                    break;
                                case "plannedPageExtent":
                                    plannedPageExtent = fieldvalue;
                                    break;
                                case "BreakDownOfTranslatorFee":
                                    breakDownTranslatorFee = fieldvalue;
                                    break;
                                case "translatorName":
                                    translatorName = fieldvalue;
                                    System.out.println("translatorName:: " + translatorName);
                                    break;
                                case "translatorFee":
                                    translatorFee = fieldvalue;
                                    break;
                                case "translatorNotes":
                                    translatorNotes = fieldvalue;
                                    break;
                                case "copiesSent":
                                    copySent = fieldvalue;
                                    if ("ticked".equals(copySent)) {
                                        copiesSent = 1;
                                    } else {
                                        copiesSent = 0;
                                    }
                                    break;
                                case "dateCopiesWereSent":
                                    dateCopiesWereSent = fieldvalue;
                                    break;
                                case "TCACCEPTED":
                                    TCACCEPTED = fieldvalue;
                                    if ("ticked".equals(TCACCEPTED)) {
                                        TC_ACCEPTED = 1;
                                    } else {
                                        TC_ACCEPTED = 0;
                                    }
                                    break;
                                case "gdprACCEPTED":
                                    gdprACCEPTED = fieldvalue;
                                    //          System.out.println(" gdprACCEPTED  " + gdprACCEPTED);
                                    if ("ticked".equals(gdprACCEPTED)) {
                                        gdpr_ACCEPTED = 1;
                                    } else {
                                        gdpr_ACCEPTED = 0;
                                    }
                                    break;
                                case "Award":
                                    Award = fieldvalue;
                                    if ("ticked".equals(Award)) {
                                        award = 1;
                                    } else {
                                        award = 0;
                                    }
                                    break;
                                case "bilingual":
                                    Bilingual = fieldvalue;
                                    if ("ticked".equals(Bilingual)) {
                                        bilingual = 1;
                                    } else {
                                        bilingual = 0;
                                    }
                                    break;
                                case "APPROVED":
                                    ieAPPROVED = fieldvalue;
                                    if ("ticked".equals(ieAPPROVED)) {
                                        APPROVED = 1;
                                    } else {
                                        APPROVED = 0;
                                    }
                                    break;
                                case "authorArray":
                                    authorArray = fieldvalue.split(","); //split string by ,
                                    System.out.println("authorArraylength  GrantApplicationServlet:: " + authorArray.length);
                                    for (String individualValue : authorArray) {
                                        System.out.println("authorArray  GrantApplicationServlet:: " + individualValue);
                                    }
                                    break;
                                case "AuthorFirstName":
                                    AuthorFirstName = fieldvalue;
                                    System.out.println("AuthorFirstName GrantApplicationServlet:: " + AuthorFirstName);
                                    break;
                                case "AuthorLastName":
                                    AuthorLastName = fieldvalue;
                                    System.out.println("AuthorLastName GrantApplicationServlet:: " + AuthorLastName);
                                    break;
                                case "title":
                                    Title = fieldvalue;
                                    break;
                                case "copies":
                                    Copies = fieldvalue;
                                    break;
                                case "publicationYear":
                                    publicationYear = fieldvalue;
                                    break;
                                case "genre":
                                    Genre = fieldvalue;
                                    break;
                                case "addendum":
                                    Addendum = fieldvalue;
                                    break;
                                case "proofPayment":
                                    ProofPayment = fieldvalue;
                                    break;
                                case "bankDetailForm":
                                    BankDetails = fieldvalue;
                                    break;
                                case "signedLIcontract":
                                    SignedLIContract = fieldvalue;
                                    break;
                                case "originalSample":
                                    Original = fieldvalue;
                                    break;
                                case "translationTitle":
                                    translationTitle = fieldvalue;
                                    break;
                                case "translationPublicationYear":
                                    translationPublisherYear = fieldvalue;
                                    break;
                                case "translatorArray":
                                    System.out.println("translatorArray >>>> HERE ");
                                    translatorArrayContent = fieldvalue.split(","); //split string by ","
                                    translatorArrayLength = translatorArrayContent.length;
                                    System.out.println("translatorArray >>>> translatorArray.length " + translatorArrayContent.length);
                                    for (String individualValue : translatorArrayContent) {
                                        System.out.println("translatorArray  GrantApplicationServlet:: " + individualValue + " ----------> translatorArrayLength::  " + translatorArrayLength);
                                    }
                                    break;
                                case "languages":
                                    languageArray = fieldvalue.split(","); //split string by ,
                                    for (String individualValue : languageArray) {
                                        System.out.println("languageArray  GrantApplicationServlet:: " + individualValue);
                                    }
                                    break;
                                case "physicalDescription":
                                    physicalDescription = fieldvalue;
                                    break;
                                case "duplicates":
                                    if ("".equals(fieldvalue)) {
                                        fieldvalue = "0";
                                    }
                                    Duplicates = Integer.parseInt(fieldvalue);
                                    break;
                                case "translationPublisher":
                                    translationPublisher = fieldvalue;
                                    break;
                                case "bookNotes":
                                    bookNotes = fieldvalue;
                                    break;
                                case "series":
                                    Series = fieldvalue;
                                    break;
                                case "isbn":
                                    ISBN = fieldvalue;
                                    break;
                                case "issn":
                                    ISSN = fieldvalue;
                                    break;
                                case "languageOfTheOriginal":
                                    originalLanguage = fieldvalue;
                                    break;
                                case "pageExtentOfTheOriginal":
//                                    originalPageExtent = fieldvalue;
                                    originalPageExtent = "0";
                                    break;
                                case "countryOfPublication":
                                    countryOfPublication = fieldvalue;
                                    break;
                                case "amountRequested":
                                    amountRequested = fieldvalue;
                                    break;
                                case "appTargetLanguage":
                                    targetLanguage = fieldvalue;
                                    languageArray = fieldvalue.split(","); //split string by ,
                                    languageArrayLength = languageArray.length;
                                    for (String individualValue : languageArray) {
                                        System.out.println("languageArray  GrantApplicationServlet:: " + individualValue);
                                    }
                                    break;
                                case "appForeignCountry":
                                    countryOfPublication = fieldvalue;
                                    break;
                                case "appForeignPublisher":
                                    foreignPublisher = fieldvalue;
                                    break;
                                case "DateOfPublicationOriginal":
                                    originalDateOfPublication = fieldvalue;
                                    break;

                            } // end switch
                        } else {
                            //////////////////////////////////////////////////////////////
                            //  Process Application Form file field (input type="file") //
                            //////////////////////////////////////////////////////////////
                            String fieldname = item.getFieldName();
                            String filename = FilenameUtils.getName(item.getName());
                            System.out.println("fieldname  " + fieldname + " filename >> " + filename);

//                    collect and use openApplicationDAO to UPDATE tables
//
//                            Set STATUS
                        } // else
                    } // for (FileItem item : items)

                    GrantApplication application = new GrantApplication();

                    application.setApplicationYear(yearInString);
                    application.setCompany(company);
                    application.setPublisherID(publisherID);
                    application.setUserID(userID);

                    /*
                     * Book Details
                     */
                    application.setOriginalLanguage(originalLanguage);
                    application.setCountryOfPublication(countryOfPublication);
//                    application.setOriginalPageExtent(Integer.parseInt(originalPageExtent));
//                    application.setOriginalDateOfPublication(convertDate(originalDateOfPublication));
                    application.setPublicationYear(publicationYear);
                    application.setForeignCountry(countryOfPublication);
                    application.setForeignPublisher(foreignPublisher);

                    /*
                     * Rights Agreement & Contracts
                     */
 /*
                     * Publication Details
                     */
                    application.setProposedDateOfPublication(convertDate(proposedDateOfPublication));
                    application.setProposedPrintRun(proposedPrintRun);
//                    application.setPlannedPageExtent(Integer.parseInt(plannedPageExtent));
//                    application.setTargetLanguage(targetLanguage); // we get that from the Languages_Library table
                    application.setBilingual_edition(bilingual);
                    /*
                     * Translator Details
                     */

                    application.setBreakDownTranslatorFee(breakDownTranslatorFee);
                    BigDecimal tf = new BigDecimal(translatorFee.replaceAll(",", ""));
                    application.setTranslatorFee(tf);

                    /*
                     * Original Work & Sample Translation
                     */
                    application.setCopiesSent(copiesSent);
                    application.setDateCopiesWereSent(convertDate(dateCopiesWereSent));
                    application.setTranslatorNotes(translatorNotes);
                    application.setBookNotes(bookNotes);
                    application.setTC_ACCEPTED(TC_ACCEPTED);
                    application.setGdprACCEPTED(gdpr_ACCEPTED);
                    application.setAPPROVED(APPROVED);
                    application.setStatus(Status);

                    try {

                        /*
                         * ReferenceNumber = ApplicationNumber + "/" +
                         * yearInString;
                         */
//                        ReferenceNumber = GrantApplicationDAO.insertRow(application);

                        /*
                         * ReferenceNumber contains ApplicationNumber seperated
                         * by a "/"
                         * find the first occurrence of "/"
                         */
                        int iend = ReferenceNumber.indexOf("/");

                        /*
                         * get ApplicationNumber from ReferenceNumber
                         */
                        if (iend != -1) {
                            ApplicationNumber = Integer.parseInt(ReferenceNumber.substring(0, iend));
                            System.out.println("ApplicationNumber ---->> " + ApplicationNumber);
                        }

                        /*
                         * Process Authors
                         * String[3] => Name, FirstName, LastName
                         */
                        String[] processingAuthorArray = new String[3];

                        /*
                         * convert processingArray to ArrayList Author
                         */
                        Author = new ArrayList<>(Arrays.asList(processingAuthorArray));

                        if (authorArray.length > 1) {

                            int idx = 0;

                            /*
                             * loop through the Authors and insert each into
                             * Author table
                             */
                            for (String individualValue : authorArray) {

                                String AuthorName = individualValue;
                                processingAuthorArray[idx] = AuthorName;

                                System.out.println("AuthorName ---->> " + AuthorName);

                                /*
                                 * when we have a complete set (FullName,
                                 * FirstName, LastName)
                                 */
                                if (idx == processingAuthorArray.length - 1) {

                                    /*
                                     * set the variables and
                                     */
                                    String Name = processingAuthorArray[0];
                                    String FirstName = processingAuthorArray[1];
                                    String LastName = processingAuthorArray[2];

                                    authorName = Name;

                                    /*
                                     * insert them into the tables
                                     * Application_Author
                                     */
//                                    GrantApplicationDAO.insertAuthors(ReferenceNumber, Name, FirstName, LastName);

                                    /*
                                     * reset index
                                     */
                                    idx = -1;
                                }

                                idx++;
                            }
                        } else {
                            authorName = AuthorFirstName + " " + AuthorLastName;
                            System.out.println("authorName ---->> :::: " + authorName);
                            /*
                             * insert them into the tables Application_Author
                             */

//                            GrantApplicationDAO.insertAuthors(ReferenceNumber, authorName, AuthorFirstName, AuthorLastName);
                        }

                    } catch (Exception ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    updateApplication(application, ReferenceNumber);
                } catch (ParseException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

        }

    }

    public void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, java.io.IOException {

        throw new ServletException("GET method used with "
                + getClass().getName() + ": POST method required.");
    }

    public Date convertDate(String datum) throws ParseException {

        DateFormat sourceFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = sourceFormat.parse(datum);

        return date;

    }

    public java.sql.Date getTodaySQL() {
        java.util.Date today = new java.util.Date();
        return new java.sql.Date(today.getTime());

    }

    public int getCounter(String counterIndicator) {

        int counter = 0;

        System.out.println("getCounter(String " + counterIndicator);

        if (counterIndicator.contains("-")) {

            String counterIndicatorArray[] = counterIndicator.split("-");
            for (int u = 0; u < counterIndicatorArray.length; u++) {
                System.out.println("counterIndicatorArray[" + u + "]" + Arrays.toString(counterIndicatorArray));
            }

            counter = Integer.parseInt(counterIndicatorArray[counterIndicatorArray.length - 1]) - 1;
        }

        System.out.println("counter  " + counter);

        return counter;
    }

    public String getFdname(String fieldname) {

        String fdname;

        String fdnameArray[] = fieldname.split("-");

        fdname = fdnameArray[0];

        System.out.println("getFdname(String " + fieldname);
        for (int v = 0; v < fdnameArray.length; v++) {
            System.out.println("fdnameArray[" + v + "]" + Arrays.toString(fdnameArray));
        }

        System.out.println("fdname  " + fdname);

        return fdname;
    }
}
