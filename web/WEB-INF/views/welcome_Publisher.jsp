<%-- 
    Document   : tabTesting
    Created on : 19-Mar-2017, 11:27:58
    Author     : markus
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ page session="true"%>--%>
<!DOCTYPE html>
<html style="height: 100%" >
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

         <title>Translation Grant Application System</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <!--<link rel="stylesheet" type="text/css" href="css/font-awesome.css">-->

        <script src="js/jquery-1.11.3.min.js"></script>


        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>-->
        <script src="js/moment.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
        <script src="js/bootstrap-datepicker.js"></script>
        
          <!--<script src="js/bootstrap-select.min.js"></script>-->
          
          
    </head>

    <body style="height: 100%">
        <sql:query var="companyQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM international_publishers
            WHERE international_publishers.Company_Number = ?
            <sql:param value="${publisherID}"/>
        </sql:query>
        <c:set var="companyDetails" value="${companyQuery.rows[0]}"/>
        <div id="shadowholder">
            <div class="shadowtop"> </div>
            <div id="container">
                <div id="topspacer"> </div>
                <div id="topbar">
                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" height="80" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>

                    <!--container for welcome/logout-->
                    <div class="container-fluid" style="margin-bottom: 20px; width: 100%">
                        <div class="pull-right">
                            <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                        </div>
                    </div> <!--container for welcome/logout-->

                </div> <!--  End of topbar div -->

                <div class="container-fluid"  style="background-color: #d9d1d1">

                    <h1 style="margin-bottom: 60px">Welcome</h1>

                    <form id="taskForm" 
                          class="form-horizontal" 
                          action="${pageContext.request.contextPath}/Application" 
                          method="POST"  
                          role="form" 
                          >
                        <!--selectpicker-->
                        <div class="form-group">
                            <!--<label for="location" class="col-sm-3 control-label">Select your function</label>-->
                            <div class="col-sm-10">
                                <!--<select class="selectpicker" title="Select Your Function" style="display: none;">-->
                                <select class="selectpicker" 
                                        title="Select Your Function" 
                                        name="task" 
                                        id="taskDataset" 
                                        required
                                        >      
                                    <option value="">Choose Task</option>
                                    <option>Open New Application</option>
                                    <option>List New Applications</option>
                                    <option>List Pending Applications</option>
                                    <option>List Closed Applications</option>
                                </select>                                        
                                <span class="help-block" id="error"></span> 
                            </div>
                        </div> <!--form-group selectpicker-->
                        <input type="hidden" name="firstname" value ="${firstname}">
                        <input type="hidden" name="lastname" value ="${lastname}">
                        <input type="hidden" name="userID" value ="${userID}">
                        <div style="margin-top:10px" class="form-group">
                            <!-- Button -->
                            <div class="col-sm-12 controls">
                                <input type="submit" class="btn btn-success btn-send" value="Submit">
                            </div> <!-- col-md-12 control -->
                        </div> <!-- form-group -->
                    </form>
                </div> <!-- container-fluid -->                   

                <!--footer start-->

                <div id="base">  

                    <div class="basetext">  
                        <h2>Literature Ireland</h2>
                        <a href="contact-us">Contact Details</a> &nbsp;|&nbsp; <a href="legal-note">Legal Note</a>
                    </div><!-- end of BaseText div -->

                    <div class="baselogo-1 hidden-phone"><a href="http://www.cultureireland.gov.ie" target="_blank"><span class="hidden">Culture Ireland</span></a></div>
                    <div class="baselogo-2 hidden-phone"><a href="http://www.artscouncil.ie" target="_blank"><span class="hidden">The Arts Council</span></a></div>
                    <div class="baselogo-4 hidden-phone"><a href="http://www.ahg.gov.ie/en/" target="_blank"><span class="hidden">Dept of Tourism</span></a></div>

                    <div class="mobile-baselogos visible-phone"> 
                        <a href="http://www.cultureireland.gov.ie" target="_blank"><span class="hidden">Culture Ireland</span></a>
                        <a href="http://www.artscouncil.ie" target="_blank"><span class="hidden">The Arts Council</span></a>
                        <a href="http://www.ahg.gov.ie/en/" target="_blank"><span class="hidden">Dept of Tourism</span></a>
                    </div>

                </div><!-- end of Base div -->

            </div><!-- end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadowholder container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>

    </body>
</html>
