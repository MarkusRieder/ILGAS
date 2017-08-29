/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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

import ie.irishliterature.dao.LibraryDAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.DataTables.DataTableLibrary;

/**
 *
 * @author markus
 */
@WebServlet("/LibraryDataServlet")
public class LibraryDataServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LibraryDataServlet() {

        super();
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");

        System.out.println("running LibraryDataServlet......  ");

        PrintWriter out = response.getWriter();

        List listLibrary = null;

        try {

//            listLibrary = LibraryDAO.getAllBooks();
            listLibrary = LibraryDAO.listAllLibrary();
            
        } catch (DBException ex) {
            Logger.getLogger(LibraryDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        DataTableLibrary dtl = new DataTableLibrary();
        dtl.setAaData(listLibrary);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(dtl);
        System.out.println("json:  " + json);
        out.print(json);

    }
}
