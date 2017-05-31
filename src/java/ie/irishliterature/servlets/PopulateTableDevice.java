package ie.irishliterature.servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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


import com.sl.test.DataTableDevice;
import com.sl.test.DeviceDaoBean;

/**
 *
 * @author markus
 */
@WebServlet("/PopulateTableDevice")
public class PopulateTableDevice extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public PopulateTableDevice() {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

         System.out.println("PopulateTableDevice here: ");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        List listLibrary = null;
        try {
            listLibrary = DeviceDaoBean.getAllBooks();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PopulateTableDevice.class.getName()).log(Level.SEVERE, null, ex);
        }

        DataTableDevice dtd = new DataTableDevice();
        dtd.setAaData(listLibrary);

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json = gson.toJson(dtd);
        System.out.println("json:  " + json);
        out.print(json);
    }
}
