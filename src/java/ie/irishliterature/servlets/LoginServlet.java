package ie.irishliterature.servlets;

import ie.irishliterature.dao.ACpublisherDAO_test;
import ie.irishliterature.db.DBConn;
import ie.irishliterature.db.DBException;
import ie.irishliterature.service.LoginService;
import ie.irishliterature.util.BCrypt;
import ie.irishliterature.util.GlobalConstants;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Enumeration;
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

//        request.setAttribute("username", request.getParameter("username"));
//        request.setAttribute("password", request.getParameter("password"));
//        request.setAttribute("firstname", request.getParameter("firstname"));
//        request.setAttribute("lastname", request.getParameter("lastname"));
//        request.setAttribute("email", request.getParameter("email"));



        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String lastLogon = request.getParameter("lastLogon");
        long lastLogonForm = Long.parseLong(lastLogon);
        
        System.out.println("username: " + username);
        System.out.println("password: " + password);
        System.out.println("lastLogonForm: " + lastLogonForm);

        password = BCrypt.hashpw(request.getParameter("password"), GlobalConstants.SALT);
        System.out.println("password: 2 " + password);

        String[] replied = service.loginCheck(username, password, lastLogonForm);

        boolean isValidUser = Boolean.parseBoolean(replied[0]);
        boolean LogonPassed = Boolean.parseBoolean(replied[8]);

        if (isValidUser && LogonPassed) {

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

            System.out.println("Heelllllooooooooooooooooooo");
            System.out.println("role: " + role);
            System.out.println("function: " + function);
            System.out.println("full name: " + name);

            // Setting user session
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

            System.out.println("###################################################################");
            System.out.println("Enumeration keys   ");
            Enumeration keys = session.getAttributeNames();
            while (keys.hasMoreElements()) {
                String key = (String) keys.nextElement();
                System.out.println("key  :" + key + ": " + session.getValue(key));
            }
            System.out.println("###################################################################");

            if ("Literature Ireland Staff".equals(function)) {

                System.out.println("calling /WEB-INF/views/welcome_Staff.jsp .... ");

                request.getRequestDispatcher("/WEB-INF/views/welcome_Staff.jsp").forward(request, response);
//                request.getRequestDispatcher("/WEB-INF/views/newjsp.jsp").forward(request, response);
            } else {

                // user belongs to Publisher
                if ("Publisher".equals(function)) {
                    try {
                        System.out.println("Publisher here: ");
                        System.out.println("Publisher here:userID::  " + userID);

                        // get publisherID for userID
                        int publisherID = findpublisherID(userID);
                        String publisherName = findPublisherName(publisherID);

                        System.out.println("Publisher publisherName: " + publisherName);

                        session.setAttribute("publisherID", publisherID);
                        session.setAttribute("Company_Number", publisherID);
                        session.setAttribute("publisherName", publisherName);

                        publisherID = (int) session.getAttribute("publisherID");

                        System.out.println("login publisherID: " + publisherID);

                        request.getSession().setAttribute(publisherName, publisherName);
                        request.setAttribute("publisherName", publisherName);

                        // if it is a New Publisher show publisherRegistration_1.jsp
                        // so user can fill in Publishers details 
                        boolean isNew = false;
                        isNew = ACpublisherDAO_test.isNewPublisher(publisherID);
                        System.out.println("Publisher isNew:1: " + isNew);
                        if (isNew == true) {

                            System.out.println("Publisher isNew:2: " + isNew);

                            // if new Publisher go here (Status = "new")
                            // here update Status to complete
                            request.getRequestDispatcher("/WEB-INF/views/publisherRegistration.jsp").forward(request, response);

                        } else {
                            System.out.println("Im here :1: ");
                            session.setAttribute("publisherID", publisherID);
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
            ps = conn.prepareStatement("SELECT userID, Company_Number FROM PublisherUserJoined WHERE PublisherUserJoined.userID = ?");
            ps.setInt(1, userID);
            res = ps.executeQuery();
            if (res != null) {

                if (res.next()) {
                    System.out.println("findpublisherID::publisherID " + res.getInt("Company_Number"));
                    publisherID = res.getInt("Company_Number");
                }
            }
            DBConn.close(conn, ps, res);
        } catch (ClassNotFoundException | SQLException e) {
            DBConn.close(conn, ps, res);
            e.printStackTrace();
            throw new DBException("2 Excepion while accessing database");
        }

        System.out.println("findpublisherID::userID " + userID);
        System.out.println("findpublisherID::publisherID " + publisherID);

        return publisherID;
    }

    public static String findPublisherName(int Company_Number) throws DBException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet res = null;
        int publisherID = Company_Number;
        String publisherName = "";

        System.out.println("findPublisherName: " + Company_Number);

        try {

            conn = DBConn.getConnection();
            ps = conn.prepareStatement("SELECT Company FROM international_publishers WHERE international_publishers.Company_Number = ?");
            ps.setInt(1, publisherID);
            res = ps.executeQuery();
            if (res != null) {
                if (res.next()) {
                    publisherName = res.getString("Company");
                    System.out.println("findPublisherName: res: " + publisherName);
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
