package ie.irishliterature.servlets;

import static ie.irishliterature.dao.ACpublisherDAO_test.updatePublisher;
import ie.irishliterature.dao.GrantApplicationDAO;
import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.model.Library;
import ie.irishliterature.model.Publisher;
import static ie.irishliterature.dao.LibraryDAO.insertBook;

import java.io.*;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import ie.irishliterature.db.DBException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

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
    private File file;
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
    private String proposedDateOfPrintRun;
    private String plannedPageExtent;
    private String translatorCV;
    private String numberOfPages;
    private String feePerPage;
    private String translatorFee;
    private String Notes;
    private String copySent;
    private String dateCopiesWereSent;
    private String copiesTranslationSample;  // path to file
    private String TCACCEPTED;
    private String ieAPPROVED;
    private String Status;
    private int copiesSent = 0;
    private int TC_ACCEPTED = 0;
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
    private String DateModified;

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For Book details
    ///
    ////////////////////////////////////////////////////////////////////////////
    private int bookID;

    private String referenceNumber;

    private ArrayList Author;

    private String writerType;  // options Author, Editor, Translator

    private String Title;

    private String Publisher;

    private String Publisheryear;

    private String Genre;

    private String translationTitle;

    private String translationPublisher;

    private String translationPublisherYear;

    private ArrayList Translator;

    private String Language;

    private String physicalDescription;

    private int Duplicates;

    private String Copies;

    private String NotesLibrary;

    private String ISBN;

    private String ISSN;

    private String Series;

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
    private String Date_Reader_Paid; //  Date
    private String Cheque_Number;
    private String Cheque_Cleared; //  Date
    private String Date_Contract_Sent_to_Publisher; //  Date
    private String Date_ILE_Acknowledgement_Received; //  Date
    private String Date_ILE_Acknowlegement_Approved; //  Date
    private String Date_Published_Books_Received; //  Date
    private String Date_Details_of_Payment_to_Translator_Received; //  Date
    private String Date_Payment_Made_to_Publisher; //  Date
    private String Publisher_Cheque_Number;
    private String Publisher_Cheque_Cleared; //   boolean
    private String Comments_re_Application;
    private String Board_Meeting;
    private String Date_publisher_informed_of_meeting; //  Date 
    private String Award; //    boolean
    private String Amount_Requested;
    private String Amount_Approved;
    private String Comments_about_Meeting;
    private String Proposed_Publication_Date; //  Date
    private String Previous_Grant_Aid; // Array of Author/Title
    private String Press_cuttings;  //  boolean
    private String Sales_figures;
    private String Anthology; //Array of Author/Title
    private String[] authorArray;  //Array of Author/Title

    public void init() {

        // Get the file location where it would be stored.
        tempPath = "/home/markus/test/tempDir";
        rootPath = "/home/markus/public_html/test";

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String task = "Open New Application";

//        String[] authorArray;
        // task = request.getParameter("task");
        System.out.println("task:: " + task);
        switch (task) {
            case "Open New Application":
                Status = "new";
                String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                String yearInString = String.valueOf(year);

                java.sql.Timestamp timestamp = getcurrentTimeStamp();

                String[] fileNames = new String[5];
                String[] justFiles = new String[5];
                String[] tpe = {"Cover", "Agreement", "Contract", "Translator_CV", "TranslationSample"};
                String message = "";

                int z = 0;

                try {

                    // Check that we have a file upload request
                    isMultipart = ServletFileUpload.isMultipartContent(request);
                    System.out.println("isMultipart:: " + isMultipart);
                    response.setContentType("text/html;charset=UTF-8");
//
//            PrintWriter out = response.getWriter();
//
//            if (!isMultipart) {
//                out.println("<html>");
//                out.println("<head>");
//                out.println("<title>Servlet upload</title>");
//                out.println("</head>");
//                out.println("<body>");
//                out.println("<p>No file uploaded</p>");
//                out.println("</body>");
//                out.println("</html>");
//
//                return;
//            }
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    // maximum size that will be stored in memory
                    factory.setSizeThreshold(maxMemSize);
                    // Location to save data that is larger than maxMemSize.
                    factory.setRepository(new File(tempPath));

                    // Create a new file upload handler
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    // maximum file size to be uploaded.
                    //  upload.setSizeMax(maxFileSize);

                    // Parse the request to get file items.
                    List<FileItem> items = null;
                    try {
                        items = upload.parseRequest(request);
                    } catch (FileUploadException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    for (FileItem item : items) {
                        if (item.isFormField()) {

                            // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                            //collect all data input from input fileds
                            String fieldname = item.getFieldName();
                            String fieldvalue = item.getString();
                            System.out.println("fieldname :: " + fieldname + " fieldvalue " + fieldvalue);

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
                                case "Notes":
                                    Notes = fieldvalue;
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
                                case "proposedDateOfPrintRun":
                                    proposedDateOfPrintRun = fieldvalue;
                                    break;
                                case "plannedPageExtent":
                                    plannedPageExtent = fieldvalue;
                                    break;
                                case "numberOfPages":
                                    numberOfPages = fieldvalue;
                                    break;
                                case "feePerPage":
                                    feePerPage = fieldvalue;
                                    break;
                                case "translatorFee":
                                    translatorFee = fieldvalue;
                                    break;
//                                case "Notes":
//                                    Notes = fieldvalue;
//                                    break;
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
                                    for (String individualValue : authorArray) {
                                        System.out.println("authorArray  GrantApplicationServlet:: " + individualValue);
                                    }

                            } // end switch

                        } else {

                            // Process form file field (input type="file").
                            String fieldname = item.getFieldName();
                            String filename = FilenameUtils.getName(item.getName());

                            // Create path components to save the file
                            // temporary Directory = rootPath + Year + Publisher
                            filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator + tpe[z] + File.separator;

                            justFiles[z] = filename;
                            fileNames[z] = filePath + filename;

                            z++;

                            // create temporary Directory if it does not exist
                            File file = new File(filePath);
                            if (!file.exists()) {
                                file.mkdirs();
                            }

                            OutputStream outS = null;
                            InputStream filecontent = null;

                            //      final PrintWriter writer = response.getWriter();
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

//                        if (writer != null) {
//                            writer.close();
//                        }
                            }

                            filecontent.close();

                        } // else

                    }  // for (FileItem item : items)

                    System.out.println("message:  " + message);

                    // INSERT new application
                    GrantApplication application = new GrantApplication();

                    application.setApplicationYear(yearInString);
                    application.setCompany(company);
                    application.setPublisherID(publisherID);
                    application.setUserID(userID);
                    application.setProposedDateOfPublication(convertDate(proposedDateOfPublication));
                    application.setProposedDateOfPrintRun(convertDate(proposedDateOfPrintRun));
                    application.setPlannedPageExtent(Integer.parseInt(plannedPageExtent));
                    application.setNumberOfPages(Integer.parseInt(numberOfPages));
                    BigDecimal fpp = new BigDecimal(feePerPage.replaceAll(",", ""));
                    application.setFeePerPage(fpp);
                    BigDecimal tf = new BigDecimal(translatorFee.replaceAll(",", ""));
                    application.setTranslatorFee(tf);
                    application.setNotes(Notes);
                    application.setCopiesSent(copiesSent);
                    application.setDateCopiesWereSent(convertDate(dateCopiesWereSent));
                    application.setTC_ACCEPTED(TC_ACCEPTED);
                    application.setAPPROVED(APPROVED);
                    application.setStatus(Status);

                    try {

                        //ReferenceNumber = ApplicationNumber + "/" + yearInString;
                        ReferenceNumber = GrantApplicationDAO.insertRow(application);

                        //ReferenceNumber contains ApplicationNumber seperated by a "/"
                        //find the first occurrence of "/" 
                        int iend = ReferenceNumber.indexOf("/");

                        //get ApplicationNumber from ReferenceNumber
                        if (iend != -1) {
                            ApplicationNumber = Integer.parseInt(ReferenceNumber.substring(0, iend));
                        }

                        String[] processingArray = new String[3];

                        //convert processingArray to ArrayList Author
                        Author = new ArrayList<>(Arrays.asList(processingArray));

                        int idx = 0;

                        //loop through the Authors and insert each into A_Author
                        for (String individualValue : authorArray) {

                            String AuthorName = individualValue;
                            processingArray[idx] = AuthorName;

                            //when we have a complete set (FullName, FirstName, LastName) 
                            if (idx == processingArray.length - 1) {

                                //set the variables and
                                String Name = processingArray[0];
                                String FirstName = processingArray[1];
                                String LastName = processingArray[2];

                                // insert them into the tables A_Author
                                GrantApplicationDAO.insertAuthors(ReferenceNumber, Name, FirstName, LastName);

                                //reset index 
                                idx = -1;
                            }

                            idx++;
                        }

                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                } catch (ParseException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                // Update new publisher
                Publisher publisher = new Publisher();
//   String sql = "UPDATE international_publishers SET Company = ?, Company_Number = ? ,Address1 = ? ,Address2 = ? ,Address3 = ? ,
                //Address4 = ? ,postCode = ? ,City = ? ,Country = ? ,CountryCode = ? ,Telephone = ? ,Fax = ? ,WWW = ? ,DoNotMail = ? ,
                //Bursaries = ?,Founded = ? ,NumberOfTitles = ? ,DateModified = ? ,Notes = ?";

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
                publisher.setNotes(Notes);
                publisher.setStatus("");

                 {
                    try {
                        updatePublisher(publisher, publisherID);
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                // Update library
                Library library = new Library();

//bookID, referenceNumber, Author, Title, Publisher, publishingYear, Genre, translationTitle, translationPublisher, translationPublisherYear, 
//Translator, Language, Cover, CoverName, physicalDescription, Duplicates, Copies, Notes, ISBN, ISSN
                library.setBookID(bookID);
                library.setReferenceNumber(ReferenceNumber);


                String fn = fileNames[0].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                System.out.println(fn);
                library.setCover(fn);
                System.out.println("fileNames[0]:: " + fileNames[0]);
                library.setCoverName(justFiles[0]);
                System.out.println("justFiles[0]:: " + justFiles[0]);

                library.setTitle(Title);
                library.setPublisheryear(Publisheryear);
                library.setGenre(Genre);
                library.setTranslationTitle(translationTitle);
                library.setTranslationPublisherYear(translationPublisherYear);
                library.setPhysicalDescription(physicalDescription);
                library.setDuplicates(Duplicates);
                library.setCopies(Copies);
                library.setNotes(Notes);
                library.setISBN(ISBN);
                library.setISSN(ISSN);
                library.setLASTUPDATED(timestamp);

                 {
                    try {
                        insertBook(library);
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                // Update  GrantApplication to contain the filePaths
                // path = path + File.separator + yearInString + File.separator + Company + File.separator + Type + ApplicationNumber;
                // upload to temp dir then move to final directory
                for (int i = 0; i < 5; i++) {
                    final String destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator + ApplicationNumber + File.separator + tpe[i] + File.separator;

                    // create final directory if it does not exist
                    File file = new File(destinationDirectory);
                    if (!file.exists()) {
                        file.mkdirs();
                    }

                    File sourceFile = new File(fileNames[i]);

                    File destinationDir = new File(destinationDirectory);

                    FileUtils.moveFileToDirectory(sourceFile, destinationDir, true);

                    fileNames[i] = destinationDirectory + justFiles[i];

                    System.out.println("fileNames[" + i + "]  :: " + fileNames[i]);
                }

                //Update  GrantApplication to contain the filePaths
                GrantApplication application = new GrantApplication();

                fn = fileNames[1].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                System.out.println(fn);
                application.setAgreement(fn);
                System.out.println("fileNames[1]:: " + fileNames[1]);
                application.setAgreementDocName(justFiles[1]);
                System.out.println("justFiles[1]:: " + justFiles[1]);

                fn = fileNames[2].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                application.setContract(fn);
                System.out.println("fileNames[2]:: " + fileNames[2]);
                application.setContractDocName(justFiles[2]);
                System.out.println("justFiles[2]:: " + justFiles[2]);

                fn = fileNames[3].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                application.setTranslatorCV(fn);
                System.out.println("fileNames[3]:: " + fileNames[3]);
                application.setTranslatorCVDocName(justFiles[3]);
                System.out.println("justFiles[3]:: " + justFiles[3]);

                fn = fileNames[4].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                application.setCopiesTranslationSample(fn);
                System.out.println("fileNames[4]:: " + fileNames[4]);
                application.setCopiesTranslationSampleDocName(justFiles[4]);
                System.out.println("justFiles[4]:: " + justFiles[4]);

                application.setApplicationNumber(ApplicationNumber);
                application.setReferenceNumber(ReferenceNumber);

                try {

                    GrantApplicationDAO.updateDocuments(application, ReferenceNumber);

                } catch (DBException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);

                break;

            case "New Applications":
                request.getRequestDispatcher("/WEB-INF/views/newApplications.jsp").forward(request, response);
                break;

            case "Pending Applications":
                request.getRequestDispatcher("/WEB-INF/views/pendingApplications.jsp").forward(request, response);
                break;

            case "Closed Applications":
                request.getRequestDispatcher("/WEB-INF/views/closedApplications.jsp").forward(request, response);
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

}
