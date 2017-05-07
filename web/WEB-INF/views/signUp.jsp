<%-- 
    Document   : signUp
    Created on : 17-Mar-2017, 14:00:34
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

        <!-- Load mobile menu -->
        <script type="text/javascript" src="js/jquery.mobile-menu.js"></script>
        
        <script type="text/javascript">
            $(function () {
                $("body").mobile_menu({
                    menu: "#phonenav"
                });
            });
        </script>

        <title>Grant Application System</title>



        <!-- Bootstrap -->

        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">   
        <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
        <link rel="stylesheet" type="text/css" href="css/form.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>


        <script src="js/blockui.js"></script>
        <script src="js/my-block-ui.js"></script>
        <script src="js/bootstrap-select.min.js"></script>
        <script src="js/register.js"></script>
        <script src="js/validator.js"></script>
        <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>



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
         background-color: #d9d1d1;
            }
        </style>
        <!--        
                <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
                <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
                <link rel="stylesheet" type="text/css" href="css/layout.css">
                <link rel="stylesheet" type="text/css" href="css/home.css" >
                <link rel="stylesheet" type="text/css" href="css/form.css">
                <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
                <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">   
        
                <link type="text/css" rel="stylesheet" href="css/responsive-tabs.css" />
                <link type="text/css" rel="stylesheet" href="css/style.css" />
        
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
                <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>-->

        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.js"></script>-->
    </head>



    <body style="height: 100%">

        <div id="shadowholder">

            <div class="shadowtop"> </div>

            <div id="container">

                <div id="topspacer"> </div>

                <div id="topbar">

                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" height="80" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>

                </div><!-- End of topbar div -->


                <h1 align="center" style="align-content: center">Grant Application System for Literature Ireland Signup</h1>

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

                <div class="container-fluid"> 

                    <!--Signup-->
                    <div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">

                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <div class="panel-title">Sign Up</div>
                                <div style="float:right; font-size: 85%; position: relative; top:-10px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
                            </div>  

                            <div class="panel-body">

                                <div class="signup-form-container">

                                    <form class="form-horizontal" role="form"  id="formRegister" 
                                          action="/register.do" 
                                          data-toggle="validator" method="POST">

                                        <div id="signupalert" style="display:none" class="alert alert-danger">
                                            <p>Error:</p>
                                            <span></span>
                                        </div>

                                        <div class="form-body">
                                            <div class="alert alert-info" id="message" style="display:none;">
                                                submitted
                                            </div>

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

                                            <div class="form-group">
                                                <!-- <label for="username" class="col-md-3 control-label">Username</label>-->
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" name="username" id="uname" placeholder="Username" onblur="loadXMLDoc()"/>                                           
                                                    <span class="help-block" id="error"></span> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <!--<label for="firstname" class="col-md-3 control-label">First Name</label>-->
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" name="firstname" placeholder="First Name">                                            
                                                    <span class="help-block" id="error"></span> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <!--<label for="lastname" class="col-md-3 control-label">Last Name</label>-->
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" name="lastname" placeholder="Last Name">                                            
                                                    <span class="help-block" id="error"></span> 
                                                </div>
                                            </div>       

                                            <div class="form-group">
                                                <!--<label for="email" class="col-md-3 control-label">Email</label>-->
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" name="email" placeholder="Email Address">                                            
                                                    <span class="help-block" id="error"></span>      
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <!--<label for="password" class="col-md-3 control-label">Password</label>-->
                                                <div class="col-md-9">
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">                                           
                                                    <span class="help-block" id="error"></span> 
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <!--<label for="cpassword" class="col-md-3 control-label">Confirm Password</label>-->
                                                <div class="col-md-9">
                                                    <input type="password" class="form-control"  id="cpassword" name="cpassword" placeholder="Confirm Password">                               
                                                    <span class="help-block" id="error"></span> 
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <!--<label for="location" class="col-sm-3 control-label">Select your function</label>-->
                                                <div class="col-sm-6">
                                                    <!--<select class="selectpicker" title="Select Your Function" style="display: none;">-->
                                                    <select class="selectpicker" title="Select Your Function" style="display: none;" name="function" id="functionDataset" required>
                                                        <option>Literature Ireland Staff</option>
                                                        <option>Publisher</option>
                                                        <option>Expert Reader</option>
                                                    </select>                                        
                                                    <span class="help-block" id="error"></span> 
                                                </div>
                                            </div> <%--form-group --%>
                                        </div><%--form-body --%>

                                        <div class="form-footer">
                                            <button type="submit" class="btn btn-info">
                                                <span class="glyphicon glyphicon-log-in"></span> Sign Me Up !
                                            </button>
                                        </div>
                                    </form>
                                    <div id="blockUiDiv">
                                        <img src="images/gears.svg" alt="spinner.gif"/>                           
                                    </div>
                                    <div id="blockUiBackdrop"></div>
                                </div>
                                <script>
                                    $(function () {
                                        $('#formRegister').validator().on('submit', function (e) {
                                            if (e.isDefaultPrevented()) {
                                                // handle the invalid form...
                                            } else {
                                                blockUi();
                                                // everything looks good!
                                                $.post("RegisterServlet", $("#formRegister").serialize(), function (data) {
                                                    var jdata = JSON.parse(data);
                                                    if (jdata.code === -1) {
                                                        $("#errorField .message").text(jdata.message);
                                                        $("#errorField").show();
                                                        $("#successField").hide();
                                                    } else {
                                                        $("#successField .message").text(jdata.message);
                                                        $("#errorField").hide();
                                                        $("#successField").show();
                                                        $("#formRegister").hide();
                                                    }
                                                }).always(function () {
                                                    unBlockUi();
                                                });
                                            }
                                            return false;
                                        });

                                    });

                                </script>
                            </div>
                            <div style="border-top: 1px solid #999; padding-top:20px"  class="form-group"></div>
                        </div>
                    </div>  
                </div> <!-- /container-fluid -->



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

        <script type="text/javascript">
            function loadXMLDoc()
            {
                var xmlhttp;
                var uname = document.getElementById("uname").value;
                var urls = "checkusername.jsp?uname=" + uname;

                if (window.XMLHttpRequest)
                {
                    xmlhttp = new XMLHttpRequest();
                } else
                {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState === 4)
                    {
                        document.getElementById("error").innerHTML = xmlhttp.responseText;
                    }
                };
                xmlhttp.open("GET", urls, true);
                xmlhttp.send();
            }
            ;
        </script>

        <script type="text/javascript">
            window.onload = function () {
                $('.selectpicker').selectpicker();
                $('.functionDataset').each(function () {
                    $(this).rules('add', {
                        required: true,
                        messages: {
                            required: "Choose a function"
                        }
                    });
                    // scrollYou
                    $('.scrollMe .dropdown-menu').scrollyou();
                    prettyPrint();
                });
            };
        </script>
    </body>
</html>
