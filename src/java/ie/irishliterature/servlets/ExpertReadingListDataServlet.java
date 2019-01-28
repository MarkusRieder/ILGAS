/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ie.irishliterature.DataTables.DataTableExpertReader;
import ie.irishliterature.dao.ExpertReaderDAO;
import ie.irishliterature.db.DBException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "ExpertReadingListDataServlet", urlPatterns = {"/ExpertReadingListDataServlet"})
public class ExpertReadingListDataServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ExpertReadingListDataServlet() {

        super();
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
     @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String userID = request.getParameter("userID");
        
        System.out.println("userID  " + userID);
        List readingListExpertReader = null;

        try {
            readingListExpertReader = ExpertReaderDAO.getExpertReaderOpenReadings(userID);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ExpertReadingListDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ExpertReadingListDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DBException ex) {
            Logger.getLogger(ExpertReadingListDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
//              System.out.println("listExpertReader:  " + listExpertReader);

        DataTableExpertReader dter = new DataTableExpertReader();
        dter.setAaData(readingListExpertReader);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(dter);
        System.out.println("json:  " + json);
        out.print(json);
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
