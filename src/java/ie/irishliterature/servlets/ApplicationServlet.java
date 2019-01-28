/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import ie.irishliterature.dao.GrantApplicationDAO;
import ie.irishliterature.db.DBException;
import java.io.IOException;
import java.util.Enumeration;
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String publisherID = request.getParameter("publisherID");   // OK  request.getParameter publisherID1 2790
        String publisherName = request.getParameter("publisherName");// OK  request.getParameter publisherName1 Rotten Luck
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String name = request.getParameter("name");
        String userID = request.getParameter("userID");
        System.out.println("/Application  --->  name getParameter  " + request.getParameter("name"));

        System.out.println("/Application  --->  name " + name);

        System.out.println("/Application  --->  publisherName " + publisherName);  // OK  request.getParameter publisherName1 Rotten Luck              
        System.out.println("/Application  --->  publisherID   " + publisherID);  // OK  request.getParameter publisherID1 2790

        session.setAttribute("name", name);
        session.setAttribute("publisherID", publisherID);

        Enumeration en = request.getParameterNames();

        while (en.hasMoreElements()) {
            Object objOri = en.nextElement();

            String param = (String) objOri;

            String value = request.getParameter(param);

            System.out.println("Parameter Name is '" + param + "' and Parameter Value is '" + value + "'\n");

        }

        String task = request.getParameter("task");

        System.out.println("/Application  --->   :task: " + task);

        request.setAttribute("task", task);
        request.setAttribute("publisherID", publisherID);
        request.setAttribute("name", name);

        String tempPath = "/home/glassfish/glassfish/domains/domain1/tempDir";
        String rootPath = "/home/glassfish/glassfish/domains/domain1/docroot/documents";

        System.out.println(
                "file location :tempPath: " + tempPath);
        System.out.println(
                "file location :rootPath: " + rootPath);

        int tc_ACCEPTED = 0;
        int gdpr_ACCEPTED = 0;


        if (request.getParameter("tcACCEPTED") == null) {
            System.out.println("doPost getParameter - tcACCEPTED not checked ");
            tc_ACCEPTED = 0;
        } else {
            System.out.println("doPost getParameter - tcACCEPTED IS checked ");
            tc_ACCEPTED = 1;
        }

        if (request.getParameter("gdprACCEPTED") == null) {
            System.out.println("doPost getParameter - gdprACCEPTED not checked ");
            gdpr_ACCEPTED = 0;
        } else {
            System.out.println("doPost getParameter - gdprACCEPTED IS checked ");
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
            request.getSession().setAttribute("task", "List Pending Applications");
        } else if (request.getParameter("List Pending Applications") != null) {
            task = "List Pending Applications";
            request.getSession().setAttribute("task", "List Closed Applications");
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
                    System.out.println("Start New Application - TCACCEPTED " + tc_ACCEPTED + " gdprACCEPTED " + gdpr_ACCEPTED);
                    response.setContentType("text/html;charset=UTF-8");
                    request.setAttribute("ApplicationNumber", ApplicationNumber);
                    request.setAttribute("publisherID", publisherID);
                    request.setAttribute("publisherName", publisherName);
                    request.setAttribute("firstname", firstname);
                    request.setAttribute("lastname", lastname);
                    request.setAttribute("name", name);
                    request.setAttribute("userID", userID);
                    request.setAttribute("TCACCEPTED", tc_ACCEPTED);
                    request.setAttribute("gdprACCEPTED", gdpr_ACCEPTED);
                    session.setAttribute("name", name);
                    session.setAttribute("publisherID", publisherID);

                } catch (DBException ex) {
                    Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            request.getRequestDispatcher("/WEB-INF/views/newApplicationLandingPage.jsp").forward(request, response);

            break;

            case "NewApplicationTCconfirmed": {
                try {
                    System.out.println("NewApplicationTCconfirmed - session.getAttribute" + session.getAttribute("publisherID"));
                    int ApplicationNumber = GrantApplicationDAO.getLastRecordID() + 1;
                    System.out.println("TCACCEPTED " + tc_ACCEPTED + " gdprACCEPTED " + gdpr_ACCEPTED);
                    response.setContentType("text/html;charset=UTF-8");
                    request.setAttribute("ApplicationNumber", ApplicationNumber);
                    request.setAttribute("TCACCEPTED", tc_ACCEPTED);
                    request.setAttribute("gdprACCEPTED", gdpr_ACCEPTED);
                    request.setAttribute("publisherID", publisherID);
                    request.setAttribute("publisherName", publisherName);
                    request.setAttribute("firstname", firstname);
                    request.setAttribute("lastname", lastname);
                    request.setAttribute("name", name);
                    request.setAttribute("userID", userID);
                    session.setAttribute("name", name);
                    session.setAttribute("publisherID", publisherID);

                } catch (DBException ex) {
                    Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/newApplication.jsp").forward(request, response);
            break;

            case "List Open Applications":
                System.out.println("publisherID: Application:: 1 " + publisherID);
                System.out.println("task: Application:: 1 " + task);
                session.setAttribute("name", name);
                session.setAttribute("publisherID", publisherID);
                request.setAttribute("publisherID", publisherID);
                request.setAttribute("publisherName", publisherName);
                request.setAttribute("firstname", firstname);
                request.setAttribute("lastname", lastname);
                request.setAttribute("name", name);
                request.setAttribute("userID", userID);
                request.getRequestDispatcher("/WEB-INF/views/openApplications.jsp").forward(request, response);
                break;
            case "List Pending Applications":
                System.out.println("task: Application:: 2 " + task);
                System.out.println("publisherID: Application:: 2 " + publisherID);
                System.out.println("name: Application:: 2 " + name);
                session.setAttribute("name", name);
                session.setAttribute("publisherID", publisherID);
                request.setAttribute("publisherID", publisherID);
                request.setAttribute("publisherName", publisherName);
                request.setAttribute("firstname", firstname);
                request.setAttribute("lastname", lastname);
                request.setAttribute("name", name);
                request.setAttribute("userID", userID);
                request.getRequestDispatcher("/WEB-INF/views/pendingApplications.jsp").forward(request, response);
                break;
            case "List Closed Applications":
                session.setAttribute("name", name);
                session.setAttribute("publisherID", publisherID);
                request.setAttribute("publisherID", publisherID);
                request.setAttribute("publisherName", publisherName);
                request.setAttribute("firstname", firstname);
                request.setAttribute("lastname", lastname);
                request.setAttribute("name", name);
                request.setAttribute("userID", userID);
                System.out.println("publisherID: Application:: 3 " + publisherID);
                System.out.println("task: Application:: 3 " + task);
                System.out.println("name: Application:: 3 " + name);
                session.setAttribute("publisherID", publisherID);
                request.getRequestDispatcher("/WEB-INF/views/closedApplications.jsp").forward(request, response);
                break;
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
    }
}
