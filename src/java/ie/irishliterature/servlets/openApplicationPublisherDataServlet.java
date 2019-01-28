/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ie.irishliterature.DataTables.DataTableApplications;
import ie.irishliterature.dao.openApplicationDAO;
import ie.irishliterature.db.DBException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;
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
@WebServlet(name = "openApplicationPublisherDataServlet", urlPatterns = {"/openApplicationPublisherDataServlet"})
public class openApplicationPublisherDataServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public openApplicationPublisherDataServlet() {

        super();
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("openApplicationPublisherDataServlet:  ");

        HttpSession session = request.getSession();

//        int pID = (Integer) session.getAttribute("publisherID");
//        String publisherID = (String) Integer.toString(pID);
        String publisherID = String.valueOf(request.getSession().getAttribute("publisherID"));
                System.out.println("openApplicationPublisherDataServlet publisherID: " + publisherID);


        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        List listApplications = null;

        try {

            listApplications = openApplicationDAO.getAllApplicationsPublisher(publisherID);

            //    System.out.println("ApplicationDataServlet listApplications: " + listApplications + " publisherID  "  + publisherID);
        } catch (ClassNotFoundException | DBException | ParseException ex) {
            Logger.getLogger(openApplicationPublisherDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        DataTableApplications dta = new DataTableApplications();
        dta.setAaData(listApplications);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(dta);
        System.out.println("json:  " + json);
        out.print(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // doGet(request, response);
    }
}
