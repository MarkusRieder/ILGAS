package ie.irishliterature.emailRegistration;

import ie.irishliterature.dao.ApplicationDAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.Status;
import ie.irishliterature.util.BCrypt;
import ie.irishliterature.util.GlobalConstants;
import ie.irishliterature.util.Utils;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 * Servlet implementation class ChangePassword
 */

 @WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(ChangePassword.class.getName());
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePassword() {
        super();
        // TODO Auto-generated constructor stub
    }

        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Integer userId = (Integer) request.getSession().getAttribute(GlobalConstants.USER);
    	if(userId != null) {
            
             System.out.println("ChangePassword: doGet " +userId );
            
    		request.getRequestDispatcher("/WEB-INF/changePassword.html").forward(request, response);	
    	} else {
    		String message = "Clic <a href=\"index.jsp\">here</a> to login";
    		request.setAttribute(GlobalConstants.MESSAGE, message);
			request.getRequestDispatcher("/messageToUser.jsp").forward(request, response);
    	}
    }
    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String inputCurrentPassword = null;
                System.out.println("here we are now");
		if(request.getParameter("inputCurrentPassword")!=null) {
			inputCurrentPassword = BCrypt.hashpw(request.getParameter("inputCurrentPassword"), GlobalConstants.SALT);	
		}
		String inputPassword = null;
		if(request.getParameter("inputPassword")!=null) {
			inputPassword = BCrypt.hashpw(request.getParameter("inputPassword"), GlobalConstants.SALT);	
		}
		String userId = (String)request.getSession().getAttribute(GlobalConstants.USER);
                        System.out.println("ChangePassword: doPost userId : " + userId);
		String isResetPasswordVerified = (String) request.getSession().getAttribute(GlobalConstants.IS_RESET_PASSWORD_VERIFIED);
                
                      System.out.println("there there");
                      
		Status sp = new Status();
		
		try {
			if(userId!=null && inputCurrentPassword != null) {
				if(ApplicationDAO.verifyUserIdAndPassword(userId, inputCurrentPassword)) {
					ApplicationDAO.updatePassword(userId, inputPassword);
					sp.setCode(0);
					sp.setMessage("Password changed successfully");
				} else {
					sp.setCode(-1);
					sp.setMessage("Current password didn't match");
				}	
			} else if(userId!=null && isResetPasswordVerified != null) {
				ApplicationDAO.updatePassword(userId, inputPassword);
				sp.setCode(0);
				sp.setMessage("Password changed successfully");
			} else {
				sp.setCode(-1);
				sp.setMessage("Invalid input");
			}
		} catch (DBException e) {
			LOGGER.debug(e.getMessage());
			sp.setCode(-1);
			sp.setMessage(e.getMessage());
		}
            try (PrintWriter pw = response.getWriter()) {
                pw.write(Utils.toJson(sp));
                pw.flush();
            }
	}

}
