package com.sl.servlets;

import com.sl.db.DBConn;
import com.sl.db.DBException;
import com.sl.service.LoginService;
import com.sl.util.BCrypt;
import com.sl.util.GlobalConstants;

import com.sl.dao.ACpublisherDAO_test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/login.do")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final LoginService service = new LoginService();

    // private LoginService userValidationService = new LoginService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        request.setAttribute("username", request.getParameter("username"));
        request.setAttribute("password", request.getParameter("password"));
        request.setAttribute("firstname", request.getParameter("firstname"));
        request.setAttribute("lastname", request.getParameter("lastname"));
        request.setAttribute("email", request.getParameter("email"));

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("username: " + username);
        System.out.println("password: " + password);

        password = BCrypt.hashpw(request.getParameter("password"), GlobalConstants.SALT);
        System.out.println("password: 2 " + password);

        String[] replied = service.loginCheck(username, password);

        boolean isValidUser = Boolean.parseBoolean(replied[0]);

        String role = replied[1];
        String function = replied[2];
        String firstname = replied[3];
        String lastname = replied[4];
        String name = replied[5];
        String email = replied[6];
        int userID = Integer.parseInt(replied[7]);

        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("firstname", firstname);
        request.setAttribute("lastname", lastname);
        request.setAttribute("email", email);
        request.setAttribute("userID", userID);

        System.out.println("reply " + Arrays.toString(replied));

        if (isValidUser) {

            System.out.println("Heelllllooooooooooooooooooo");
            System.out.println("role: " + role);
            System.out.println("function: " + function);
            System.out.println("full name: " + name);

            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            session.setAttribute("firstname", firstname);
            session.setAttribute("lastname", lastname);
            session.setAttribute("email", email);
            session.setAttribute("userID", userID);

            System.out.println("firstname: " + firstname);
            System.out.println("lastname: " + lastname);
            System.out.println("email: " + email);
            System.out.println("userID: " + userID);

            // set full name
            session.setAttribute("name", name);

            if ("Literature Ireland Staff".equals(function)) {
                request.getRequestDispatcher("/WEB-INF/views/welcome_Staff.jsp").forward(request, response);
            } else {

                // user belongs to Publisher
                if ("Publisher".equals(function)) {
                    try {
                        System.out.println("Publisher here: ");

                        // get publisherID for userID
                        int publisherID = findpublisherID(userID);
                        String publisherName = findPublisherName(publisherID);

                        session.setAttribute("publisherID", publisherID);
                        session.setAttribute("publisherName", publisherName);

                        request.getSession().setAttribute(publisherName, publisherName);
                        request.setAttribute("publisherName", publisherName);

                        // if it is a New Publisher show publisherRegistration_1.jsp
                        // so user can fill in Publishers details 
                        boolean isNew = false;
                        isNew = ACpublisherDAO_test.isNewPublisher(publisherID);
                        System.out.println("Publisher isNew:1: " + isNew);
                        if (isNew == true) {

                            System.out.println("Publisher isNew:2: " + isNew);

                            //        if new Publisher go here (Status = "new")
                            //        here update Status to complete
                            request.getRequestDispatcher("/WEB-INF/views/publisherRegistration.jsp").forward(request, response);

                        } else {
                            System.out.println("Im here :1: ");
                            request.getRequestDispatcher("/WEB-INF/views/welcome_Publisher.jsp").forward(request, response);
                        }

                    } catch (DBException ex) {
                        java.util.logging.Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }

                } else {
                    if ("Expert Reader".equals(function)) {
                        request.getRequestDispatcher("/WEB-INF/views/welcome_ExpertReader.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/WEB-INF/views/welcome.jsp").forward(request, response);
                    }
                }
            }
        } else {

            System.out.println("Booooooooooooooooooo");
            request.setAttribute("errorMessage", "Invalid Credentials!!");
            request.getRequestDispatcher("/WEB-INF/views/login_error.jsp").forward(request, response);
        }
    }

    public static int findpublisherID(int userID) throws DBException {

        int publisherID = 0;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;

        try {
            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT userID, Company_Number FROM PublisherUserJoined WHERE PublisherUserJoined.userID = userID");
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    publisherID = res.getInt("Company_Number");
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            e.printStackTrace();
            throw new DBException("2 Excepion while accessing database");
        }

        System.out.println("findpublisherID::publisherID " + publisherID);

        return publisherID;
    }

    public static String findPublisherName(int Company_Number) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        String publisherName = "";

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT Company FROM international_publishers WHERE international_publishers.Company_Number = Company_Number");
            res = ps.executeQuery();
            if (res != null) {
                while (res.next()) {
                    publisherName = res.getString("Company");
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            e.printStackTrace();
            throw new DBException("2 Excepion while accessing database");
        }

        System.out.println("findPublisherName::publisherName " + publisherName);

        return publisherName;
    }
}
