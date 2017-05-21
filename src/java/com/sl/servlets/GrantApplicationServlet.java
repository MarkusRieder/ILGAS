package com.sl.servlets;

import com.sl.dao.GrantApplicationDAO;
import static com.sl.dao.GrantApplicationDAO.listAllApplications;
import com.sl.db.DBException;
import com.sl.model.GrantApplication;
import com.sl.model.Publisher;

import java.io.*;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.sql.SQLException;
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

    private boolean isMultipart;
    private String filePath;
    private String rootPath;
    private final int maxFileSize = 50 * 1024;
    private final int maxMemSize = 4 * 1024;
    private File file;
    private int newApplicationID = 0;
    private String company;
    private String publisherID;
    private String userID;
    private String agreement;
    private String contract;
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
    private String copiesTranslationSample;
    private String TCACCEPTED;
    private String ieAPPROVED;
    private String Status;
    private String Type;
    private String firstname;
    private String lastname;
    private String Address1;
    private String Address2;
    private String Address3;
    private String Address4;
    private String City;
    private String postCode;
    private String Email;
    private String Telephone;
    private String Fax;

    private int copiesSent = 0;
    private int TC_ACCEPTED = 0;
    private int APPROVED = 0;

    private String tempPath = "";

    public void init() {

        // Get the file location where it would be stored.
        tempPath = "/home/markus/test/tempDir";
        rootPath = "/home/markus/public_html/test";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String task = "Open New Application";
        // task = request.getParameter("task");

        System.out.println("task:: " + task);
        switch (task) {
            case "Open New Application":
                Status = "new";

                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                String yearInString = String.valueOf(year);

                String[] fileNames = new String[4];
                String[] justFiles = new String[4];
                String[] tpe = {"Agreement", "Contract", "Translator_CV", "TranslationSample"};
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
                    upload.setSizeMax(maxFileSize);

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

                            switch (fieldname) {
                                case "company":
                                    company = fieldvalue;
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
                                case "Email":
                                    Email = fieldvalue;
                                    break;
                                case "Telephone":
                                    Telephone = fieldvalue;
                                    break;
                                case "Fax":
                                    Fax = fieldvalue;
                                    break;
                                case "destination":
                                    Type = fieldvalue;
                                    break;
                                case "userID":
                                    userID = fieldvalue;
                                    break;
                                case "publisherID":
                                    publisherID = fieldvalue;
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
                                case "Notes":
                                    Notes = fieldvalue;
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
                                case "APPROVED":
                                    ieAPPROVED = fieldvalue;
                                    if ("ticked".equals(ieAPPROVED)) {
                                        APPROVED = 1;
                                    } else {
                                        APPROVED = 0;
                                    }
                                    break;
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

                        newApplicationID = GrantApplicationDAO.insertRow(application);

                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                } catch (ParseException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                // Update new publisher
                Publisher publisher = new Publisher();

//        updatePublisher(Publisher publisher, int Company_Number) 
//        publisher.setFIRST_NAME(firstname);
//        publisher.setLAST_NAME(firstname);
                publisher.setAddress1(Address1);
                publisher.setAddress2(Address2);
                publisher.setAddress3(Address3);
                publisher.setAddress4(Address4);
                publisher.setCity(City);
                publisher.setPostCode(postCode);
//        publisher.s(Email);
                publisher.setTelephone(Telephone);
                publisher.setFax(Fax);
//    private String postCode;
//    private String Email;
//    private String Telephone;
//    private String Fax;

                // path = path + File.separator + yearInString + File.separator + Company + File.separator + Type + ApplicationNumber;
                // upload to temp dir then move to final directory
                for (int i = 0; i < 4; i++) {
                    final String destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator + newApplicationID + File.separator + tpe[i] + File.separator;

                    // create final directory if it does not exist
                    File file = new File(destinationDirectory);
                    if (!file.exists()) {
                        file.mkdirs();
                    }

                    File sourceFile = new File(fileNames[i]);

                    File destinationDir = new File(destinationDirectory);

                    FileUtils.moveFileToDirectory(sourceFile, destinationDir, true);

                    fileNames[i] = destinationDirectory + justFiles[i];
                }

                //Update  GrantApplication to contain the filePaths
                GrantApplication application = new GrantApplication();

                String fn = fileNames[0].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                System.out.println(fn);
                application.setAgreement(fn);
                System.out.println("fileNames[0]:: " + fileNames[0]);
                application.setAgreementDocName(justFiles[0]);
                System.out.println("justFiles[0]:: " + justFiles[0]);
                fn = fileNames[1].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                application.setContract(fn);
                System.out.println("fileNames[1]:: " + fileNames[1]);
                application.setContractDocName(justFiles[1]);
                System.out.println("justFiles[1]:: " + justFiles[1]);
                fn = fileNames[2].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                application.setTranslatorCV(fn);
                System.out.println("fileNames[2]:: " + fileNames[2]);
                application.setTranslatorCVDocName(justFiles[2]);
                System.out.println("justFiles[2]:: " + justFiles[2]);
                fn = fileNames[3].replace("/home/markus/public_html", "/~markus");//replaces all occurrences of "/home/markus","/~markus"
                application.setCopiesTranslationSample(fn);
                System.out.println("fileNames[3]:: " + fileNames[3]);
                application.setCopiesTranslationSampleDocName(justFiles[3]);
                System.out.println("justFiles[3]:: " + justFiles[3]);

                try {

                    GrantApplicationDAO.updateDocuments(application, newApplicationID);

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
//                try {
//                    List<GrantApplication> rows = listAllApplications();
//                    //request.getSession().setAttribute("rows", rows);
//                    request.setAttribute("rows", rows);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                } finally {
//                    System.out.print("servlet");
//                }
//                request.getRequestDispatcher("pendingApplications.jsp").forward(request, response);
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
