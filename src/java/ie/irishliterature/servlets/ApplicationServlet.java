/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import ie.irishliterature.dao.GrantApplicationDAO;
import ie.irishliterature.db.DBException;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author markus
 */
@WebServlet(name = "Application", urlPatterns = {"/Application"})
public class ApplicationServlet extends HttpServlet {

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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        if publisherID = null ==> have we been logged out???
        HttpSession session = request.getSession();
        int publisherID = (Integer) session.getAttribute("publisherID");
        System.out.println("/Application  --->  publisherID " + publisherID);
        //  String publisherID = (String) Integer.toString(xxx);
        // String publisherID = (String) session.getAttribute("publisherID");
        //   String publisherID = (String) Integer.toString(xxx);
        session.setAttribute("publisherID", publisherID);

        // publisherID = request.getParameter("publisherID");
        String task = request.getParameter("task");

        request.setAttribute("task", task);
        request.setAttribute("publisherID", publisherID);

        int tc_ACCEPTED = 0;
        int gdpr_ACCEPTED = 0;

        if (request.getParameter("tcACCEPTED") == null) {
            System.out.println("doPost- tcACCEPTED not checked ");
        } else {
            System.out.println("doPost- tcACCEPTED IS checked ");
            tc_ACCEPTED = 1;
        }

        if (request.getParameter("gdprACCEPTED") == null) {
            System.out.println("doPost- gdprACCEPTED not checked ");
        } else {
            System.out.println("doPost- gdprACCEPTED IS checked ");
            gdpr_ACCEPTED = 1;
        }


        System.out.println("doPost- TCACCEPTED   " + tc_ACCEPTED);
        System.out.println("doPost - gdprACCEPTED " + gdpr_ACCEPTED);

        if (request.getParameter("New Application") != null) {
            task = "Start New Application";
            request.getSession().setAttribute("task", "Start New Application");

//        } else if (request.getParameter("List New Applications") != null) {
//            task = "List New Applications";
//            request.getSession().setAttribute("task", "List New Applications");
        } else if (request.getParameter("List Open Applications") != null) {
            task = "List Open Applications";
            request.getSession().setAttribute("task", "List Open Applications");
        } else if (request.getParameter("List Pending Applications") != null) {
            task = "List Pending Applications";
            request.getSession().setAttribute("task", "List Pending Applications");
        } else if (request.getParameter("List Closed Applications") != null) {
            task = "List Closed Applications";
            request.getSession().setAttribute("task", "List Closed Applications");
        } else {
            //  task = task;
        }

        System.out.println("task: Application:: " + task);

        switch (task) {

            case "List New Applications":
                request.setAttribute("task", task);
                System.out.println("List New Applications - session.getAttribute" + session.getAttribute("publisherID"));
                request.getRequestDispatcher("/WEB-INF/views/newApplications.jsp").forward(request, response);
                break;

            case "Start New Application": {
                try {

                    int ApplicationNumber = GrantApplicationDAO.getLastRecordID() + 1;
                    //System.out.println("/Application::ApplicationNumber:  " + ApplicationNumber);
                    //   request.getSession().setAttribute("TCACCEPTED", + tcACCEPTED);
                    //     request.getSession().setAttribute("gdprACCEPTED", + gdprACCEPTED);
                    System.out.println("Start New Application - TCACCEPTED " + tc_ACCEPTED + " gdprACCEPTED " + gdpr_ACCEPTED);
                    response.setContentType("text/html;charset=UTF-8");
                    request.setAttribute("ApplicationNumber", ApplicationNumber);
//                    request.setAttribute("TCACCEPTED", tc_ACCEPTED);
//                    request.setAttribute("gdprACCEPTED", gdpr_ACCEPTED);

                } catch (DBException ex) {
                    Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            request.getRequestDispatcher("/WEB-INF/views/newApplicationLandingPage.jsp").forward(request, response);

            // request.getRequestDispatcher("/WEB-INF/views/newApplication.jsp").forward(request, response);
            break;

            case "NewApplicationTCconfirmed": {
                try {
                    System.out.println("NewApplicationTCconfirmed - session.getAttribute" + session.getAttribute("publisherID"));
                    int ApplicationNumber = GrantApplicationDAO.getLastRecordID() + 1;

                    request.getSession().setAttribute("TCACCEPTED", tc_ACCEPTED);
                    request.getSession().setAttribute("gdprACCEPTED", gdpr_ACCEPTED);
                    System.out.println("TCACCEPTED " + tc_ACCEPTED + " gdprACCEPTED " + gdpr_ACCEPTED);
                    response.setContentType("text/html;charset=UTF-8");
                    request.setAttribute("ApplicationNumber", ApplicationNumber);
                    request.setAttribute("TCACCEPTED", tc_ACCEPTED);
                    request.setAttribute("gdprACCEPTED", gdpr_ACCEPTED);

                } catch (DBException ex) {
                    Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/newApplication.jsp").forward(request, response);
            break;

            case "List Open Applications":
                System.out.println("List Open Applications - session.getAttribute" + session.getAttribute("publisherID"));
                //    publisherID = request.getParameter("publisherID");
                session.setAttribute("publisherID", publisherID);

                request.getRequestDispatcher("/WEB-INF/views/openApplications.jsp").forward(request, response);
                break;
            case "List Pending Applications":
                System.out.println("List Open Applications - session.getAttribute" + session.getAttribute("publisherID"));
                session.setAttribute("publisherID", publisherID);
                //         insertBook(request, response);
                request.getRequestDispatcher("/WEB-INF/views/pendingApplications.jsp").forward(request, response);
                break;
            case "List Closed Applications":
                System.out.println("List Open Applications - session.getAttribute" + session.getAttribute("publisherID"));
                session.setAttribute("publisherID", publisherID);
                //          deleteBook(request, response);
                request.getRequestDispatcher("/WEB-INF/views/closedApplications.jsp").forward(request, response);
                break;
            default:
                //          listBook(request, response);
                request.getRequestDispatcher("/WEB-INF/views/newApplications.jsp").forward(request, response);
                break;
        }

//         String action = request.getServletPath();
// System.out.println("action2:  " + action);
//        try {
//            switch (action) {
//            case "/new":
//                showNewForm(request, response);
//                break;
//            case "/insert":
//                insertBook(request, response);
//                break;
//            case "/delete":
//                deleteBook(request, response);
//                break;
//            case "/edit":
//                showEditForm(request, response);
//                break;
//            case "/update":
//                updateBook(request, response);
//                break;
//            default:
//                listBook(request, response);
//                break;
//            }
//        } catch (SQLException ex) {
//            throw new ServletException(ex);
//        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
