/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import ie.irishliterature.DataTables.DataTableStaff;
import ie.irishliterature.dao.Test1DAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.GrantApplication;
import ie.irishliterature.util.DataTablesParamUtility;
import java.io.IOException;
import java.util.LinkedList;
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
@WebServlet(name = "TestDataServlet1", urlPatterns = {"/TestDataServlet1"})
public class TestDataServlet1 extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public TestDataServlet1() {
        // TODO Auto-generated constructor stub
    }

    /**
     * @param request
     * @param response
     *
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DataTableStaff param = DataTablesParamUtility.getParam(request);

        System.out.println("param " + param.getsColumns());

        String sEcho = param.getsEcho();
        int iTotalRecords = 0; // total number of records (unfiltered)
        int iTotalDisplayRecords = 0; //value will be set when code filters companies by keyword


            System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  iTotalRecords = Test1DAO.getAllApplications().size() START %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        try {
            //            iTotalRecords = Test1DAO.getAllApplications().size();
            iTotalRecords = Test1DAO.getSizeOfApplications();
        } catch (DBException ex) {
            Logger.getLogger(TestDataServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }
            System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  iTotalRecords = Test1DAO.getAllApplications().size() END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            System.out.println("iTotalRecords " + iTotalRecords);



        List<GrantApplication> applications = new LinkedList<>();

        try {
            for (GrantApplication c : Test1DAO.getAllApplications()) {
                if (c.getReferenceNumber().toLowerCase().contains(param.getsSearch().toLowerCase())
                        || c.getCompany().toLowerCase().contains(param.getsSearch().toLowerCase())) {
                    applications.add(c); // add applications that matches given search criterion
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TestDataServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DBException ex) {
            Logger.getLogger(TestDataServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

        iTotalDisplayRecords = applications.size(); // number of companies that match search criterion should be returned

        System.out.println("iTotalDisplayRecords " + iTotalDisplayRecords);

        final int sortColumnIndex = param.getiSortColumnIndex();
        final int sortDirection = param.getsSortDirection().equals("asc") ? -1 : 1;

//		Collections.sort(applications, new Comparator<GrantApplication>(){
//			@Override
//			public int compare(GrantApplication c1, GrantApplication c2) {	
//				switch(sortColumnIndex){
//				case 0:
//					return c1.getCompany().compareTo(c2.getCompany()) * sortDirection;
//				case 1:
//					return c1.getApplicationYear().compareTo(c2.getApplicationYear()) * sortDirection;
//				case 2:
//					return c1.getReferenceNumber().compareTo(c2.getReferenceNumber()) * sortDirection;
//				}
//				return 0;
//			}
//		});
//    
//      System.out.println("applications " + applications.get(i));
//}
        if (applications.size() < param.getiDisplayStart() + param.getiDisplayLength()) {
            applications = applications.subList(param.getiDisplayStart(), applications.size());
        } else {
            applications = applications.subList(param.getiDisplayStart(), param.getiDisplayStart() + param.getiDisplayLength());
        }

        try {
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);

            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(applications));

//            System.out.println("aaData:  " + data);
            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());

//            System.out.println(" jsonResponse.toString():  " + jsonResponse.toString());
        } catch (JsonIOException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // doGet(request, response);
    }
}
