package ie.irishliterature.servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import ie.irishliterature.dao.ACpublisherDAO_test;
import ie.irishliterature.dao.ApplicationDAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.Publisher;
import ie.irishliterature.model.Status;
import ie.irishliterature.model.User;
import ie.irishliterature.util.BCrypt;
import ie.irishliterature.util.GlobalConstants;
import ie.irishliterature.util.MailUtil;
import ie.irishliterature.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author markus
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // private LoginService userValidationService = new LoginService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("/WEB-INF/views/signUp.jsp").forward(request, response);
    }

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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // collect all input values
        //  PrintWriter out = response.getWriter();
        // values for user table
        String username = request.getParameter("uname");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String function = request.getParameter("function");
        String role = request.getParameter("role");

        int PublisherID = 0;


        /*
         * values for new publisher
         */
        String company = request.getParameter("company");
        String companyNumber = request.getParameter("companyNumber");
        String newPublisher = request.getParameter("newPublisher");
        String cbnewPublisher = request.getParameter("cbnewPublisher");

        if (!"".equals(companyNumber)) {
            PublisherID = Integer.parseInt(request.getParameter("companyNumber"));
        }
        
        
        int userID = 0;

        System.out.println("username  " + username);
        System.out.println("company  " + company);
        System.out.println("companyNumber  " + companyNumber);
        System.out.println("newPublisher  " + newPublisher);
        System.out.println("cbnewPublisher:::  " + cbnewPublisher);

        request.setAttribute("newPublisher", request.getParameter("newPublisher"));

        /*
         * if newPublisher checkbox is checked
         */
        if (request.getParameter("cbnewPublisher") != null) {
            try {
                System.out.println("cbnewPublisher  IS here");

                String cmpny = newPublisher;

                System.out.println("cmpny::  " + cmpny);

                /*
                 * double check if Publisher exists
                 */
                if (!ACpublisherDAO_test.isPublisherExists(cmpny)) {
                    System.out.println("newPublisher does not exist - create new one");

                    /*
                     * create Publisher if account does not exists
                     */
                    Publisher publisher = new Publisher();

                    publisher.setCompany(newPublisher);
                    publisher.setStatus("new");

                    PublisherID = ACpublisherDAO_test.insertRudimentaryPublisher(publisher);

                    System.out.println("PublisherID:: 1 " + PublisherID);

                }
            } catch (DBException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        System.out.println("PublisherID:: 2 " + PublisherID);

        request.setAttribute("uname", request.getParameter("uname"));
        request.setAttribute("firstname", request.getParameter("firstname"));
        request.setAttribute("lastname", request.getParameter("lastname"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("PublisherID", PublisherID);

        Status sp = new Status();
        String output = "";
        if (!validate(username, firstname, lastname, password, email)) {
            sp.setCode(-1);
            sp.setMessage("Invalid Input");
            output = Utils.toJson(sp);
        } else {
            User user = new User();
            user.setUSERNAME(username);
            user.setFIRST_NAME(firstname);
            user.setLAST_NAME(lastname);

            /*
             * generate hash for password
             */
            user.setPASSWORD(BCrypt.hashpw(password, GlobalConstants.SALT));

            user.setEMAIL(email);

            /*
             * generate hash code for email verification
             */
            String hash = Utils.prepareRandomString(30);

            /*
             * generate hash for password
             */
            user.setEMAIL_VERIFICATION_HASH(BCrypt.hashpw(hash, GlobalConstants.SALT));

            if (role
                    == null) {
                role = "not assigned";
            }

            user.setROLE(role);

            user.setFUNCTION(function);

            try {

                /*
                 * check whether email exists or not
                 */
                if (!ApplicationDAO.isEmailExists(email)) {

                    System.out.println("isEmailExists Not:: ");

                    /*
                     * create account if email not exists
                     */
                    userID = ApplicationDAO.insertRow(user);
                    System.out.println("userID:: " + userID);

                    System.out.println("PublisherID:: " + PublisherID);

                    /*
                     * here we insert userID and PublisherID into PublisherUser
                     * joined table
                     */
                    int result = ACpublisherDAO_test.insertPublisherUserJoined(userID, PublisherID);
                    System.out.println("insertPublisherUserJoined:  " + result);

                    /*
                     * send verification email
                     */
                    MailUtil.sendEmailRegistrationLink(username, email, hash);
                    sp.setCode(0);
                    sp.setMessage("Registation Link Was Sent To Your Mail Successfully. Please Verify Your Email");
                    output = Utils.toJson(sp);
                } else {
                    /*
                     * tell user that the email already in use
                     */
                    sp.setCode(-1);
                    sp.setMessage("This Email is already registered");
                    output = Utils.toJson(sp);
                }

            } catch (DBException | MessagingException e) {
                sp.setCode(-1);
                sp.setMessage(e.getMessage());
                output = Utils.toJson(sp);
            }

        }

        request.getRequestDispatcher("/WEB-INF/views/registrationSuccess.jsp").forward(request, response);

        try (
                /*
                 * send output to user
                 */
                PrintWriter pw = response.getWriter()) {
            pw.write(output);
            pw.flush();
        }
    }

    public static boolean validate(String username, String firstName, String lastName, String password, String email) {
        if (username == null) {
            return false;
        }
        if (firstName == null) {
            return false;
        }
        if (lastName == null) {
            return false;
        }
        if (password == null) {
            return false;
        }
        if (email == null) {
            return false;
        }
        return true;
    }
}
