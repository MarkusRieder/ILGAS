/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ie.irishliterature.DataTables.DataTableExpertReader;
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
@WebServlet(name = "ExpertReaderDataServlet", urlPatterns = {"/ExpertReaderDataServlet"})
public class ExpertReaderDataServlet extends HttpServlet {

        private static final long serialVersionUID = 1L;
        
           public ExpertReaderDataServlet() {
               
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

                response.setContentType("application/json");
        PrintWriter out = response.getWriter();

          List listExpertReader = null;
        
        try {
            
            listExpertReader = UserDAO.getAllExpertReaders();
            
//              System.out.println("listExpertReader:  " + listExpertReader);
            
        } catch (ClassNotFoundException | DBException ex) {
            Logger.getLogger(ExpertReaderDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        DataTableExpertReader dter = new DataTableExpertReader();
        dter.setAaData(listExpertReader);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(dter);
//        System.out.println("json:  " + json);
        out.print(json);
    }   
}
