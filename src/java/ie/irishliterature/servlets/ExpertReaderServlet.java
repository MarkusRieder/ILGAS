/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import ie.irishliterature.dao.ExpertReaderDAO;
import static ie.irishliterature.dao.ExpertReaderDAO.updateExpertReader;
import static ie.irishliterature.dao.GrantApplicationDAO.getcurrentTimeStamp;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.ExpertReader;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author markus
 */
@WebServlet(name = "ExpertReaderServlet", urlPatterns = {"/ExpertReaderServlet"})
public class ExpertReaderServlet extends HttpServlet {

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
    private String Status;
    private String message = "";
    private String ReportSummary = "";
    private String ReferenceNumber = "";
    private String UserID = "";
    private String PublisherID = "";
    private String Username = "";
    private String company = "";
    private String ApplicationNumber = "";
    private String ExpertReaderName = "";
    private String upDate = "";

    @Override
    public void init() {

        // Get the file location where they would be stored.
        tempPath = "/home/markus/test/tempDir";
        rootPath = "/home/markus/public_html/test";

        System.out.println("file location :tempPath: " + tempPath);
        System.out.println("file location :rootPath: " + rootPath);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ExpertReaderServlet :: ");
        //set expertReader.reading = "false" 
        Status = "false";

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
        List<String> filesToBeMoved = new ArrayList<>();
        List<String> longArrayList = new ArrayList<>();
        List<String> shortArrayList = new ArrayList<>();

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
                        case "reportSummary":
                            ReportSummary = fieldvalue;
                            break;
                        case "referenceNumber":
                            ReferenceNumber = fieldvalue;
                            company = findPublisherName(ReferenceNumber);
                            ApplicationNumber = ReferenceNumber.split("/")[0];
                            break;
                        case "userID":
                            UserID = fieldvalue;
                            break;
                        case "publisherID":
                            PublisherID = fieldvalue;
                            break;
                        case "username":
                            Username = fieldvalue;
                            break;
                        case "expertReaderName":
                            ExpertReaderName = fieldvalue;
                            break;
                        case "date":
                            upDate = fieldvalue;
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

                    switch (fileName) {

                        case "expertReaderReport":
                            if (filename.isEmpty()) {
                                System.out.println("Agreement zero  filename " + filename);
                            } else {
                                filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                        + "ExpertReader" + File.separator + ExpertReaderName + File.separator + "ExpertReaderReport" + File.separator;
                                fileNames[idxFolderNames] = filePath + filename;
                                filesToBeMoved.add(fileNames[idxFolderNames]);
                            }
                            break;
                        case "expertReaderInvoice":
                            if (filename.isEmpty()) {
                                System.out.println("Contract zero  filename " + filename);
                            } else {
                                filePath = tempPath + File.separator + yearInString + File.separator + company + File.separator
                                        + "ExpertReader" + File.separator + ExpertReaderName + File.separator + "ExpertReaderInvoice" + File.separator;
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
            //  Process ExpertReader
            ////////////////////////////////////////////////////////////
            ExpertReader expertReader = new ExpertReader();

            expertReader.setSummaryReport(ReportSummary);
            
                             {
                    try {
                        updateExpertReader(expertReader, ReferenceNumber);
                    } catch (DBException ex) {
                        Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

        } catch (FileUploadException | DBException ex) {
            Logger.getLogger(ExpertReaderServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }

        /*
         * Update ExpertReader to contain the filePaths
         * =================================================
         * path = path + File.separator + yearInString + File.separator
         * + Company + File.separator + Type + ApplicationNumber;
         * upload to temp dir then move to final directory
         */
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
            for (int j = 0; j < subDirs.length; j++) {
                System.out.println(" Print Loop subDirs [" + j + "]  " + subDirs[j]);
            }
            System.out.println("ffilesToBeMoved.get(i) " + filesToBeMoved.get(i));
            String decider = subDirs[8];  //ExpertReaderReport

            System.out.println("filesToBeMoved before case \"ExpertReader\":     decider --" + decider + "--->>>> ");

            switch (decider) {

                case "ExpertReaderReport":
                    String subDirectory = subDirs[6];  // ExpertReader
                    String subNameDirectory = subDirs[7];  // Leo Lion
                    moveFileName = subDirs[9];  // contract with the translator 2.docx 

                    destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator
                            + ApplicationNumber + File.separator + subDirectory + File.separator + subNameDirectory + File.separator + decider + File.separator;

                    moveFile = destinationDirectory + moveFileName;

                    System.out.println("filesToBeMoved--" + decider + "--->>>> " + moveFile);
                    System.out.println("filesToBeMoved--destinationDirectory  " + decider + "--->>>> " + destinationDirectory);
                    longArrayList.add(moveFile);
                    break;

                case "ExpertReaderInvoice":
                    subDirectory = subDirs[6];  // ExpertReader
                    subNameDirectory = subDirs[7];  // Leo Lion
                    moveFileName = subDirs[9];  // contract with the translator 2.docx 

                    destinationDirectory = rootPath + File.separator + yearInString + File.separator + company + File.separator
                            + ApplicationNumber + File.separator + subDirectory + File.separator + subNameDirectory + File.separator + decider + File.separator;

                    moveFile = destinationDirectory + moveFileName;

                    System.out.println("filesToBeMoved--" + decider + "--->>>> " + moveFile);
                    System.out.println("filesToBeMoved--destinationDirectory  " + decider + "--->>>> " + destinationDirectory);
                    longArrayList.add(moveFile);
                    break;
            } // switch (decider)      

            /*
             * create directory if it does not exist
             */
            File directory = new File(destinationDirectory);
            System.out.println("destinationDirectory --" + destinationDirectory);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            File sFile = new File(filesToBeMoved.get(i));
            File destDir = new File(destinationDirectory);
//                    fileDir.add(moveFile);
            FileUtils.moveFileToDirectory(sFile, destDir, true);
        }

        System.out.println("####################### End creating the lists ##################################################");

        System.out.println("####################### sending files to tables ##################################################");

        /*
         * loop through the Translators and insert each into
         * TranslatorTrack
         */
        for (int i = 0; i < longArrayList.size(); i++) {

            try {
                System.out.println("longArrayList---i:[" + i + "]-->>>> " + longArrayList.get(i));

                String[] elements = longArrayList.get(i).split("(?<!^)/");
                for (int j = 0; j < elements.length; j++) {
                    System.out.println("longArrayList sending files to tables subDirs [" + j + "]  " + elements[j]);
                }
                String moveFile = longArrayList.get(i);
                String decider = elements[9];
                ExpertReaderName = elements[8];
                String moveFileName = elements[10];
//                        String moveFileNameReplaced = moveFile.replace("/home/markus/public_html", "/~markus");
                String moveFileNameReplaced = moveFile.replace("/home/glassfish/glassfish/domains/domain1/docroot/documents", "/documents");

                System.out.println("filesToBeMoved  decider2 --" + decider + "--->>>> ");


                /*
                 * set the variables and
                 * translatorName =
                 * processingTranslatorArray[0];
                 */
                System.out.println("ReferenceNumber  " + ReferenceNumber);
                /*
                 * insert them into the table TranslatorTrack
                 */
                switch (decider) {

                    case "ExpertReaderReport":
                        System.out.println("insertExpertReaderReport:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                        ExpertReaderDAO.insertExpertReaderReport(ReferenceNumber, getTodaySQL(), moveFileNameReplaced);
                        break;
                    case "ExpertReaderInvoice":
                        System.out.println("insertExpertReaderInvoice:: longArrayList i[" + i + "]  \n" + decider + "--->>>> " + moveFile);
                        ExpertReaderDAO.insertExpertReaderInvoice(ReferenceNumber, moveFileNameReplaced);
                        break;

                } // switch (decider)
            } catch (DBException ex) {
                Logger.getLogger(ExpertReaderServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        /*
         * reset session
         */
//                session.removeAttribute("task");
        request.setAttribute("message", message);
        request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);

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

    public static String findPublisherName(String ReferenceNumber) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        String publisherName = "";

        System.out.println("findPublisherName: " + ReferenceNumber);

        try {

            conn = DBConn.getConnection();

            ps = conn.prepareStatement("SELECT \n"
                    + "    Publisher\n"
                    + "FROM\n"
                    + "    ILGAS.library\n"
                    + "WHERE\n"
                    + "    referenceNumber = ?");

            ps.setString(1, ReferenceNumber);
            res = ps.executeQuery();
            if (res != null) {
                if (res.next()) {
                    publisherName = res.getString("Publisher");
                    System.out.println("findPublisherName: res: " + publisherName);
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            e.printStackTrace();
            throw new DBException("2 Excepion while accessing database");
        }

        System.out.println("findPublisherName::publisherName " + publisherName);

        return publisherName;
    }

}
