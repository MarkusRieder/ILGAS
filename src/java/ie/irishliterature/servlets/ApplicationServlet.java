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

/**
 *
 * @author markus
 */
@WebServlet(name = "Application", urlPatterns = {"/Application"})
public class ApplicationServlet extends HttpServlet {

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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");

        if (request.getParameter("New Application") != null) {
            task = "Start New Application";
        } else if (request.getParameter("List New Applications") != null) {
            task = "List New Applications";
        } else if (request.getParameter("List Pending Applications") != null) {
            task = "List Pending Applications";
        } else if (request.getParameter("List Closed Applications") != null) {
            task = "List Closed Applications";
        } else {
            task = task;
        }

        System.out.println("task:  " + task);

        switch (task) {

            case "List New Applications":
                request.getRequestDispatcher("/WEB-INF/views/newApplications.jsp").forward(request, response);
                break;

            case "Start New Application": {
                try {

                    int ApplicationNumber = GrantApplicationDAO.getLastRecordID() + 1;
  //                  System.out.println("/Application::ApplicationNumber:  " + ApplicationNumber);

                     response.setContentType("text/html;charset=UTF-8");
                    request.setAttribute("ApplicationNumber", ApplicationNumber);

                } catch (DBException ex) {
                    Logger.getLogger(ApplicationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/newApplication.jsp").forward(request, response);
            break;
            case "List Pending Applications":
                //         insertBook(request, response);
                request.getRequestDispatcher("/WEB-INF/views/pendingApplications.jsp").forward(request, response);
                break;
            case "List Closed Applications":
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
    }// </editor-fold>

}
