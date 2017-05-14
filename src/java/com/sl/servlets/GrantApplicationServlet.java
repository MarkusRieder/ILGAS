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
import static com.sun.xml.bind.util.CalendarConv.formatter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author markus
 */
@WebServlet(name = "GrantApplicationServlet", urlPatterns = {"/GrantApplicationServlet"})
public class GrantApplicationServlet extends HttpServlet {

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

        try {

            HttpSession session = request.getSession(false);

            int newApplicationNumber = 0;

            try {
                newApplicationNumber = GrantApplicationDAO.getLastRecordID() + 1;
            } catch (DBException ex) {
                Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            System.out.println("newApplicationNumber:: " + newApplicationNumber);
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
            //collect all data input
            String ApplicationNumber = request.getParameter("ApplicationNumber");
            String company = request.getParameter("company");
            String publisherID = request.getParameter("publisherID");
            String userID = request.getParameter("userID");
            //    String agreement = request.getParameter("agreement");            
//            String contract = request.getParameter("contract");
            String proposedDateOfPublication = request.getParameter("proposedDateOfPublication");
            String proposedDateOfPrintRun = request.getParameter("proposedDateOfPrintRun");
            String plannedPageExtent = request.getParameter("plannedPageExtent");
            // String translatorCV = request.getParameter("translatorCV");
            //    System.out.println("GrantApplicationServlet :: translatorCV:  " + translatorCV);
            String numberOfPages = request.getParameter("numberOfPages");
            String feePerPage = request.getParameter("feePerPage");
            String translatorFee = request.getParameter("translatorFee");
            String Notes = request.getParameter("Notes");
            String copySent = request.getParameter("copiesSent");
            String dateCopiesWereSent = request.getParameter("dateCopiesWereSent");
            //      String copiesTranslationSample = request.getParameter("copiesTranslationSample");
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

            String[] fileNames = request.getParameterValues("file");

            System.out.println("fileNames:  " + fileNames.length);
            
            for (String fileName : fileNames) {
                System.out.println(":: " + fileName);
            }

            String agreement = fileNames[0];
            String contract = fileNames[1];
            String translatorCV = fileNames[2];
            String copiesTranslationSample = fileNames[3];

            System.out.println("------------------------------ GrantApplicationServlet ------------------------------ ");
            System.out.println("ApplicationNumber:  " + ApplicationNumber);
            System.out.println("company:  " + company);
            System.out.println("publisherID:  " + publisherID);
            System.out.println("userID:  " + userID);
            System.out.println("GrantApplicationServlet :: agreement  " + agreement);
            System.out.println("GrantApplicationServlet :: contract:  " + contract);
            System.out.println("proposedDateOfPublication:  " + proposedDateOfPublication);
            System.out.println("proposedDateOfPrintRun:  " + proposedDateOfPrintRun);
            System.out.println("plannedPageExtent:  " + plannedPageExtent);
            System.out.println("translatorCV:  " + translatorCV);
            System.out.println("numberOfPages:  " + numberOfPages);
            System.out.println("feePerPage:  " + feePerPage);
            System.out.println("translatorFee:  " + translatorFee);
            System.out.println("Notes:  " + Notes);
            System.out.println("copiesSent:  " + copiesSent);
            System.out.println("dateCopiesWereSent:  " + dateCopiesWereSent);
            System.out.println("copiesTranslationSample:  " + copiesTranslationSample);
            System.out.println("TC_ACCEPTED:  " + TC_ACCEPTED);
            System.out.println("APPROVED:  " + APPROVED);
            System.out.println("Status:  " + Status);

            for (String fileName : fileNames) {
                System.out.println("xxfileNames:  " + fileName);
            }

            request.setAttribute("agreement", fileNames[0]);
            request.setAttribute("contract", fileNames[1]);
            request.setAttribute("translatorCV", fileNames[2]);
            request.setAttribute("copiesTranslationSample", fileNames[3]);

            GrantApplication application = new GrantApplication();

            application.setCompany(request.getParameter("company"));
            application.setPublisherID(request.getParameter("publisherID"));
            application.setAgreement(request.getParameter("agreement"));
            application.setContract(fileNames[1]);
            application.setProposedDateOfPublication(convertDate(request.getParameter("proposedDateOfPublication")));
            application.setProposedDateOfPrintRun(sqlDate(convertDate(request.getParameter("proposedDateOfPrintRun"))));
            application.setPlannedPageExtent(Integer.parseInt(request.getParameter("plannedPageExtent")));
            application.setTranslatorCV(fileNames[2]);
            application.setNumberOfPages(Integer.parseInt(request.getParameter("numberOfPages")));
            application.setFeePerPage(Double.parseDouble(request.getParameter("feePerPage")));
            application.setTranslatorFee(Double.parseDouble(request.getParameter("translatorFee")));
            application.setNotes(request.getParameter("Notes"));
            application.setCopiesSent(copiesSent);
            application.setDateCopiesWereSent(sqlDate(convertDate(request.getParameter("dateCopiesWereSent"))));
            application.setCopiesTranslationSample(fileNames[3]);
            application.setTC_ACCEPTED(TC_ACCEPTED);
            application.setAPPROVED(APPROVED);
            application.setStatus(Status);

            int newApplicationID = GrantApplicationDAO.insertRow(application);

            System.out.println("translatorCV:  " + fileNames[2]);

//            request.setAttribute("contract", contract);
//            request.setAttribute("translatorCV", translatorCV);
//            request.setAttribute("copiesTranslationSample",copiesTranslationSample);
            request.setAttribute("newApplicationID", newApplicationID);

            System.out.println("translatorCV:2:  " + fileNames[2]);

             //   request.getRequestDispatcher("/upload").forward(request, response);
        } catch (ParseException | DBException ex) {
            Logger.getLogger(GrantApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    public Date convertDate(String datum) throws ParseException {

        DateFormat sourceFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = sourceFormat.parse(datum);

        return date;

    }
}
