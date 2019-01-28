/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ie.irishliterature.misc;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ie.irishliterature.dao.ACAuthorDAO;
import ie.irishliterature.model.ACauthor;

/**
 *
 * @author markus
 */
@WebServlet(name = "ACAuthor", urlPatterns = {"/ACAuthor"})
public class ACAuthor extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ACAuthor() {
        
        super();

    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String text = request.getParameter("term");
        
        System.out.println("term:: " + text );
        
        ACAuthorDAO authorDAO  = new ACAuthorDAO();
        
        try {
            
            ArrayList<ACauthor> authors = authorDAO.getAuthors(text);
            
            authors.stream().map((author) -> {
             //  System.out.println(genre.getValue());
                return author;
            }).forEachOrdered((ACauthor author) -> {
          //      System.out.println(country.getId());
            });

            String searchResult = new Gson().toJson(authors);
            response.setContentType("application/json");
               response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.write(searchResult);

        } catch (IOException | ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException e) {
        }

    }

}
