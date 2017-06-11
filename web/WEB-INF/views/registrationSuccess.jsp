<%-- 
    Document   : success
    Created on : 01-Apr-2017, 12:56:23
    Author     : markus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true"%>
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
        <link rel="stylesheet" type="text/css" href="css/form.css">

        <script src="js/jquery-1.11.3.min.js"></script>

        <script src="js/bootstrap.js"></script>
        <script src="js/blockui.js"></script>
        <script src="js/my-block-ui.js"></script>
        <script src="js/bootstrap-select.min.js"></script>
        <script src="js/register.js"></script>
        <script src="js/bootstrap-validator.js"></script>
        <script src="js/jquery.validate.js"></script>
        <script src="js/bootstrap-show-password.js"></script>


        <style>
            .form-horizontal .control-label {
                margin-bottom: 5px;
            }
            .form-horizontal .form-group {
                margin-bottom: 5px;
                margin-left:0px;
                margin-right:0px;
            }
            body {
                background: #d9d1d1;
            }
        </style>  

    </head>

    <body style="height: 100%">
        <div class="alert alert-danger" role="alert" id="errorField" style="display:none">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <span class="sr-only">Error:</span>
            <span class="message"></span>
        </div>
        <div class="alert alert-success" role="alert" id="successField" style="display:none">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <span class="sr-only">Success:</span>
            <span class="message"></span>
        </div>
        <div id="shadowholder">

            <div class="shadowtop"> </div>

            <div id="container">

                <div id="topspacer"> </div>

                <div id="topbar">

                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" height="80" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>
                </div> <!--  End of topbar div -->

                <div class="container-fluid">

                    <h1 align="center" style="align-content: center; margin-top: 50px; margin-bottom: 70px">Welcome ${firstname}  ${lastname} - your Registration was successful.</h1><br/>
                    <h2 align="center" style="align-content: center; margin-top: 50px; margin-bottom: 100px">Please check your email!</h2>

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

            </div><!-- end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadow container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>

    </body>
</html>
