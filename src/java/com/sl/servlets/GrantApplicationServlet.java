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
import com.sl.db.DBException;
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

        //collect all data input
//        String ApplicationNumber = request.getParameter("ApplicationNumber");
//        String company = request.getParameter("company");
//        String publisherID = request.getParameter("publisherID");
//        String userID = request.getParameter("userID");
//        String agreement = request.getParameter("agreement");
//        String contract = request.getParameter("contract");
//        String proposedDateOfPublication = request.getParameter("proposedDateOfPublication");
//        String proposedDateOfPrintRun = request.getParameter("proposedDateOfPrintRun");
//        String plannedPageExtent = request.getParameter("plannedPageExtent");
//        String translatorCV = request.getParameter("translatorCV");
//        String numberOfPages = request.getParameter("numberOfPages");
//        String feePerPage = request.getParameter("feePerPage");
//        String translatorFee = request.getParameter("translatorFee");
//        String Notes = request.getParameter("Notes");
//        String copiesSent = request.getParameter("copiesSent");
//        String dateCopiesWereSent = request.getParameter("dateCopiesWereSent");
//
//        String copiesTranslationSample = request.getParameter("copiesTranslationSample");
//        String TC_ACCEPTED = request.getParameter("TC_ACCEPTED");
//        String APPROVED = request.getParameter("APPROVED");
//        String Status = request.getParameter("Status");
//
//        System.out.println("company:  " + company);
//        System.out.println("publisherID:  " + publisherID);
//        System.out.println("GrantApplicationServlet :: userID:  " + userID);
//        System.out.println("proposedDateOfPublication:  " + proposedDateOfPublication);
//        System.out.println("Notes:  " + Notes);
//        System.out.println("copiesTranslationSample:  " + copiesTranslationSample);
//        System.out.println("APPROVED:  " + APPROVED);
//        System.out.println("Status:  " + Status);
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

}
