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

import ie.irishliterature.dao.ACTranslatorDAO;
import ie.irishliterature.model.ACtranslator;

/**
 *
 * @author markus
 * 
 * AC for AutoComplete
 */
@WebServlet(name = "ACTranslator", urlPatterns = {"/ACTranslator"})
public class ACTranslator extends HttpServlet {
    
 private static final long serialVersionUID = 1L;

    public ACTranslator() {
        
        super();

    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String text = request.getParameter("term");
        
        System.out.println("term:: " + text );
        
        ACTranslatorDAO translatorDAO  = new ACTranslatorDAO();
        
        try {
            
            ArrayList<ACtranslator> translators = translatorDAO.getTranslators(text);
            
            translators.stream().map((translator) -> {
             //  System.out.println(genre.getValue());
                return translator;
            }).forEachOrdered((ACtranslator translator) -> {
          //      System.out.println(country.getId());
            });

            String searchResult = new Gson().toJson(translators);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter writer = response.getWriter();
            writer.write(searchResult);

        } catch (IOException | ClassNotFoundException | IllegalAccessException | InstantiationException | SQLException e) {
        }

    }

}
