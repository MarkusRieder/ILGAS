/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ie.irishliterature.DataTables.DataTableApplications;
import ie.irishliterature.dao.pendingApplicationDAO;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author markus
 */
@WebServlet(name = "pendingApplicationDataServlet", urlPatterns = {"/pendingApplicationDataServlet"})
public class pendingApplicationDataServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public pendingApplicationDataServlet() {

        super();
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("pendingApplicationDataServlet:  ");

        HttpSession session = request.getSession();

        String publisherID = String.valueOf(request.getSession().getAttribute("publisherID"));

        System.out.println("pendingApplicationDataServlet  publisherID here  publisherID: getParameter >> " + publisherID);

//        request.setAttribute("task", task);
//        request.setAttribute("publisherID", publisherID);
//        request.getSession().setAttribute("publisherID", publisherID);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        List listApplications = null;

        try {

            listApplications = pendingApplicationDAO.getAllApplications(publisherID);

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // doGet(request, response);
    }
}
