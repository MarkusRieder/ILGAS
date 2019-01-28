package ie.irishliterature.emailRegistration;

import ie.irishliterature.dao.ApplicationDAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.User;
import ie.irishliterature.util.BCrypt;
import ie.irishliterature.util.GlobalConstants;
import ie.irishliterature.util.MailUtil;
import ie.irishliterature.util.Utils;
import java.io.IOException;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 * Servlet implementation class VerifyRegisteredEmailHash
 */
@WebServlet("/VerifyRegisteredEmailHash")
public class VerifyRegisteredEmailHash extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(VerifyRegisteredEmailHash.class.getName());

    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifyRegisteredEmailHash() {
        super();
    }

    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get user Id and email verification code Hash code  
        String uname = request.getParameter("userId");
        System.out.println("VerifyRegisteredEmailHash doGet username 1 : " + uname);
        String hash = BCrypt.hashpw(request.getParameter("hash"), GlobalConstants.SALT);
        String scope = request.getParameter("scope");
        String message = null;

        try {
            // verify with database
            if (ApplicationDAO.verifyEmailHash(uname, hash) && scope.equals(GlobalConstants.ACTIVATION)) {
                //update status as active

                System.out.println("VerifyRegisteredEmailHash doGet username 2 : " + uname);

                ApplicationDAO.updateStatus(uname, "active");

                message = "Email verified successfully. Account has been activated. Click <a href=\"index.jsp\">here</a> to login.";
        
              //  request.getRequestDispatcher("/WEB-INF/views/emailValidationSuccess.jsp").forward(request, response);

            } else if (ApplicationDAO.verifyEmailHash(uname, hash) && scope.equals(GlobalConstants.RESET_PASSWORD)) {
                //update status as active
                ApplicationDAO.updateStatus(uname, "active");
                //put some session for user
                request.getSession().setAttribute(GlobalConstants.USER, uname);
                request.getSession().setAttribute(GlobalConstants.IS_RESET_PASSWORD_VERIFIED, GlobalConstants.YES);
                request.getRequestDispatcher("/WEB-INF/resetPassword.html").forward(request, response);
            } else {
                //now increment verification attempts 
                int attempts = ApplicationDAO.incrementVerificationAttempts(uname);
                if (attempts == 20) {
                    // reset verification code if attempts equal to 20 
                    String hashcode = Utils.prepareRandomString(30);
                    ApplicationDAO.updateEmailVerificationHash(uname, BCrypt.hashpw(hashcode, GlobalConstants.SALT));
                    User up = ApplicationDAO.selectUSER(uname);
                    MailUtil.sendEmailRegistrationLink(uname, up.getEMAIL(), hashcode);
                    message = "20 times Wrong Email Validation Input Given. So we are sent new activation link to your Email";
                } else {
                    message = "Wrong Email Validation Input";
                }
            }
        } catch (DBException e) {
            LOGGER.debug(e.getMessage());
            message = e.getMessage();
        } catch (AddressException e) {
            message = e.getMessage();
            LOGGER.debug(e.getMessage());
        } catch (MessagingException e) {
            message = e.getMessage();
            LOGGER.debug(e.getMessage());
        }
        if (message != null) {
            request.setAttribute(GlobalConstants.MESSAGE, message);
            request.getRequestDispatcher("/messageToUser.jsp").forward(request, response);
        }
    }

}
