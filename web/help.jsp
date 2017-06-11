<%-- 
    Document   : help
    Created on : 16-Mar-2017, 21:14:55
    Author     : markus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%" >
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!-- Load mobile menu -->
        <!--        <script type="text/javascript" src="js/jquery.mobile-menu.js"></script>
                        <script type="text/javascript">
                            $(function () {
                                $("body").mobile_menu({
                                    menu: "#phonenav"
                                });
                            });
                        </script>-->

       <title>Translation Grant Application System</title>



        <!-- Bootstrap -->
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
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.js"></script>-->


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

                <h1 align="center">Publisher</h1>


<!--                <div class="container-fluid">  

                    <div class="pull-right">
                        <h6> <small>Welcome Sparky The Cat - not Sparky The Cat? <a href="/ILGAS/Logout">Click here to log out </a></small></h6>
                    </div>
                    <br/>
                    <br/>-->

                    <div class="container">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_a" data-toggle="tab">Tab A</a></li>
                            <li><a href="#tab_b" data-toggle="tab">Tab B</a></li>
                            <li><a href="#tab_c" data-toggle="tab">Tab C</a></li>
                            <li><a href="#tab_d" data-toggle="tab">Tab D</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_a">
                                <h4>Pane A</h4>
                                <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames
                                    ac turpis egestas.</p>
                            </div>
                            <div class="tab-pane" id="tab_b">
                                <h4>Pane B</h4>
                                <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames
                                    ac turpis egestas.</p>
                            </div>
                            <div class="tab-pane" id="tab_c">
                                <h4>Pane C</h4>
                                <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames
                                    ac turpis egestas.</p>
                            </div>
                            <div class="tab-pane" id="tab_d">
                                <h4>Pane D</h4>
                                <p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames
                                    ac turpis egestas.</p>
                            </div>
                        </div><!-- tab content -->
                    </div><!-- end of container -->


                    <script type="text/javascript" src="js/bootstrap.js"></script><!--footer start-->


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


            <script src="js/bootstrap-select.min.js"></script>
            <script src="js/register.js"></script>
            <script src="js/my-block-ui.js"></script>
            <script src="js/blockui.js"></script>
            <script src="js/bootstrap-show-password.js"></script>
            <script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>

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
