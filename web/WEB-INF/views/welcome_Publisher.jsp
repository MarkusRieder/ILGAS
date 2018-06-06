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


        <script src="js/jquery-1.11.3.min.js"></script>
        <script src="js/moment.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>

        <style>

            .container-bg { 
                background: url(images/background/IMG_6318.JPG) no-repeat center center fixed; 
                -webkit-background-size: cover;
                -moz-background-size:  cover;
                -o-background-size: cover;
                background-size: 100% ;
                padding-right: 15px;
                padding-left: 15px;
                margin-right: auto;
                margin-left: auto;
                max-width: 1000px;
                overflow:hidden;

            }

            .tst {
                background-image: url('images/background/IMG_6318.JPG');
                background-size: contain;
                background-repeat: no-repeat;
                width: 100%;
                height: 0;
                padding-top: 51.4056%; /* (img-height / img-width * container-width) */
                /* (853 / 1280 * 100) */
            }
        </style>

    </head>
    <body>
        <div id="shadowholder">
            <div class="shadowtop"> </div>
            <div id="container">
                <div id="topspacer"> </div>
                <div id="topbar">
                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" height="70" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>

                    <!--container for welcome/logout-->
                    <div class="container-fluid" >
                        <div class="pull-right">
                            <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                        </div>
                    </div> <!--container for welcome/logout-->
                </div> <!--  End of topbar div -->

                <div class="container-fluid tst">

                    <div class="row">


                        <div class="container-fluid pull-left" style="margin-top: 10px">

                            <form id="taskForm" 
                                  class="form-horizontal" 

                                  action="${pageContext.request.contextPath}/Application" 
                                  method="POST"  
                                  role="form" 
                                  >
                                <!--selectpicker-->
                                <div class="form-group">

                                    <div class="col-sm-10" >

                                        <select class="selectpicker" 
                                                title="Select Your Task" 
                                                name="task" 
                                                id="taskDataset" 
                                                required
                                                >      
                                            <option value="">Choose Task</option>
                                            <option>Start New Application</option>
                                     <!--        <option>List New Applications</option> -->
                                            <option>List Open Applications</option>
                                            <option>List Pending Applications</option>
                                            <option>List Closed Applications</option>
                                        </select>                                        
                                        <span class="help-block" id="error"></span> 
                                    </div>
                                </div> <!--form-group selectpicker-->
                                <input type="hidden" name="firstname" value ="${firstname}">
                                <input type="hidden" name="lastname" value ="${lastname}">
                                <input type="hidden" name="userID" value ="${userID}">
                                <input type="hidden" name="publisherID" value ="${publisherID}">
                                <div class="form-group">
                                    <!-- Button -->
                                    <div class="col-sm-12  pull-left">
                                        <input type="submit" class="btn btn-success btn-send" style="margin-bottom: 10px" value="Submit">
                                    </div> <!-- col-md-12 control -->
                                </div> <!-- form-group -->
                            </form>  
                        </div>
                    </div>
                </div>    

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

            </div> <!--  end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadowholder container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>

    </body>
</html>
