package ie.irishliterature.servlets;

import ie.irishliterature.util.GlobalConstants;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /*
         * Getting session and then invalidating it
         */
        HttpSession session = request.getSession(false);

        if (request.isRequestedSessionIdValid() && session != null) {

            session.invalidate();

        }

//        Cookie[] cookies = request.getCookies();
//
//        for (Cookie cookie : cookies) {
//
//            cookie.setMaxAge(0);
//
//            cookie.setValue(null);
//
//            cookie.setPath("/");
//
//            response.addCookie(cookie);
//        }

        request.getSession().setAttribute(GlobalConstants.USER, null);
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

    }

//        session.removeAttribute("username");
//        session.removeAttribute("firstname");
//        session.removeAttribute("lastname");
//        session.removeAttribute("email");
//        session.removeAttribute("userID");
//        if (session != null) {
//            session.invalidate();
    /**
     *
     * This method would edit the cookie information and make JSESSIONID empty
     *
     * while responding to logout. This would further help in order to. This
     * would help
     *
     * to avoid same cookie ID each time a person logs in
     *
     * @param response
     *
     */
}
