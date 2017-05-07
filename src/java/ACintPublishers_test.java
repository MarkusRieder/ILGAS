
import com.google.gson.Gson;
import com.sl.dao.ACpublisherDAO_test;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sl.model.Publisher;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Servlet implementation class ACintPublishers
 */
@WebServlet(urlPatterns = "/ACintPublishers_test")
public class ACintPublishers_test extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ACintPublishers_test() {
        super();

    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("doGet ......_test.............");
        String text = request.getParameter("term");
        System.out.println("Hello from Get Method: " + text);

        ACpublisherDAO_test publisherDAO_test = new ACpublisherDAO_test();
        try {
            ArrayList<Publisher> publishers = publisherDAO_test.getpublisher(text);
            publishers.stream().map((publisher) -> {
                System.out.println(publisher.getValue());
                return publisher;
            }).forEachOrdered((Publisher publisher) -> {
                System.out.println(publisher.getId());
                System.out.println("1:: " + publisher.getAddress1());
                System.out.println("2:: " + publisher.getAddress2());
                System.out.println("3:: " + publisher.getAddress3());
                System.out.println("4:: " + publisher.getAddress4());
                System.out.println("5:: " + publisher.getPostCode());
                System.out.println("6:: " + publisher.getCity());
                System.out.println("6:: " + publisher.getCountry());
                System.out.println("6:: " + publisher.getCountryCode());
                System.out.println("6:: " + publisher.getTelephone());
                System.out.println("6:: " + publisher.getFax());
                System.out.println("6:: " + publisher.getWWW());
                System.out.println("6:: " + publisher.getDoNotMail());
                System.out.println("6:: " + publisher.getBursaries());
                System.out.println("6:: " + publisher.getFounded());
                System.out.println("6:: " + publisher.getNumberOfTitles());
                System.out.println("6:: " + publisher.getDateModified());
                System.out.println("6:: " + publisher.getNotes());
                System.out.println("6:: " + publisher.getStatus());
                
                System.out.println("isDoNotMail:: " + publisher.getDoNotMail());
                System.out.println("isBursaries:: " + publisher.getBursaries());
            });

            String searchResult = new Gson().toJson(publishers);
            System.out.println("searchResult:  " + searchResult);
            PrintWriter writer = response.getWriter();
            writer.write(searchResult);

        } catch (IOException | ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException e) {
        }

    }
}
