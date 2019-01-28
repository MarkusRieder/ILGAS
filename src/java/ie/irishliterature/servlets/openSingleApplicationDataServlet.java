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
import java.util.Enumeration;
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
@WebServlet(name = "openSingleApplicationDataServlet", urlPatterns = {"/openSingleApplicationDataServlet"})
public class openSingleApplicationDataServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public openSingleApplicationDataServlet() {

        super();
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String publisherID = "";
        String ReferenceNumber = "";

        System.out.println("openApplicationDataServlet:  ");

        Enumeration en = request.getParameterNames();

        while (en.hasMoreElements()) {
            Object objOri = en.nextElement();

            String param = (String) objOri;

            String value = request.getParameter(param);

            if ("ReferenceNumber".equals(param)) {
                ReferenceNumber = value;
            }

            System.out.println("Parameter Name is '" + param + "' and Parameter Value is '" + value + "'\n");

        }
//        int pID = (Integer) session.getAttribute("publisherID");
//        String publisherID = (String) Integer.toString(pID);
//         String publisherID = request.getParameter("publisherID");

//         String publisherID = String.valueOf(request.getSession().getAttribute("publisherID"));
        System.out.println("openSingleApplicationDataServlet  ReferenceNumber here  ReferenceNumber: getParameter >> " + ReferenceNumber);

//        String ReferenceNumber = (String) session.getAttribute("ReferenceNumber");
        System.out.println("publisherID: " + publisherID);
        System.out.println("ReferenceNumber: " + ReferenceNumber);

//        HttpSession session = request.getSession();
//
//        int pID = (Integer) session.getAttribute("publisherID");
//        String publisherID = (String) Integer.toString(pID);
//
//        String ReferenceNumber = (String) session.getAttribute("ReferenceNumber");
//        System.out.println("publisherID: " + publisherID);
//        System.out.println("ReferenceNumber: " + ReferenceNumber);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        List listApplications = null;

        try {

            listApplications = openApplicationDAO.getAllApplications(ReferenceNumber);

            //    System.out.println("ApplicationDataServlet listApplications: " + listApplications + " publisherID  "  + publisherID);
        } catch (ClassNotFoundException | DBException | ParseException ex) {
            Logger.getLogger(openSingleApplicationDataServlet.class.getName()).log(Level.SEVERE, null, ex);
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
