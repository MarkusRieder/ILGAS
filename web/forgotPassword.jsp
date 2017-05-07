<%-- 
    Document   : forgotPassword
    Created on : 06-Mar-2017, 23:40:43
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
        <!--<script type="text/javascript" src="js/jquery.mobile-menu.js"></script>-->
        <!--    <script type="text/javascript">
                $(function () {
                    $("body").mobile_menu({
                        menu: "#phonenav"
                    });
                });
            </script>-->

        <title>Grant Application System</title>


        <!-- Bootstrap -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/home.css" >
        <link rel="stylesheet" type="text/css" href="css/form.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css"> 
        <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">     

        <!--<link rel="stylesheet" type="text/css" href="css/mobile.css">-->

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
                background-color:#f4f4f4;
            }
        </style>

        <!-- Load jQuery and the validate plugin -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js" async=""></script>
        <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" async=""></script>
        <script src="js/bootstrap.js" type="text/javascript" async=""></script>
        <script src="js/register.js"  type="text/javascript" async=""></script>
        <script src="js/bootstrap-select.min.js" type="text/javascript" async=""></script>
        <script src="js/validator.js" type="text/javascript" async=""></script>
        <script src="js/my-block-ui.js" type="text/javascript" async=""></script>
        
        <script src="js/bootstrap.min.js"></script>
        <script src="js/validator.min.js"></script>

        <!--        <script>
                    var select = document.getElementById('functionDataset');
                    select.onchange = function () {
                        input.value = select.value;
                    };
                </script>-->


        <!--        <script type="text/javascript">
                    function loadXMLDoc()
                    {
                        var xmlhttp;
                        var uname = document.getElementById("uname").value;
                        var urls = "checkusername.jsp?ver=" + uname;
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
                </script>-->


        <!--        <script type="text/javascript">
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
                </script>-->

        <script>
            $(function () {
                $('#formForgotPassword').validator().on('submit', function (e) {
                    if (e.isDefaultPrevented()) {
                        // handle the invalid form...
                    } else {
                        blockUi();
                        // everything looks good!
                        $.post("ForgotPassword", $("#formForgotPassword").serialize(), function (data) {
                            var jdata = JSON.parse(data);
                            if (jdata.code === -1) {
                                $("#errorField .message").text(jdata.message);
                                $("#errorField").show();
                                $("#successField").hide();
                            } else {
                                $("#successField .message").text(jdata.message);
                                $("#errorField").hide();
                                $("#successField").show();
                                $("#formForgotPassword").hide();
                            }
                        }).always(function () {
                            unBlockUi();
                        });
                    }
                    return false;
                });
            });
        </script>
    </head>


    <body style="height: 100%">

        <div id="shadowholder">

            <div class="shadowtop"> </div>

            <div id="container">
                <div id="topspacer"> </div>

                <div id="topbar">
                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>
                </div><!-- End of topbar div -->

                <div class="container-fluid"> 
                    <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
                        <!--<div style="max-width:500px;padding:10px 20px;margin:auto;margin-top:calc(50vh - 220px);">-->
                        <h3 style="text-align:center">Forgot Password</h3>
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
                        <form class="form-horizontal" id="formForgotPassword" data-toggle="validator" method="Post" role="form">
                            <div class="form-group">
                                <label for="inputEmail" class="control-label">Email</label>
                                <input name="inputEmail" type="email" class="form-control" id="inputEmail" placeholder="Enter Email" data-error="Enter valid Email" required>
                                <div class="help-block with-errors"></div>
                            </div>
                            <div class="form-group">
                                <button style="width:100%" type="submit" class="btn btn-default btn-primary">Send Verification Link</button>
                                <div style="margin-bottom: 100px;"> </div>
                            </div>
                        </form>
                        <div id="blockUiDiv">
                            <img src="images/gears.svg"  alt="spinner"/>
                            
                        </div>
                        <div id="blockUiBackdrop">
                        </div>
                    </div>

                </div> <!-- /container-fluid -->


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


        <div id="credit"> <a><img src="images/paw.gif" alt="The Paw" height="30" /></a>
            &copy; 2017 mgr 12 Software
        </div>
    </body>
</html>