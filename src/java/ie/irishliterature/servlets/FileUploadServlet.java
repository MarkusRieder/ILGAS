package ie.irishliterature.servlets;

/**
 * Copyright (c) 2014 Oracle and/or its affiliates. All rights reserved.
 *
 * You may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License at:
 * http://java.net/projects/javaeetutorial/pages/BerkeleyLicense
 */
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * File upload servlet example
 */
@WebServlet(name = "FileUploadServlet", urlPatterns = {"/upload"})
@MultipartConfig
public class FileUploadServlet extends HttpServlet {

    private final static Logger LOGGER
            = Logger.getLogger(FileUploadServlet.class.getCanonicalName());
    private static final long serialVersionUID = 7908187011456392847L;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }

        return null;
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        String userID = request.getParameter("userID");
//        String ApplicationNumber = request.getParameter("ApplicationNumber");
//        String Company = request.getParameter("Company");
//        String PublisherID = request.getParameter("publisherID");
//        String agreement = request.getParameter("agreement");
//        String contract = request.getParameter("contract");
//        String translatorCV = request.getParameter("translatorCV");
//        String copiesTranslationSample = request.getParameter("copiesTranslationSample");
//        String NewApplicationID = request.getParameter("newApplicationID");
        System.out.println(" ---------------------doPost------------------------------  ");

//        String[] fileNames = request.getParameterValues("file");
//
//        String agreement = fileNames[0];
//        String contract = fileNames[1];
//        String translatorCV = fileNames[2];
//        String copiesTranslationSample = fileNames[3];
        System.out.println("userID  " + request.getParameter("userID"));
       // System.out.println("ApplicationNumber  " + request.getParameter("ApplicationNumber"));
        System.out.println("Company " + request.getParameter("Company"));
        System.out.println("PublisherID  " + request.getParameter("publisherID"));
//        System.out.println("Agreement  " + agreement);
//        System.out.println("Contract  " + contract);
//        System.out.println("TranslatorCV " + translatorCV);
//        System.out.println("CopiesTranslationSample  " + copiesTranslationSample);
        System.out.println("NewApplicationID  " + request.getParameter("newApplicationID"));

        System.out.println(" ----------------------processRequest-----------------------------  ");

        System.out.println("userID  " + request.getParameter("userID"));
     //   System.out.println("ApplicationNumber  " + request.getParameter("ApplicationNumber"));
        System.out.println("Company " + request.getParameter("Company"));
        System.out.println("PublisherID  " + request.getParameter("publisherID"));
        System.out.println("Agreement  " + request.getParameter("agreement"));
        System.out.println("Contract  " + request.getParameter("contract"));
        System.out.println("TranslatorCV " + request.getParameter("translatorCV"));
        System.out.println("CopiesTranslationSample  " + request.getParameter("copiesTranslationSample"));
        System.out.println("NewApplicationID  " + request.getParameter("newApplicationID"));

        String userID = request.getParameter("userID");
     //   String ApplicationNumber = request.getParameter("ApplicationNumber");
        String Company = request.getParameter("Company");
        String PublisherID = request.getParameter("publisherID");

    //    System.out.println("userID= " + userID + " ApplicationNumber= " + ApplicationNumber + " Company= " + Company + " PublisherID= " + PublisherID);
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        String yearInString = String.valueOf(year);

        // Create path components to save the file
        // path = path + File.separator + yearInString + File.separator + Company + File.separator + Type + ApplicationNumber;
        String rootPath = "/home/markus/test";
//ApplicationNumber
        final String path = rootPath + File.separator + yearInString + File.separator + Company + File.separator  + File.separator + request.getParameter("destination");
        final Part filePart = request.getPart("file");
        final String fileName = getFileName(filePart);

        File file = new File(path);
        if (!file.exists()) {
            file.mkdirs();
        }

        System.out.println("Upload File Directory = " + path);
        
        String[] fileNames ;
  
        

        OutputStream out = null;
        InputStream filecontent = null;
        final PrintWriter writer = response.getWriter();

        try {
            out = new FileOutputStream(new File(path + File.separator
                    + fileName));
            filecontent = filePart.getInputStream();

            int read;
            final byte[] bytes = new byte[1024];

            while ((read = filecontent.read(bytes)) != -1) {
                out.write(bytes, 0, read);

            }


            String test = (String)request.getParameter("anchor");
            System.out.println("anchor = " + test);

            request.setAttribute("message", " '" + fileName + "' -  File uploaded successfully!");
            request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);

        } catch (FileNotFoundException fne) {

            String errMsg = "<br/><br/>You either did not specify a file to upload or are "
                    + "trying to upload a file to a protected or nonexistent "
                    + "location.<br/> <br/><strong> ERROR:<strong> '" + fne.getMessage() + "' ";

            request.setAttribute("message", " '<strong>" + fileName + "</strong>" + errMsg);
            request.getRequestDispatcher("/WEB-INF/views/uploadErrorResponse.jsp").forward(request, response);

            LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}",
                    new Object[]{fne.getMessage()});
        } finally {
            if (out != null) {
                out.close();
            }
            if (filecontent != null) {
                filecontent.close();
            }
            if (writer != null) {
                writer.close();
            }
        }
        System.out.println("xxfileNames:  " + fileName);
//        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet that uploads files to a user-defined destination";
    }

}
