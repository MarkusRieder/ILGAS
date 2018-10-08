package ie.irishliterature.servlets;

import static ie.irishliterature.dao.ACpublisherDAO_test.updatePublisher;
import ie.irishliterature.dao.GrantApplicationDAO;
import static ie.irishliterature.dao.GrantApplicationDAO.getAttachments;
import static ie.irishliterature.dao.GrantApplicationDAO.getExpertReaderEmail;
import static ie.irishliterature.dao.GrantApplicationDAO.getExpertReaderUserID;
import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import static ie.irishliterature.dao.GrantApplicationDAO.ifLanguageExist;
import static ie.irishliterature.dao.GrantApplicationDAO.ifTranslatorExist;
import static ie.irishliterature.dao.GrantApplicationDAO.updateExpertReader;
import static ie.irishliterature.dao.LibraryDAO.insertBook;
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

@WebServlet(name = "GrantApplicationServlet", urlPatterns = {"/GrantApplicationServlet"})
public class GrantApplicationServlet extends HttpServlet {

    private final static Logger LOGGER
            = Logger.getLogger(GrantApplicationServlet.class.getCanonicalName());
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

    private String[] translatorArray;

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

        //       String task = "Start New Application";
        //        String[] authorArray;
        //   String task = request.getParameter("AssignExpertReader");
        //  String task = request.getParameter("task");
        //  String name = request.getParameter("name");
        //   String value = request.getParameter("value");
        String task = String.valueOf(request.getSession().getAttribute("task"));

        //String testingTheTask = request.getParameter("task");
        //    String TasktestingTheTask = request.getAttribute(task).toString();
        System.out.println("GrantApplicationServlet :: ");
        System.out.println("HttpSession session :: sess: " + task);

        //System.out.println("testingTheTask:: 1 " + testingTheTask);
        switch (task) {
            case "Start New Application":
                System.out.println("Start New Application :: ");
                //set Status
                Status = "open";
                int translatorArrayLength = 0;
                int languageArrayLength = 0;
                //set Timestamp and format
                String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
                Calendar now = Calendar.getInstance();

                //set Year used in filePath
                int year = now.get(Calendar.YEAR);
                String yearInString = String.valueOf(year);
                String fn;

                int idxFolderNames = 0;
                java.sql.Timestamp timestamp = getcurrentTimeStamp();

                String[] fileNames = new String[6];
                //   String[] justFiles = new String[6];
                List<String> filesToBeMoved = new ArrayList<>();
                List<String> fileDir = new ArrayList<>();
                List<String> listCopiesTranslationSample = new ArrayList<>();

                int counter = 0;

                String[] folderNames = {
                    "Agreement",
                    "Contract",
                    "Addendum",
                    "Translator_CV",
                    "Original",
                    "TranslationSample"
                };

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

                            //   System.out.println(fieldname + " >> " + fieldvalue);
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
                                    //                 System.out.println("translatorName:: " + translatorName);
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
                                    translatorArray = fieldvalue.split(","); //split string by ","
                                    translatorArrayLength = translatorArray.length;
                                    for (String individualValue : translatorArray) {
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
                                case "pageExtentOfTheOriginal":
                                    originalPageExtent = fieldvalue;
                                    break;
                                case "countryOfPublication":
                                    countryOfPublication = fieldvalue;
                                    break;
                                case "amountRequested":
                                    amountRequested = fieldvalue;
                                    break;
                                case "appTargetLanguage":
//                                    targetLanguage = fieldvalue;
                                    languageArray = fieldvalue.split(","); //split string by ,
                                    languageArrayLength = languageArray.length;
                                    for (String individualValue : languageArray) {
                                        //                       System.out.println("languageArray  GrantApplicationServlet:: " + individualValue);
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


                            /*
                             * Create path components to save the file
                             * temporary Directory = rootPath + Year + Publisher
                             */
                            filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                    + folderNames[idxFolderNames] + File.separator;

                            /*
                             * if it is the translatorArray
                             */
                            if (idxFolderNames == 3) {

                                /*
                                 * Create path components to save the file
                                 * temporary Directory = rootPath + Year +
                                 * Publisher + translatorArray[counter]
                                 */
                                filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                        + folderNames[idxFolderNames] + File.separator + translatorArray[counter] + File.separator;

                                fileNames[idxFolderNames] = filePath + filename;
                                filesToBeMoved.add(fileNames[idxFolderNames]);

//                                justFiles[idxFolderNames] = translatorArray[counter] + File.separator + filename;
                                counter++;

                                if (counter == translatorArrayLength) {
                                    idxFolderNames++;
                                }
                            } else {

                                fileNames[idxFolderNames] = filePath + filename;
                                filesToBeMoved.add(fileNames[idxFolderNames]);
//                                justFiles[idxFolderNames] = filename;
                                idxFolderNames++;
                            }

                            /*
                             * create temporary Directory if it does not exist
                             */
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

                        } // else

                    }  // for (FileItem item : items)

                    //           }
                    ////////////////////////////////////////////////////////////
                    //  Process Application
                    ////////////////////////////////////////////////////////////
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
                    application.setOriginalPageExtent(Integer.parseInt(originalPageExtent));
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
                    application.setPlannedPageExtent(Integer.parseInt(plannedPageExtent));
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

                    System.out.println("application.setTC_ACCEPTED  ---->> " + TC_ACCEPTED);
                    System.out.println("application.setGdprACCEPTED ---->> " + gdpr_ACCEPTED);

                    application.setAPPROVED(APPROVED);
                    application.setStatus(Status);

                    try {

                        /*
                         * ReferenceNumber = ApplicationNumber + "/" +
                         * yearInString;
                         */
                        ReferenceNumber = GrantApplicationDAO.insertRow(application);

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
                                    GrantApplicationDAO.insertAuthors(ReferenceNumber, Name, FirstName, LastName);

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

                            GrantApplicationDAO.insertAuthors(ReferenceNumber, authorName, AuthorFirstName, AuthorLastName);
                        }

                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                publisher.setStatus("");

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

                for (int i = 0; i < filesToBeMoved.size(); i++) {

                    String moveFile = "";
                    String moveFileName = "";
                    String destinationDirectory;

                    String[] subDirs = filesToBeMoved.get(i).split("(?<!^)/");

                    if (filesToBeMoved.get(i).contains("/Translator_CV/")) {

                        String translatorDirectory = subDirs[6];      // Translator_CV
                        String translatorNameDirectory = subDirs[7];  // Translator Name5
                        moveFileName = subDirs[8];                    // translator cv 5.docx 

                        destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator
                                + ApplicationNumber + File.separator + translatorDirectory + File.separator + translatorNameDirectory + File.separator;

                        moveFile = destinationDirectory + moveFileName;
                        translatorFileDetails.add(moveFile);
                        translatorFileDetails.add(moveFileName);

                        listCopiesTranslationSample.add(moveFile);

                    } else {

                        String Directory = subDirs[6];      // Agreement
                        moveFileName = subDirs[7];          // agreement with the translation rights holder .txt

                        destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator
                                + ApplicationNumber + File.separator + Directory + File.separator;

                        moveFile = destinationDirectory + moveFileName;
                    }

                    /*
                     * create directory if it does not exist
                     */
                    File directory = new File(destinationDirectory);
                    if (!directory.exists()) {
                        directory.mkdirs();
                    }

                    File sFile = new File(filesToBeMoved.get(i));
                    File destDir = new File(destinationDirectory);
                    fileDir.add(moveFile);
                    FileUtils.moveFileToDirectory(sFile, destDir, true);
                }

                ////////////////////////////////////////////////////////////
                //  Process Application Translators
                ////////////////////////////////////////////////////////////
                int tfdCounter = 0;

                for (int i = 0; i < translatorFileDetails.size(); i++) {

                    System.out.println("translatorFileDetails----->>>> " + translatorFileDetails.get(i));
                }

                String fname = "";

//                /*
//                 * Iterate through List fileDir
//                 */
//                for (int i = 0; i < listCopiesTranslationSample.size(); i++) {
//
//                    /*
//                     * Split each fileDir items up and put them
//                     * into an array subDirs
//                     */
//                    String[] subDirs = listCopiesTranslationSample.get(i).split("(?<!^)/");
//
//                    fname = subDirs[8];
//                    /*
//                     * replaces all occurrences of "/home/markus","/~markus"
//                     */
//                    fn = fileDir.get(i).replace("/home/markus/public_html", "/~markus");
//
//                    application.setCopiesTranslationSample(fn);
//                    application.setCopiesTranslationSampleDocName(fname);
//
//                }
                if (translatorArray.length > 1) {

                    System.out.println("translatorArray.length: -------------------------->>>> " + translatorArray.length);
                    /*
                     * convert translatorArray to ArrayList Translator
                     */

 /*
                     * loop through the Translators and insert each into
                     * TranslatorTrack
                     */
                    for (String individualValue : translatorArray) {

                        translatorName = individualValue;

                        System.out.println("calling insertTranslators......................:  " + translatorName);

                        /*
                         * While iterating through the TranslatorTrack we add
                         *
                         * moveFile = the whole path including the file name
                         * moveFileName = fille name
                         * moveTheFileName = moveFile but with
                         * replace("/home/markus/public_html", "/~markus")
                         *
                         */
//                        String[] subDirs = listCopiesTranslationSample.get(tfdCounter).split("(?<!^)/");
//                        fname = subDirs[8];
                        fname = "";
                        /*
                         * replaces all occurrences of "/home/markus","/~markus"
                         */
//                        fn = fileDir.get(tfdCounter).replace("/home/markus/public_html", "/~markus");
                        fn = "";
                        String moveFile = translatorFileDetails.get(tfdCounter);
                        tfdCounter++;
                        String moveFileName = translatorFileDetails.get(tfdCounter);
                        String moveTheFileName = moveFile.replace("/home/markus/public_html", "/~markus");
                        tfdCounter++;
                        try {

                            /*
                             * set the variables and
                             * translatorName = processingTranslatorArray[0];
                             */
                            int idTranslator = ifTranslatorExist(translatorName);

                            /*
                             * insert them into the tables TranslatorTrack
                             */
                            GrantApplicationDAO.insertTranslators(ReferenceNumber, translatorName, Title, moveTheFileName, moveFileName, fn, fname);

                            /*
                             * reset index
                             */
                            //   idx = -1;
                        } catch (DBException ex) {
                            Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }

                        //  idx++;
                    }
                } else {
                    try {
                        //    TranslatorName = translatorName;
                        System.out.println("TranslatorName ---->> :::: " + translatorName);
                        // insert them into the tables Application_Author
                        String moveFile = translatorFileDetails.get(tfdCounter);
                        tfdCounter++;
                        String moveFileName = translatorFileDetails.get(tfdCounter);
                        String[] subDirs = listCopiesTranslationSample.get(tfdCounter).split("(?<!^)/");

//                        fname = subDirs[8];
                        fname = "";
                        /*
                         * replaces all occurrences of "/home/markus","/~markus"
                         */
//                        fn = fileDir.get(tfdCounter).replace("/home/markus/public_html", "/~markus");
                        fn = "";
                        String moveTheFileName = moveFileName.replace("/home/markus/public_html", "/~markus");
                        GrantApplicationDAO.insertTranslators(ReferenceNumber, translatorName, Title, moveTheFileName, moveFileName, fn, fname);

                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                ////////////////////////////////////////////////////////////
                //  Process Library
                ////////////////////////////////////////////////////////////
                Library library = new Library();
                System.out.println("Process library");
                library.setReferenceNumber(ReferenceNumber);

//                String fn = fileNames[0].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
//cover will not set at this time
//                library.setCover(fn);
//                library.setCoverName(justFiles[0]);
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
                library.setLASTUPDATED(timestamp);

                 {
                    try {
                        bookID = insertBook(library);
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                ////////////////////////////////////////////////////////////
                //  Process Application Uploads
                ////////////////////////////////////////////////////////////
                //Update  GrantApplication to contain the filePaths
                GrantApplication application = new GrantApplication();

                fname = "";

                /*
                 * Iterate through List fileDir
                 */
                for (int i = 0; i < fileDir.size(); i++) {

                    /*
                     * Split each fileDir items up and put them
                     * into an array subDirs
                     */
                    String[] subDirs = fileDir.get(i).split("(?<!^)/");

                    String decider = subDirs[7];

                    /*
                     * Get the last item of the List which is the fileName
                     * Translator_CV has one more subDirectory
                     */
                    if ("Translator_CV".equals(subDirs[7])) {
                        fname = subDirs[9];
                    } else {
                        fname = subDirs[8];
                    }

                    /*
                     * replaces all occurrences of "/home/markus","/~markus"
                     */
                    fn = fileDir.get(i).replace("/home/markus/public_html", "/~markus");

                    System.out.println("decider " + decider);

                    switch (decider) {
                        case "Agreement":
                            application.setAgreement(fn);
                            application.setAgreementDocName(fname);
                            break;
                        case "Contract":
                            application.setContract(fn);
                            application.setContractDocName(fname);
                            break;
                        case "Addendum":
                            application.setAddendumRightsAgreement(fn);
                            application.setAddendumRightsAgreementName(fname);
                            break;
                        case "Original":
                            application.setOriginal(fn);
                            application.setOriginalName(fname);
                            break;
                        case "TranslationSample":
                            application.setCopiesTranslationSample(fn);
                            application.setCopiesTranslationSampleDocName(fname);
                            break;
                    }

                }

                application.setApplicationNumber(ApplicationNumber);
                application.setReferenceNumber(ReferenceNumber);

                System.out.println("ReferenceNumber " + ReferenceNumber + "  ApplicationNumber " + ApplicationNumber);

                try {

                    GrantApplicationDAO.updateDocuments(application, ReferenceNumber);

                } catch (DBException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                ////////////////////////////////////////////////////////////
                //  Process Application Languages
                ////////////////////////////////////////////////////////////
                if (languageArrayLength != 0) {

                    String[] processingLanguagesArray = new String[languageArray.length - 1];

                    /*
                     * convert processingArray to ArrayList Languages
                     */
                    Languages = new ArrayList<>(Arrays.asList(processingLanguagesArray));

                    int idx = 0;

                    /*
                     * loop through the Languages and insert each into
                     * Languages_Library
                     */
                    for (String individualValue : languageArray) {

                        languages = individualValue;

                        if (idx < languages.length()) {
                            processingLanguagesArray[idx] = languages;

                            /*
                             * when we have a complete set (idLanguages, lang,
                             * bookID, ReferenceNumber)
                             */
                            String language = processingLanguagesArray[idx];
                            int idLanguages = 0;
                            try {
                                idLanguages = ifLanguageExist(processingLanguagesArray[idx]);
                            } catch (DBException ex) {
                                Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }

                            try {

                                /*
                                 * set the variables and
                                 * insert them into the tables Languages_Library
                                 */
                                GrantApplicationDAO.insertLanguages_Library(idLanguages, language, bookID, ReferenceNumber);

                            } catch (DBException ex) {
                                Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }

                            idx++;
                        }
                    }
                } else {

                    try {

                        int idLanguages = ifLanguageExist(languages);
                        GrantApplicationDAO.insertLanguages_Library(idLanguages, appTargetLanguage, bookID, ReferenceNumber);

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

            case "System.out.println(\"Closed Applications :: \");":
                System.out.println("System.out.println(\"Closed Applications :: \"); :: ");
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
            case "openApplications":

                System.out.println("case openApplications: ");
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

                //   try {
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
                        System.out.println("fieldname :: " + fieldname + " fieldvalue " + fieldvalue);

                        //Info:   fieldname :: Address1 fieldvalue
                        //Info:   fieldname :: postCode fieldvalue
                        //Info:   fieldname :: City fieldvalue
                        //Info:   fieldname :: Address2 fieldvalue
                        //Info:   fieldname :: Country fieldvalue
                        //Info:   fieldname :: Address3 fieldvalue
                        //Info:   fieldname :: Address4 fieldvalue
                        //Info:   fieldname :: Telephone fieldvalue
                        //Info:   fieldname :: Fax fieldvalue
                        //Info:   fieldname :: Email fieldvalue
                        //Info:   fieldname :: WWW fieldvalue
                        //Info:   fieldname :: doNotMail fieldvalue
                        //Info:   fieldname :: companyNotes fieldvalue
                        //Info:   fieldname :: translationPublicationYear fieldvalue
                        //Info:   fieldname :: appDateOfPublicationOriginal fieldvalue 1/09/2017
                        //Info:   fieldname :: copies fieldvalue
                        //Info:   fieldname :: pageExtentOfTheOriginal fieldvalue
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue Agreement
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue Contract
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue Addendum
                        //Info:   fieldname :: proposedDateOfPublication fieldvalue
                        //Info:   fieldname :: appForeignPublisher fieldvalue Trada
                        //Info:   fieldname :: plannedPageExtent fieldvalue
                        //Info:   fieldname :: appForeignCountry fieldvalue Iceland
                        //Info:   fieldname :: proposedPrintRun fieldvalue
                        //Info:   fieldname :: appTargetLanguage fieldvalue English
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue Translator_CV
                        //Info:   fieldname :: userID fieldvalue
                        //Info:   fieldname :: translatorFee fieldvalue
                        //Info:   fieldname :: BreakDownOfTranslatorFee fieldvalue
                        //Info:   fieldname :: image-file fieldvalue Cover
                        //Info:   fieldname :: isbn fieldvalue
                        //Info:   fieldname :: issn fieldvalue
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue proofPayment
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue proofPayment
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue proofPayment
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: dateCopiesWereSent fieldvalue
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue originalSample
                        //Info:   fieldname :: userID fieldvalue 85
                        //Info:   fieldname :: publisherID fieldvalue 2790
                        //Info:   fieldname :: Company fieldvalue
                        //Info:   fieldname :: destination fieldvalue translationSample
//                            switch (fieldname) {
//                                case "Company":
//                                    company = fieldvalue;
//                                    break;
//                                case "Company_Number":
//                                    publisherID = Integer.parseInt(fieldvalue);
//                                    break;
//                                case "firstname":
//                                    firstname = fieldvalue;
//                                    break;
//                                case "lastname":
//                                    lastname = fieldvalue;
//                                    break;
//                                case "Address1":
//                                    Address1 = fieldvalue;
//                                    break;
//                                case "Address2":
//                                    Address2 = fieldvalue;
//                                    break;
//                                case "Address3":
//                                    Address3 = fieldvalue;
//                                    break;
//                                case "Address4":
//                                    Address4 = fieldvalue;
//                                    break;
//                                case "City":
//                                    City = fieldvalue;
//                                    break;
//                                case "postCode":
//                                    postCode = fieldvalue;
//                                    break;
//                                case "Country":
//                                    country = fieldvalue;
//                                    break;
//                                case "Country_Code":
//                                    countryCode = fieldvalue;
//                                    break;
//                                case "Email":
//                                    Email = fieldvalue;
//                                    break;
//                                case "Telephone":
//                                    Telephone = fieldvalue;
//                                    break;
//                                case "Fax":
//                                    Fax = fieldvalue;
//                                    break;
//                                case "WWW":
//                                    WWW = fieldvalue;
//                                    break;
//                                case "doNotMail":
//                                    DoNotMail = fieldvalue;
//                                    break;
//                                case "Bursaries":
//                                    Bursaries = fieldvalue;
//                                    break;
//                                case "Founded":
//                                    Founded = fieldvalue;
//                                    break;
//                                case "NumberOfTitles":
//                                    NumberOfTitles = fieldvalue;
//                                    break;
//                                case "companyNotes":
//                                    companyNotes = fieldvalue;
//                                    break;
//                                case "destination":
//                                    Type = fieldvalue;
//                                    break;
//                                case "userID":
//                                    userID = fieldvalue;
//                                    break;
//                                case "publisherID":
//                                    publisherID = Integer.parseInt(fieldvalue);
//                                    break;
//                                case "proposedDateOfPublication":
//                                    proposedDateOfPublication = fieldvalue;
//                                    break;
//                                case "proposedPrintRun":
//                                    proposedPrintRun = Integer.parseInt(fieldvalue);
//                                    break;
//                                case "plannedPageExtent":
//                                    plannedPageExtent = fieldvalue;
//                                    break;
//                                case "BreakDownOfTranslatorFee":
//                                    breakDownTranslatorFee = fieldvalue;
//                                    break;
//                                case "translatorName":
//                                    translatorName = fieldvalue;
//                                    break;
//                                case "translatorFee":
//                                    translatorFee = fieldvalue;
//                                    break;
//                                case "translatorNotes":
//                                    translatorNotes = fieldvalue;
//                                    break;
//                                case "copiesSent":
//                                    copySent = fieldvalue;
//                                    if ("ticked".equals(copySent)) {
//                                        copiesSent = 1;
//                                    } else {
//                                        copiesSent = 0;
//                                    }
//                                    break;
//                                case "dateCopiesWereSent":
//                                    dateCopiesWereSent = fieldvalue;
//                                    break;
//                                case "TCACCEPTED":
//                                    TCACCEPTED = fieldvalue;
//                                    if ("ticked".equals(TCACCEPTED)) {
//                                        TC_ACCEPTED = 1;
//                                    } else {
//                                        TC_ACCEPTED = 0;
//                                    }
//                                    break;
//                                case "APPROVED":
//                                    ieAPPROVED = fieldvalue;
//                                    if ("ticked".equals(ieAPPROVED)) {
//                                        APPROVED = 1;
//                                    } else {
//                                        APPROVED = 0;
//                                    }
//                                    break;
//                                case "authorArray":
//                                    authorArray = fieldvalue.split(","); //split string by ,
//                                    for (String individualValue : authorArray) {
//                                        System.out.println("authorArray  GrantApplicationServlet:: " + individualValue);
//                                    }
//                                    break;
//                                case "title":
//                                    Title = fieldvalue;
//                                    break;
//                                case "copies":
//                                    Copies = fieldvalue;
//                                    break;
//                                case "publicationYear":
//                                    Publisheryear = fieldvalue;
//                                    break;
//                                case "genre":
//                                    Genre = fieldvalue;
//                                    break;
//                                case "addendum":
//                                    Addendum = fieldvalue;
//                                    break;
//                                case "proofPayment":
//                                    ProofPayment = fieldvalue;
//                                    break;
//                                case "bankDetailForm":
//                                    BankDetails = fieldvalue;
//                                    break;
//                                case "signedLIcontract":
//                                    SignedLIContract = fieldvalue;
//                                    break;
//                                case "originalSample":
//                                    Original = fieldvalue;
//                                    break;
//                                case "translationTitle":
//                                    translationTitle = fieldvalue;
//                                    break;
//                                case "translationPublicationYear":
//                                    translationPublisherYear = fieldvalue;
//                                    break;
//                                case "translatorArray":
//                                    translatorArray = fieldvalue.split(","); //split string by ,
//                                    for (String individualValue : translatorArray) {
//                                        System.out.println("translatorArray  GrantApplicationServlet:: " + individualValue);
//                                    }
//                                    break;
//                                case "languages":
//                                    languageArray = fieldvalue.split(","); //split string by ,
//                                    for (String individualValue : languageArray) {
//                                        System.out.println("languageArray  GrantApplicationServlet:: " + individualValue);
//                                    }
//                                    break;
//                                case "physicalDescription":
//                                    physicalDescription = fieldvalue;
//                                    break;
//                                case "duplicates":
//                                    if ("".equals(fieldvalue)) {
//                                        fieldvalue = "0";
//                                    }
//                                    Duplicates = Integer.parseInt(fieldvalue);
//                                    break;
//                                case "translationPublisher":
//                                    translationPublisher = fieldvalue;
//                                    break;
//                                case "bookNotes":
//                                    bookNotes = fieldvalue;
//                                    break;
//                                case "series":
//                                    Series = fieldvalue;
//                                    break;
//                                case "isbn":
//                                    ISBN = fieldvalue;
//                                    break;
//                                case "issn":
//                                    ISSN = fieldvalue;
//                                    break;
//                                case "languageOfTheOriginal":
//                                    originalLanguage = fieldvalue;
//                                    break;
//                                case "pageExtentOfTheOriginal":
//                                    originalPageExtent = fieldvalue;
//                                    break;
//                                case "countryOfPublication":
//                                    countryOfPublication = fieldvalue;
//                                    break;
//                                case "amountRequested":
//                                    amountRequested = fieldvalue;
//                                    break;
//                                case "appTargetLanguage":
//                                    targetLanguage = fieldvalue;
//                                    break;
//                                case "appForeignCountry":
//                                    countryOfPublication = fieldvalue;
//                                    break;
//                                case "appForeignPublisher":
//                                    foreignPublisher = fieldvalue;
//                                    break;
//                                case "DateOfPublicationOriginal":
//                                    originalDateOfPublication = fieldvalue;
//                                    break;
//
//                            } // end switch
//
                    } else {
//
//                            ////////////////////////////////////////////////////////////
//                            //  Process Application Form file field (input type="file").
//                            ////////////////////////////////////////////////////////////
//                            String fieldname = item.getFieldName();
//                            String filename = FilenameUtils.getName(item.getName());
//                            System.out.println("folderNames[" + idxFolderNames + "] " + folderNames[idxFolderNames] + " fieldname " + fieldname + " filename " + filename);
//
//                            // Create path components to save the file
//                            // temporary Directory = rootPath + Year + Publisher
//                            filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator + folderNames[idxFolderNames] + File.separator;
//
//                            justFiles[idxFolderNames] = filename;
//                            fileNames[idxFolderNames] = filePath + filename;
//
//                            idxFolderNames++;
//
//                            // create temporary Directory if it does not exist
//                            File file = new File(filePath);
//                            if (!file.exists()) {
//                                file.mkdirs();
//                            }
//
//                            OutputStream outS = null;
//                            InputStream filecontent = null;
//
//                            //      final PrintWriter writer = response.getWriter();
//                            try {
//                                outS = new FileOutputStream(new File(filePath + filename));
//                                filecontent = item.getInputStream();
//
//                                message = message + " '" + filename + "' has been uploaded <br/>";
//
//                                int read;
//                                final byte[] bytes = new byte[1024];
//
//                                while ((read = filecontent.read(bytes)) != -1) {
//                                    outS.write(bytes, 0, read);
//
//                                }
//
//                            } catch (FileNotFoundException fne) {
//
//                                String errMsg = "<br/><br/>You either did not specify a file to upload or are "
//                                        + "trying to upload a file to a protected or nonexistent "
//                                        + "location.<br/> <br/><strong> ERROR:<strong> '" + fne.getMessage() + "' ";
//
//                                request.setAttribute("message", " '<strong>" + filename + "</strong>" + errMsg);
//                                request.getRequestDispatcher("/WEB-INF/views/uploadErrorResponse.jsp").forward(request, response);
//                                LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}",
//                                        new Object[]{fne.getMessage()});
//
//                            } finally {
//
//                                if (outS != null) {
//                                    outS.close();
//                                }
//
//                                if (filecontent != null) {
//                                    filecontent.close();
//                                }
//
////                        if (writer != null) {
////                            writer.close();
////                        }
//                            }
//
                    } // else

                }  // for (FileItem item : items)
                break;
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

//    public void createTemporaryDirectory(String filename, HttpServletRequest request, HttpServletResponse response, FileItem item) throws IOException, ServletException {
//
//        /*
//         * create temporary Directory if it does not exist
//         */
//        File file = new File(filePath);
//        if (!file.exists()) {
//
//            file.mkdirs();
//        }
//        System.out.println("createTemporaryDirectory");
//        System.out.println("filePath: " + filePath + " filename: " + filename);
//        OutputStream outS = null;
//        InputStream filecontent = null;
//
//        final PrintWriter writer = response.getWriter();
//        try {
//            outS = new FileOutputStream(new File(filePath + filename));
//
//            filecontent = item.getInputStream();
//
//            message = message + " '" + filename + "' has been uploaded <br/>";
//
//            int read;
//            final byte[] bytes = new byte[1024];
//
//            while ((read = filecontent.read(bytes)) != -1) {
//                outS.write(bytes, 0, read);
//
//            }
//
//        } catch (FileNotFoundException fne) {
//
//            String errMsg = "<br/><br/>You either did not specify a file to upload or are "
//                    + "trying to upload a file to a protected or nonexistent "
//                    + "location.<br/> <br/><strong> ERROR:<strong> '" + fne.getMessage() + "' ";
//jjkhkjhkjhk
//            request.setAttribute("message", " '<strong>" + filename + "</strong>" + errMsg);
//            request.getRequestDispatcher("/WEB-INF/views/uploadErrorResponse.jsp").forward(request, response);
//            LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}",
//                    new Object[]{fne.getMessage()});
//
//        } finally {
//
//            if (outS != null) {
//                outS.close();
//            }
//
//            if (filecontent != null) {
//                filecontent.close();
//            }
//
//            if (writer != null) {
//                writer.close();
//            }
//        }
//    }
}
