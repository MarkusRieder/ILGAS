/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ie.irishliterature.DataTables.DataTableApplications;
import ie.irishliterature.dao.ApplicationDAO;
import ie.irishliterature.dao.UserDAO;
import ie.irishliterature.db.DBException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "ApplicationDataServlet", urlPatterns = {"/ApplicationDataServlet"})
public class ApplicationDataServlet extends HttpServlet {


    private static final long serialVersionUID = 1L;

      public ApplicationDataServlet() {
          
          super();
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
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
                System.out.println("ApplicationDataServlet:  ");

        response.setContentType("application/json");

        PrintWriter out = response.getWriter();

        List listApplications = null;

        try {

            listApplications = ApplicationDAO.getAllApplications();

        } catch (ClassNotFoundException | DBException ex) {
            Logger.getLogger(UserDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        DataTableApplications dta = new DataTableApplications();
        dta.setAaData(listApplications);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(dta);
        System.out.println("json:  " + json);
        out.print(json);
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
        
        doGet(request, response);
        
    }
}
