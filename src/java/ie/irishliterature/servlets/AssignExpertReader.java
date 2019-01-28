/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import static ie.irishliterature.dao.GrantApplicationDAO.getAttachments;
import static ie.irishliterature.dao.GrantApplicationDAO.getExpertReaderEmail;
import static ie.irishliterature.dao.GrantApplicationDAO.getExpertReaderUserID;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.ExpertReader;
import ie.irishliterature.util.MailUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author markus
 */
@WebServlet(name = "AssignExpertReader", urlPatterns = {"/AssignExpertReader"})
public class AssignExpertReader extends HttpServlet {

    private final static Logger LOGGER
            = Logger.getLogger(AssignExpertReader.class.getCanonicalName());
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
    private String message = "";

    @Override
    public void init() {

        // Get the file location where they would be stored.
        tempPath = "/home/glassfish/glassfish/domains/domain1/tempDir";
        rootPath = "/home/glassfish/glassfish/domains/domain1/docroot/documents";

        System.out.println("file location :tempPath: " + tempPath);
        System.out.println("file location :rootPath: " + rootPath);
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

        String expertReaderEmail = "";
        List<String[]> fileAttachment = new ArrayList<>();

        String expertReaderName = request.getParameter("selectedUnassignedER");
        String expectedReturnDate = request.getParameter("expectedReturnDate");

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>  AssignExpertReader GrantApplicationServlet<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");

        Enumeration en = request.getParameterNames();

        while (en.hasMoreElements()) {
            Object objOri = en.nextElement();

            String param = (String) objOri;

            String value = request.getParameter(param);

//            if ("ReferenceNumber".equals(param)) {
//                ReferenceNumber = value;
//            }
            System.out.println("Parameter Name is '" + param + "' and Parameter Value is '" + value + "'\n");

        }
        System.out.println(" expertReaderName " + expertReaderName);
        System.out.println(" expectedReturnDate " + expectedReturnDate);

        String newAssignedReferenceNumber = request.getParameter("NewAssignedERRefNo");
        System.out.println(" newAssignedReferenceNumber " + newAssignedReferenceNumber);
        int expertReaderUserID = 0;
        try {

            expertReaderUserID = getExpertReaderUserID(expertReaderName);
            expertReaderEmail = getExpertReaderEmail(expertReaderName);
            fileAttachment = getAttachments(newAssignedReferenceNumber);

            System.out.println(" expertReaderUserID " + expertReaderUserID);
            System.out.println(" expertReaderEmail " + expertReaderEmail);

        } catch (DBException ex) {
            Logger.getLogger(AssignExpertReader.class.getName()).log(Level.SEVERE, null, ex);
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
                    System.out.println(" filePath 1 AssignExpertReader " + filePath[1]);
                    System.out.println(" filePath 3 AssignExpertReader " + filePath[3]);

                    originalPath = filePath[1].replace("/documents", "/home/glassfish/glassfish/domains/domain1/docroot/documents");
                    originalName = filePath[2];

                    translationPath = filePath[3].replace("/documents", "/home/glassfish/glassfish/domains/domain1/docroot/documents");
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
                        Logger.getLogger(AssignExpertReader.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            } catch (DBException ex) {
                Logger.getLogger(AssignExpertReader.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        message = "The email to '" + expertReaderName + "' has been sent <br/>"
                + "electronic copies of '" + originalName + "' and '" + translationName + "' have been attached";
        request.setAttribute("message", message);
        request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public java.sql.Date getTodaySQL() {
        java.util.Date today = new java.util.Date();
        return new java.sql.Date(today.getTime());

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

            String sql = "INSERT INTO ILGAS.expertReader (expertReaderUserID, referenceNumber, sampleSentOut) values (?,?,?)";

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

            Logger.getLogger(AssignExpertReader.class.getName()).log(Level.SEVERE, null, e);

            DBConn.close(conn, ps1, ps2, res);

            throw new DBException("updateExpertReader 4 Excepion while accessing database " + e);
        }

        return idExpertReader;
    }

}
