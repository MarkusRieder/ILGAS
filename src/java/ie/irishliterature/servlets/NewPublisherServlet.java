/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.servlets;

import ie.irishliterature.db.DBConn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(urlPatterns = "/newPublisher")
public class NewPublisherServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     *
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // collect all input values
        HttpSession session = request.getSession();

        String PublisherID = request.getParameter("Company_Number");
        String Company = request.getParameter("Company");
        String Address1 = request.getParameter("Address1");
        String Address2 = request.getParameter("Address2");
        String Address3 = request.getParameter("Address3");
        String Address4 = request.getParameter("Address4");
        String postCode = request.getParameter("postCode");
        String City = request.getParameter("City");
        String Country = request.getParameter("Country");
        String countryCode = request.getParameter("Country_Code");
        String Telephone = request.getParameter("Telephone");
        String Fax = request.getParameter("Fax");
        String Email = request.getParameter("Email");
        String WWW = request.getParameter("WWW");
        String doNtMail = request.getParameter("doNotMail");
        String Bursary = request.getParameter("Bursaries");

        System.out.println("newPublisher::   ");

        System.out.println("PublisherID::   " + PublisherID);
        System.out.println("publisherName::   " + Company);

//        session.setAttribute("publisherID", PublisherID);
//        session.setAttribute("Company_Number", PublisherID);
//        session.setAttribute("publisherName", Company);
        int doNotMail;
        int Bursaries;

        if ("ticked".equals(doNtMail)) {

            doNotMail = 1;

        } else {

            doNotMail = 0;

        }

        if ("ticked".equals(Bursary)) {

            Bursaries = 1;

        } else {

            Bursaries = 0;

        }

        System.out.println("doNotMail::   " + doNotMail);
        System.out.println("Bursaries::   " + Bursaries);

        String Founded = request.getParameter("Founded");
        String NumberOfTitles = request.getParameter("NumberOfTitles");
        String notes = request.getParameter("Notes");
        String Status = "complete";

        Connection conn = null;
        PreparedStatement ps1 = null;
        ResultSet res = null;

        try {
            System.out.println("PublisherID:2:   " + PublisherID);
            conn = DBConn.getConnection();
            conn.setAutoCommit(false);

            String sql = ("UPDATE ILGAS.international_publishers SET Company = ?, Address1 = ?, Address2 = ?, Address3 = ?, Address4 = ?, postCode = ?, City = ?, Country = ?, CountryCode = ?, Email = ?, Telephone = ?, Fax = ?, WWW = ?, DONOTMAIL = ?, Bursaries = ?, Founded = ?, NumberOfTitles = ?, Notes = ?, Status = ? WHERE Company_Number = ?");

            ps1 = conn.prepareStatement(sql);

            ps1.setString(1, Company);
            ps1.setString(2, Address1);
            ps1.setString(3, Address2);
            ps1.setString(4, Address3);
            ps1.setString(5, Address4);
            ps1.setString(6, postCode);
            ps1.setString(7, City);
            ps1.setString(8, Country);
            ps1.setString(9, countryCode);
            ps1.setString(10, Email);
            ps1.setString(11, Telephone);
            ps1.setString(12, Fax);
            ps1.setString(13, WWW);
            ps1.setInt(14, doNotMail);
            ps1.setInt(15, Bursaries);
            ps1.setString(16, Founded);
            ps1.setString(17, NumberOfTitles);
            ps1.setString(18, notes);
            ps1.setString(19, Status);
            ps1.setString(20, PublisherID);

            ps1.executeUpdate();
            conn.commit();

            DBConn.close(conn, ps1, res);

        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps1, res);
            e.printStackTrace();
        }
        
        
        request.setAttribute("PublisherID", PublisherID);
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
}
