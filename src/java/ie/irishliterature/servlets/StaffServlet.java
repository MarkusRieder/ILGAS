package ie.irishliterature.servlets;

import ie.irishliterature.dao.Test1DAO;
import ie.irishliterature.db.DBException;
import ie.irishliterature.model.GrantApplication;
import java.io.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "StaffServlet", urlPatterns = {"/StaffServlet"})
public class StaffServlet extends HttpServlet {

    private final static Logger LOGGER
            = Logger.getLogger(StaffServlet.class.getCanonicalName());
    private static final long serialVersionUID = 7908187011456392847L;

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For file upload
    ///
    ////////////////////////////////////////////////////////////////////////////
    private boolean isMultipart;
    private String filePath;
    private String rootPath;
    private final int maxFileSize = 50 * 1024;
    private final int maxMemSize = 4 * 1024;
    //  private File file;
    private String tempPath = "";

    ////////////////////////////////////////////////////////////////////////////
    ///
    ///  For Irish Literature Staff
    ///
    ////////////////////////////////////////////////////////////////////////////
    private String referenceNumber;  //Array of Author/Title
    private String applicationYear;
    private String notesAboutApplication;                   // path to file
    private String dateOfBoardMeeting = ""; //  Date
    private String ApproveWithdrawnReject = ""; //  Date
    private int approveWithdrawnReject = 0;
    private int directorChairDecision = 0;
    private String DirectorChairDecision;
    private String amountApproved; //  Date
    private String Date_ILE_Acknowlegement_Approved = ""; //  Date
    private String Date_Published_Books_Received = ""; //  Date
    private String Date_Payment_Made_to_Publisher = ""; //  Date
    private String Payment_Reference_Number;
    private String plannedPageExtent;
    private String proposedPrintRun;
    private int copiesSent;
    private String CopiesSent;
    private String Comments_re_Application;
    private String Board_Meeting;
    private String Date_publisher_informed_of_meeting = ""; //  Date 
    private String Award;
    private int award = 0; //    boolean
    private String Bilingual;
    private int bilingual = 0; //    boolean        
    private String Amount_Requested;
    private String Amount_Approved;
    private String Comments_about_Meeting;
    private String Proposed_Publication_Date; //  Date
    private String Previous_Grant_Aid; // Array of Author/Title
    private String Press_cuttings;  //  boolean
    private String Sales_figures;
    private String Anthology; //Array of Author/Title
    private String Status = "";
    private String Date_Contract_Sent_to_Publisher = "";
    private String message = "";
    private String PaymentStatus;

    @Override
    public void init() {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();

            //  String task = "Start New Application";
            //  String[] authorArray;
            //  String task = request.getParameter("AssignExpertReader");
            //  String task = request.getParameter("task");
            //  String name = request.getParameter("name");
            //  String value = request.getParameter("value");
            String task = String.valueOf(request.getSession().getAttribute("task"));

            System.out.println("StaffServlet :: ");
            System.out.println("HttpSession session :: sess: " + task);
//            request.setAttribute("username", username);
//            request.setAttribute("password", password);
//            request.setAttribute("firstname", firstname);
//            request.setAttribute("lastname", lastname);
//            request.setAttribute("email", email);
//            request.setAttribute("userID", userID);
//            
//                        // Setting user session
//           
//            session.setAttribute("username", username);
//            session.setAttribute("firstname", firstname);
//            session.setAttribute("lastname", lastname);
//            session.setAttribute("email", email);
//            session.setAttribute("userID", userID);

            String name = request.getParameter("name");
            System.out.println("Here we are >>>>>>>>>.   StaffServlet ::  name " + name);

//        switch (task) {
//            case "StaffServlet":
            System.out.println("Here we are >>>>>>>>>.   StaffServlet :: StaffServlet");

            java.sql.Timestamp timestamp = getcurrentTimeStamp();

            referenceNumber = request.getParameter("appReferenceNumber");
            applicationYear = referenceNumber.split("/")[1];
            System.out.println("param1 applicationYear " + applicationYear);
            notesAboutApplication = request.getParameter("appNotesAboutApplication");

            System.out.println("param1 notesAboutApplication " + notesAboutApplication);
            dateOfBoardMeeting = request.getParameter("appDateOfBoardMeeting");
            System.out.println("param2 dateOfBoardMeeting " + dateOfBoardMeeting);
            ApproveWithdrawnReject = request.getParameter("ApproveWithdrawnReject");
            System.out.println("param3  ApproveWithdrawnReject  " + ApproveWithdrawnReject);
            DirectorChairDecision = request.getParameter("directorChairDecision");

            if ("ticked".equals(ApproveWithdrawnReject)) {
                approveWithdrawnReject = 1;
            } else {
                approveWithdrawnReject = 0;
            }

            if ("ticked".equals(DirectorChairDecision)) {
                directorChairDecision = 1;
            } else {
                directorChairDecision = 0;
            }

            System.out.println("param4  directorChairDecision " + directorChairDecision);
            Comments_about_Meeting = request.getParameter("commentsAboutMeeting");
            System.out.println("param5 Comments_about_Meeting " + Comments_about_Meeting);

            plannedPageExtent = request.getParameter("appplannedPageExtent");
            System.out.println("param6 plannedPageExtent " + plannedPageExtent);
            proposedPrintRun = request.getParameter("appproposedPrintRun");
            System.out.println("param7 proposedPrintRun " + proposedPrintRun);

            if ("ticked".equals(Award)) {
                award = 1;
            } else {
                award = 0;
            }

            System.out.println("param8 award " + award);
            amountApproved = request.getParameter("amountApproved");
            System.out.println("param9 amountApproved " + amountApproved);
            Date_publisher_informed_of_meeting = request.getParameter("datePublisherInformedOfMeeting");
            System.out.println("param10 Date_publisher_informed_of_meeting " + Date_publisher_informed_of_meeting);
            Date_Contract_Sent_to_Publisher = request.getParameter("dateContractSenttoPublisher");
            System.out.println("param11 Date_Contract_Sent_to_Publisher " + Date_Contract_Sent_to_Publisher);
            Date_ILE_Acknowlegement_Approved = request.getParameter("dateILEAcknowledgementApproved");
            System.out.println("param12 Date_ILE_Acknowlegement_Approved " + Date_ILE_Acknowlegement_Approved);
            Date_Published_Books_Received = request.getParameter("datePublishedBooksReceived");
            System.out.println("param13 Date_Published_Books_Received " + Date_Published_Books_Received);
            Date_Payment_Made_to_Publisher = request.getParameter("datePaymentMadeToPublisher");
            System.out.println("param14 Date_Payment_Made_to_Publisher " + Date_Payment_Made_to_Publisher);
            Payment_Reference_Number = request.getParameter("paymentReferenceNumber");
            System.out.println("param15 Payment_Reference_Number " + Payment_Reference_Number);
            PaymentStatus = request.getParameter("paymentStatus");
            System.out.println("param16 PaymentStatus " + PaymentStatus);
            Status = "closed";

            ////////////////////////////////////////////////////////////
            //  Process Application
            ////////////////////////////////////////////////////////////
            GrantApplication application = new GrantApplication();

            application.setNotesAboutApplication("'" + notesAboutApplication + "'");
            System.out.println("sending dateOfBoardMeeting  " + dateOfBoardMeeting);
            if (!dateOfBoardMeeting.isEmpty()) {
                application.setBoardMeeting(convertStringDate(dateOfBoardMeeting));
            }
            application.setApproveWithdrawnReject(ApproveWithdrawnReject);
            System.out.println("sending approveWithdrawnReject  " + approveWithdrawnReject);
            application.setDirectorChairDecision(directorChairDecision);
            application.setBoardComments_Instructions(Comments_about_Meeting);
            application.setAward(award);
            if (!amountApproved.isEmpty()) {
                BigDecimal aa = new BigDecimal(amountApproved.replaceAll(",", ""));
                System.out.println("amountApproved  " + amountApproved);
                System.out.println("aa  " + aa);
                application.setAmountApproved(aa);
            }
            if (!Date_publisher_informed_of_meeting.isEmpty()) {
                System.out.println("sending Date_publisher_informed_of_meeting  " + Date_publisher_informed_of_meeting);

                application.setPublisherInformedOfMeeting(convertStringDate(Date_publisher_informed_of_meeting));
            }
//            if (!Date_publisher_informed_of_meeting.isEmpty() && Date_publisher_informed_of_meeting != null && !"".equals(Date_publisher_informed_of_meeting)) {
            if (convertStringDate(Date_Contract_Sent_to_Publisher) != null) {
                System.out.println("sending Date_Contract_Sent_to_Publisher  " + Date_Contract_Sent_to_Publisher);
System.out.println("sending Date_Contract_Sent_to_Publisher  " + convertStringDate(Date_Contract_Sent_to_Publisher));
                application.setContractSentToPublisher(convertStringDate(Date_Contract_Sent_to_Publisher));
            }
            System.out.println("sending Date_ILE_Acknowlegement_Approved  " + Date_ILE_Acknowlegement_Approved);
            if (!Date_ILE_Acknowlegement_Approved.isEmpty()) {
                application.setAcknowledgementApproved(convertStringDate(Date_ILE_Acknowlegement_Approved));
            }
            System.out.println("sending Date_Published_Books_Received  " + Date_Published_Books_Received);
            if (!Date_Published_Books_Received.isEmpty()) {
                application.setDatePublishedBooksReceived(convertStringDate(Date_Published_Books_Received));
            }
            System.out.println("sending Date_Payment_Made_to_Publisher  " + Date_Payment_Made_to_Publisher);
            if (!Date_Payment_Made_to_Publisher.isEmpty()) {
                application.setDatePaymentMadeToPublisher(convertStringDate(Date_Payment_Made_to_Publisher));
            }
            application.setPaymentReferenceNumber(Payment_Reference_Number);
            application.setPaymentStatus(PaymentStatus);

            System.out.println("sending plannedPageExtent  " + plannedPageExtent);
            System.out.println("sending proposedPrintRun  " + proposedPrintRun);

            application.setProposedPrintRun(Integer.parseInt(plannedPageExtent));
            application.setPlannedPageExtent(Integer.parseInt(proposedPrintRun));

            application.setStatus(Status);
            application.setLASTUPDATED(timestamp);

            String applicationNumber = referenceNumber.split("/")[0];

            Test1DAO.updateApplication(application, applicationNumber, applicationYear);

            /*
             * reset session
             */
            session.removeAttribute("task");

            message = "The application with reference number: " + referenceNumber + " has been updated ";
            request.setAttribute("message", message);
            request.setAttribute("name", name);
            request.getRequestDispatcher("/WEB-INF/views/response.jsp").forward(request, response);
        } catch (ParseException | DBException | SQLException ex) {
            Logger.getLogger(StaffServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, java.io.IOException {

        throw new ServletException("GET method used with "
                + getClass().getName() + ": POST method required.");
    }

    public Date convertDate(String datum) throws ParseException {

        DateFormat sourceFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = sourceFormat.parse(datum);

        return date;

    }

    public java.sql.Date convertStringDate(String datum) throws ParseException {

        if(!"".equals(datum)){
        System.out.println("convertStringDate datum  " + datum);
        SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
        System.out.println("convertStringDate sdf1  " + sdf1);
        java.util.Date date = sdf1.parse(datum);
        System.out.println("convertStringDate date  " + date);
        java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
        System.out.println("convertStringDate sqlStartDate  " + sqlStartDate);
        
         return sqlStartDate;
         
        }
        else{
            System.out.println("convertStringDate datum  = null " + datum);
        }
        return null;
    }

    public java.sql.Date getTodaySQL() {
        java.util.Date today = new java.util.Date();
        return new java.sql.Date(today.getTime());

    }

    public int getCounter(String counterIndicator) {

        int counter = 0;

        System.out.println("getCounter(String " + counterIndicator);

        if ((counterIndicator.contains("-")) && (!counterIndicator.contains("image-file"))) {

            String counterIndicatorArray[] = counterIndicator.split("-");
            for (int u = 0; u < counterIndicatorArray.length; u++) {
                System.out.println("counterIndicatorArray[" + u + "]" + Arrays.toString(counterIndicatorArray));
            }
            System.out.println("getCounter(counterIndicatorArray.length " + counterIndicatorArray.length);
            System.out.println("getCounter(counterIndicatorArray[counterIndicatorArray.length - 1] " + counterIndicatorArray[counterIndicatorArray.length - 1]);
            counter = Integer.parseInt(counterIndicatorArray[counterIndicatorArray.length - 1]) - 1;

            System.out.println("Integer.parseInt(counterIndicatorArray counter  " + counter);
        }

        System.out.println("counter  " + counter);

        return counter;
    }

    private java.sql.Timestamp getcurrentTimeStamp() {

        java.util.Date today = new java.util.Date();
        return new java.sql.Timestamp(today.getTime());

    }

    public String getFdname(String fieldname) {

        String fdname;

        String fdnameArray[] = fieldname.split("-");

        fdname = fdnameArray[0];

        System.out.println("getFdname(String " + fieldname);
        for (int v = 0; v < fdnameArray.length; v++) {
            System.out.println("fdnameArray[" + v + "]" + Arrays.toString(fdnameArray));
        }

        System.out.println("fdname  " + fdname);

        return fdname;
    }

}
