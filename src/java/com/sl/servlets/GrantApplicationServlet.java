/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sl.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sl.dao.GrantApplicationDAO;
import static com.sl.dao.GrantApplicationDAO.sqlDate;
import com.sl.db.DBException;
import com.sl.model.GrantApplication;
import static com.sun.xml.ws.spi.db.BindingContextFactory.LOGGER;
import java.io.File;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author markus
 */
@MultipartConfig
@WebServlet(name = "GrantApplicationServlet", urlPatterns = {"/GrantApplicationServlet"})
public class GrantApplicationServlet extends HttpServlet {

    private boolean isMultipart;
    String agreement = "";
    String contract = "";
    String translatorCV = "";
    String copiesTranslationSample = "";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GrantApplicationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GrantApplicationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        isMultipart = ServletFileUpload.isMultipartContent(request);
        String company = "";
        int newApplicationID = 0;

        String lulu1 = request.getParameter("contract");
        System.out.println("lulu1:  " + lulu1);
//        String[] fileNames = request.getParameterValues("file");
//
//        System.out.println("fileNames:  " + fileNames.length);
//
//        for (String fileItems : fileNames) {
//            System.out.println(":: " + fileItems);
//        }
        HttpSession session = request.getSession(false);

        int newApplicationNumber = 0;

        try {
            newApplicationNumber = GrantApplicationDAO.getLastRecordID() + 1;
        } catch (DBException ex) {
            Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //    System.out.println("newApplicationNumber:123: " + newApplicationNumber);
//        String task = request.getParameter("task");
        String task = "New Application";

        System.out.println("task:  " + task);

        request.setAttribute("task", task);

        // use hidden input to define the form
        //        switch (hiddenParam) {
        //            case "value1":
        //                //form 1 was posted
        //                break;
        //            case "value2":
        //                //form 2 was posted
        //                break;
        //        }
        response.setContentType("text/html");
        if (!isMultipart) {
            String lulu = request.getParameter("contract");
            System.out.println("lulu:  " + lulu);
            try {
                //collect all data input
                String ApplicationNumber = request.getParameter("ApplicationNumber");
                company = request.getParameter("company");
                String publisherID = request.getParameter("publisherID");
                String userID = request.getParameter("userID");
                agreement = request.getParameter("agreement");
                contract = request.getParameter("contract");
                String proposedDateOfPublication = request.getParameter("proposedDateOfPublication");
                String proposedDateOfPrintRun = request.getParameter("proposedDateOfPrintRun");
                String plannedPageExtent = request.getParameter("plannedPageExtent");
                translatorCV = request.getParameter("translatorCV");
                System.out.println("GrantApplicationServlet :: translatorCV:  " + translatorCV);
                String numberOfPages = request.getParameter("numberOfPages");
                String feePerPage = request.getParameter("feePerPage");
                String translatorFee = request.getParameter("translatorFee");
                String Notes = request.getParameter("Notes");
                String copySent = request.getParameter("copiesSent");
                String dateCopiesWereSent = request.getParameter("dateCopiesWereSent");
                copiesTranslationSample = request.getParameter("copiesTranslationSample");
                String TCACCEPTED = request.getParameter("TC_ACCEPTED");
                String ieAPPROVED = request.getParameter("APPROVED");
                String Status = request.getParameter("Status");

                int copiesSent;
                int TC_ACCEPTED;
                int APPROVED;

                if ("ticked".equals(copySent)) {

                    copiesSent = 1;

                } else {

                    copiesSent = 0;

                }

                if ("ticked".equals(TCACCEPTED)) {

                    TC_ACCEPTED = 1;

                } else {

                    TC_ACCEPTED = 0;

                }

                if ("ticked".equals(ieAPPROVED)) {

                    APPROVED = 1;

                } else {

                    APPROVED = 0;

                }

                switch (task) {
                    case "New Application":
                        Status = "New";
                        break;
                    case "value2":
                        //form 2 was posted
                        break;
                }

                System.out.println("------------------------------ GrantApplicationServlet ------------------------------ ");
                System.out.println("ApplicationNumber:  " + ApplicationNumber);
                System.out.println("company:  " + company);
                System.out.println("publisherID:  " + publisherID);
                System.out.println("userID:  " + userID);
//        System.out.println("GrantApplicationServlet :: agreement  " + agreement);
//        System.out.println("GrantApplicationServlet :: contract:  " + contract);
                System.out.println("proposedDateOfPublication:  " + proposedDateOfPublication);
                System.out.println("proposedDateOfPrintRun:  " + proposedDateOfPrintRun);
                System.out.println("plannedPageExtent:  " + plannedPageExtent);
//        System.out.println("translatorCV:  " + translatorCV);
                System.out.println("numberOfPages:  " + numberOfPages);
                System.out.println("feePerPage:  " + feePerPage);
                System.out.println("translatorFee:  " + translatorFee);
                System.out.println("Notes:  " + Notes);
                System.out.println("copiesSent:  " + copiesSent);
                System.out.println("dateCopiesWereSent:  " + dateCopiesWereSent);
//        System.out.println("copiesTranslationSample:  " + copiesTranslationSample);
                System.out.println("TC_ACCEPTED:  " + TC_ACCEPTED);
                System.out.println("APPROVED:  " + APPROVED);
                System.out.println("Status:  " + Status);

                GrantApplication application = new GrantApplication();
                application.setCompany(request.getParameter("company"));
                application.setPublisherID(request.getParameter("publisherID"));
//        application.setAgreement(fileNames[0]);
//        application.setContract(fileNames[1]);
                application.setProposedDateOfPublication(convertDate(request.getParameter("proposedDateOfPublication")));
                application.setProposedDateOfPrintRun(sqlDate(convertDate(request.getParameter("proposedDateOfPrintRun"))));
                application.setPlannedPageExtent(Integer.parseInt(request.getParameter("plannedPageExtent")));
//        application.setTranslatorCV(fileNames[2]);
                application.setNumberOfPages(Integer.parseInt(request.getParameter("numberOfPages")));

                BigDecimal fpp = new BigDecimal(request.getParameter("feePerPage").replaceAll(",", ""));
                application.setFeePerPage(fpp);

                BigDecimal tf = new BigDecimal(request.getParameter("translatorFee").replaceAll(",", ""));
                application.setTranslatorFee(tf);
                
                application.setNotes(request.getParameter("Notes"));
                application.setCopiesSent(copiesSent);
                application.setDateCopiesWereSent(sqlDate(convertDate(request.getParameter("dateCopiesWereSent"))));
//        application.setCopiesTranslationSample(fileNames[3]);
                application.setTC_ACCEPTED(TC_ACCEPTED);
                application.setAPPROVED(APPROVED);
                application.setStatus(Status);

                try {
                    newApplicationID = GrantApplicationDAO.insertRow(application);
                } catch (DBException ex) {
                    Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                System.out.println("newApplicationID  >>>> " + newApplicationID);
            } catch (ParseException ex) {
                Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        } //if (!isMultipart)
        else {

//            String[] fileNames = request.getParameterValues("file");
//
//            System.out.println("fileNames:  " + fileNames.length);
//
//            for (String fileItems : fileNames) {
//                System.out.println(":: " + fileItems);
//            }
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            String yearInString = String.valueOf(year);

            // Create path components to save the file
            // path = path + File.separator + yearInString + File.separator + Company + File.separator + Type + ApplicationNumber;
            String rootPath = "/home/markus/test";

            final String path = rootPath + File.separator + yearInString + File.separator + company + File.separator + newApplicationID;
//             + request.getParameter("destination");

            System.out.println("final String path:  " + path);

            String agreement1 = path + File.separator + "Agreement" + File.separator + agreement;
            String contract1 = path + File.separator + "Contract" + File.separator + contract;
            String translatorCV1 = path + File.separator + "TranslatorCV" + File.separator + translatorCV;
            String copiesTranslationSample1 = path + File.separator + "TranslationSample" + File.separator + copiesTranslationSample;

            List<String> uploads = Arrays.asList(agreement1, contract1, translatorCV1, copiesTranslationSample1);

            // Process the uploaded file items
            Iterator i = uploads.iterator();

            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField()) {
                    // Get the uploaded file parameters
                    System.out.println("fi = " + fi);

//                        final Part filePart = request.getPart("file");
//                        final String fileName = getFileName(filePart);
//
//                        File file = new File(path);
//                        if (!file.exists()) {
//                            file.mkdirs();
//                        }
//
//                        System.out.println("Upload File Directory = " + path);
//
//                        //    String[] fileNames ;
//                        OutputStream out = null;
//                        InputStream filecontent = null;
//                        final PrintWriter writer = response.getWriter();
//
//                        out = new FileOutputStream(new File(path + File.separator
//                                + fileName));
//                        filecontent = filePart.getInputStream();
//
//                        int read;
//                        final byte[] bytes = new byte[1024];
//
//                        while ((read = filecontent.read(bytes)) != -1) {
//                            out.write(bytes, 0, read);
//
//                        }
//
//                        String test = (String) request.getParameter("anchor");
//                        System.out.println("anchor = " + test);
//
//                        request.setAttribute("message", " '" + fileName + "' -  File uploaded successfully!");
//                        request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);
                }
            }
        } //else
    } // doPost

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public Date convertDate(String datum) throws ParseException {

        DateFormat sourceFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = sourceFormat.parse(datum);

        return date;

    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }

        return null;
    }
}
