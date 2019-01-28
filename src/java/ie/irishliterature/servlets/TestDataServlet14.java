/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import ie.irishliterature.dao.Test1DAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.db.EntryDb;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
@WebServlet(name = "TestDataServlet14", urlPatterns = {"/TestDataServlet14"})
public class TestDataServlet14 extends HttpServlet {

    private static final long serialVersionUID = 4219756235170784173L;

    private static final Logger log = Logger.getLogger(TestDataServlet14.class.getName());

    private static List<EntryDb> entrys;

    static {
        try {
            entrys = Test1DAO.getEntryDb();
        } catch (ClassNotFoundException | DBException ex) {
            Logger.getLogger(TestDataServlet14.class.getName()).log(Level.SEVERE, null, ex);
        }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<EntryDb> applications = new ArrayList<>();

        try {
            applications = Test1DAO.getEntryDb();
        } catch (ClassNotFoundException | DBException ex) {
            Logger.getLogger(TestDataServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

        String sEcho = request.getParameter("draw");

        System.out.println("sEcho: " + sEcho);
        int iTotalRecords = 0; // total number of records (unfiltered)
        int iTotalDisplayRecords = 0; //value will be set when code filters companies by keyword

        String globalSearch = request.getParameter("search[value]");

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>.   globalSearch: " + globalSearch);

        Map<String, Integer> columnsReordered = new HashMap<>();

        try {
            iTotalRecords = Test1DAO.getSizeOfApplications();
        } catch (DBException ex) {
            Logger.getLogger(TestDataServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

        System.out.println("iTotalRecords " + iTotalRecords);

        columnsReordered.put(request.getParameter("columns[1][data]"), 1);
        columnsReordered.put(request.getParameter("columns[2][data]"), 2);
        columnsReordered.put(request.getParameter("columns[3][data]"), 2);
        columnsReordered.put(request.getParameter("columns[4][data]"), 4);
        columnsReordered.put(request.getParameter("columns[5][data]"), 5);

//        System.out.println("columnsReordered 1  " + request.getParameter("columns[1][data]"));
//        System.out.println("columnsReordered 2  " + request.getParameter("columns[2][data]"));
//        System.out.println("columnsReordered 3  " + request.getParameter("columns[3][data]"));
//        System.out.println("columnsReordered 4  " + request.getParameter("columns[4][data]"));
//        System.out.println("columnsReordered 5  " + request.getParameter("columns[5][data]"));
        String sSearch_1 = request.getParameter("columns[" + columnsReordered.get("ReferenceNumber") + "][search][value]");
        String sSearch_2 = request.getParameter("columns[" + columnsReordered.get("company") + "][search][value]");
        String sSearch_3 = request.getParameter("columns[" + columnsReordered.get("bookTitle") + "][search][value]");
        String sSearch_4 = request.getParameter("columns[" + columnsReordered.get("Status") + "][search][value]");
        String sSearch_5 = request.getParameter("columns[" + columnsReordered.get("Author") + "][search][value]");
//        String sSearch_5 = request.getParameter("columns[" + columnsReordered.get("Status") + "][search][value]");

//        System.out.println("TestDataServlet14 sSearch_1 " + sSearch_1);
//        System.out.println("TestDataServlet14 sSearch_2 " + sSearch_2);
//        System.out.println("TestDataServlet14 sSearch_3 " + sSearch_3);
//        System.out.println("TestDataServlet14 sSearch_4 " + sSearch_4);
        if (sSearch_4 != null && !sSearch_4.trim().equals("")) {
            try {
                entrys = Test1DAO.getEntryDb1(sSearch_4);
            } catch (ClassNotFoundException | DBException ex) {
                Logger.getLogger(TestDataServlet14.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

//        System.out.println("TestDataServlet14 sSearch_5 " + sSearch_5);
        List<Map<String, String>> data = new ArrayList<>();

        Map<String, String> rowData = null;
        int counter = 0;
        try {

            for (EntryDb c : Test1DAO.getEntryDb()) {

                counter++;

                rowData = new HashMap<>();

                if (globalSearch != null && !globalSearch.trim().equals("")) {
                    System.out.println("ReferenceNumber  " + c.getReferenceNumber());
                    System.out.println("company  " + c.getCompany());
                    System.out.println("bookTitle  " + c.getBookTitle());
                    System.out.println("Status  " + c.getStatus());
                    System.out.println("Author  " + c.getAuthor());

                    String ReferenceNumber = c.getReferenceNumber();
                    if (ReferenceNumber == null) {
                        ReferenceNumber = "n/a";
                    }
                    String Company = c.getCompany();
                    if (Company == null || Company.isEmpty()) {
                        Company = "n/a";
                    }
                    String BookTitle = c.getBookTitle();
                    if (BookTitle == null || BookTitle.isEmpty()) {
                        BookTitle = "n/a";
                    }
                    String Status = c.getStatus();
                    if (Status == null || Status.isEmpty()) {
                        Status = "n/a";
                    }
                    String Author = c.getAuthor();
                    if (Author == null || Author.isEmpty()) {
                        Author = "n/a";
                    }

                    System.out.println("ReferenceNumber  " + ReferenceNumber);
                    System.out.println("company  " + Company);
                    System.out.println("bookTitle  " + BookTitle);
                    System.out.println("Status  " + Status);
                    System.out.println("Author  " + Author);

                    if (!ReferenceNumber.trim().equals("")
                            &&  !Company.trim().equals("")
                            &&  !BookTitle.trim().equals("")
                            &&  !Status.trim().equals("")
                            &&  !Author.trim().equals("")) {

//                    if (c.getReferenceNumber() != null && !c.getReferenceNumber().trim().equals("")
//                            && c.getCompany() != null && !c.getCompany().trim().equals("")
//                            && c.getBookTitle() != null && !c.getBookTitle().trim().equals("")
//                            && c.getStatus() != null && !c.getStatus().trim().equals("")
//                            && c.getAuthor() != null && !c.getAuthor().trim().equals("")) {
                        if (!(ReferenceNumber.contains(globalSearch)
                                || Company.contains(globalSearch)
                                || BookTitle.contains(globalSearch)
                                || Status.contains(globalSearch)
                                || Author.contains(globalSearch))) {
//                            System.out.println("TestDataServlet14 nothing found c.getAuthor() 1 " + c.getAuthor() + "\n");
                            continue;
                        }
//                        if (!(c.getReferenceNumber().contains(globalSearch)
//                                || c.getCompany().contains(globalSearch)
//                                || c.getBookTitle().contains(globalSearch)
//                                || c.getStatus().contains(globalSearch)
//                                || c.getAuthor().contains(globalSearch))) {
//                            System.out.println("TestDataServlet14 nothing found c.getAuthor() 1 " + c.getAuthor() + "\n");
//                            continue;
//                        }
                    }
                }

                if (sSearch_1 != null && !sSearch_1.trim().equals("")) {
                    if (!c.getReferenceNumber().toLowerCase().contains(sSearch_1.toLowerCase())) {
                        continue;
                    }
                }
                if (sSearch_2 != null && !sSearch_2.trim().equals("")) {
                    if (!c.getCompany().toLowerCase().contains(sSearch_2.toLowerCase())) {
                        continue;
                    }
                }
                if (sSearch_3 != null && !sSearch_3.trim().equals("")) {
                    if (!c.getBookTitle().toLowerCase().contains(sSearch_3.toLowerCase())) {
                        continue;
                    }
                }
                if (sSearch_4 != null && !sSearch_4.trim().equals("")) {
                    if (!c.getStatus().toLowerCase().contains(sSearch_4.toLowerCase())) {

                        continue;
                    }
                }
                if (sSearch_5 != null && !sSearch_5.trim().equals("")) {
                    if (!c.getAuthor().toLowerCase().contains(sSearch_5.toLowerCase())) {
                        continue;
                    }
                }

                rowData.put("ReferenceNumber", c.getReferenceNumber());
                rowData.put("company", c.getCompany());
                rowData.put("bookTitle", c.getBookTitle());
                rowData.put("Status", c.getStatus());
                rowData.put("Author", c.getAuthor());
//                System.out.println("ReferenceNumber  " + c.getReferenceNumber());
//                System.out.println("company  " + c.getCompany());
//                System.out.println("bookTitle  " + c.getBookTitle());
//                System.out.println("Status  " + c.getStatus());
//                System.out.println("Author  " + c.getAuthor());
                data.add(rowData);
            }

        } catch (ClassNotFoundException | DBException ex) {
            Logger.getLogger(TestDataServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

        iTotalDisplayRecords = data.size(); // number of applications that match search criterion should be returned

        System.out.println("iTotalDisplayRecords " + iTotalDisplayRecords);

        int start = Integer.parseInt(request.getParameter("start"));
        int length = Integer.parseInt(request.getParameter("length"));

        if (data.size() < start + length) {
            data = data.subList(start, data.size());
        } else {
            data = data.subList(start, start + length);
        }

        Map<String, ArrayList> colsData = new HashMap<>();

//        Set<String> col0Data = new HashSet<>();
        Set<String> col1Data = new HashSet<>();
        Set<String> col2Data = new HashSet<>();
        Set<String> col3Data = new HashSet<>();
        Set<String> col4Data = new HashSet<>();
        Set<String> col5Data = new HashSet<>();

        entrys.stream().map((entry) -> {
            col1Data.add(entry.getReferenceNumber());
            return entry;
        }).map((entry) -> {
            col2Data.add(entry.getCompany());
            return entry;
        }).map((entry) -> {
            col3Data.add(entry.getBookTitle());
            return entry;
        }).map((entry) -> {
            col4Data.add(entry.getStatus());
            return entry;
        }).forEachOrdered((entry) -> {
            col5Data.add(entry.getAuthor());
        });

        colsData.put("ReferenceNumber", new ArrayList<>(col1Data));
        colsData.put("company", new ArrayList<>(col2Data));
        colsData.put("bookTitle", new ArrayList<>(col3Data));
        colsData.put("Status", new ArrayList<>(col4Data));
        colsData.put("Author", new ArrayList<>(col5Data));

        try {
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);               // iTotalRecords Number of records in the data set, not accounting for filtering
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords); // iTotalDisplayRecords Number of records in the data set, accounting for filtering

            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(data));

            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());
            System.out.println(" jsonResponse.toString():  " + jsonResponse.toString());
        } catch (JsonIOException e) {
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param requestuest servlet requestuest
     * @param response    servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest requestuest, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(requestuest, response);
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
