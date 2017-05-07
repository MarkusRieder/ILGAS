package com.sl.emailRegistration;

import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.sl.dao.ApplicationDAO;
import com.sl.db.DBException;
import com.sl.model.Status;
import com.sl.model.User;
import com.sl.util.BCrypt;
import com.sl.util.GlobalConstants;
import com.sl.util.MailUtil;
import com.sl.util.Utils;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ForgotPassword.class.getName());

    public ForgotPassword() {
        super();
    }

    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputEmail = request.getParameter("inputEmail");
        Status sp = new Status();
        try {
            User up = ApplicationDAO.selectUSERbyEmail(inputEmail);
            if (up != null) {
                String hash = Utils.prepareRandomString(30);
                ApplicationDAO.updateEmailVerificationHashForResetPassword(inputEmail, BCrypt.hashpw(hash, GlobalConstants.SALT));
                MailUtil.sendResetPasswordLink(up.getUSERNAME()+ "", inputEmail, hash);
                sp.setCode(0);
                sp.setMessage("We have sent reset password link to your email");
            } else {
                sp.setCode(-1);
                sp.setMessage("This email doesn't exist");
            }
        } catch (DBException | MessagingException e) {
            LOGGER.debug(e.getMessage());
            sp.setCode(-1);
            sp.setMessage(e.getMessage());
        }
        PrintWriter pw = response.getWriter();
        pw.write(Utils.toJson(sp));
        pw.flush();
        pw.close();
    }

}
