package ie.irishliterature.misc;


import com.google.gson.Gson;
import ie.irishliterature.dao.ACpublisherDAO;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ie.irishliterature.model.ACpublisher;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Servlet implementation class ACintPublishers
 */
@WebServlet(urlPatterns = "/ACintPublishers")
public class ACintPublishers extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ACintPublishers() {
        super();

    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String text = request.getParameter("term");
        ACpublisherDAO publisherDAO = new ACpublisherDAO();
        try {
            ArrayList<ACpublisher> publishers = publisherDAO.getpublisher(text);
            publishers.stream().map((publisher) -> {
             //   System.out.println(publisher.getValue());
                return publisher;
            }).forEachOrdered((publisher) -> {
             //   System.out.println(publisher.getId());
            });

            String searchResult = new Gson().toJson(publishers);
            PrintWriter writer = response.getWriter();
            writer.write(searchResult);

        } catch (IOException | ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException e) {
        }

    }
}
