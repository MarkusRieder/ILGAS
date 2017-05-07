import com.google.gson.Gson;
import com.sl.dao.ACCountryDAO;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sl.model.ACcountry;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Servlet implementation class AutoComplete_international_publishers
 */
@WebServlet(urlPatterns = "/AutoComplete_country")
public class AutoComplete_country extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public AutoComplete_country() {
        super();

    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String text = request.getParameter("term");
        ACCountryDAO countryDAO  = new ACCountryDAO();
        try {
            ArrayList<ACcountry> countries = countryDAO.getCountry(text);
            countries.stream().map((country) -> {
           //    System.out.println(country.getValue());
                return country;
            }).forEachOrdered((country) -> {
          //      System.out.println(country.getId());
            });

            String searchResult = new Gson().toJson(countries);
            PrintWriter writer = response.getWriter();
            writer.write(searchResult);

        } catch (IOException | ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException e) {
        }

    }
}

