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

        <title>Grant Application System</title>

        <!-- Bootstrap -->


        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link href="css/datepicker.css" rel="stylesheet"/>
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>


        <!-- Load mobile menu -->
        <script type="text/javascript" src="js/jquery.mobile-menu.js"></script>

        <!--phonenav-->
        <script type="text/javascript">
            $(function () {
                $("body").mobile_menu({
                    menu: "#phonenav"
                });
            });
        </script>



        <style>
            ​body {
                margin: 5px;
                background: #d9d1d1
            }

            /* Tab Navigation */
            .nav-tabs {
                margin: 0;
                padding: 0;
                border: 0;    
            }
            .nav-tabs > li > a {
                background: #DADADA;
                border-radius: 0;
                box-shadow: inset 0 -8px 7px -9px rgba(0,0,0,.4),-2px -2px 5px -2px rgba(0,0,0,.4);
            }
            .nav-tabs > li.active > a,
            .nav-tabs > li.active > a:hover {
                background: #F5F5F5;
                box-shadow: inset 0 0 0 0 rgba(0,0,0,.4),-2px -3px 5px -2px rgba(0,0,0,.4);
            }
            a, u {
                text-decoration: none;
            }
            /* Tab Content */
            .tab-pane {
                background: #d9d1d1;
                box-shadow: 0 0 4px rgba(0,0,0,.4);
                border-radius: 0;
                text-align: center;
                padding: 10px;
            }
        </style>

        <script type="text/javascript">
            $(function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    var tab = $(e.target.attributes.href.nodeValue);
                    $(tab).load(tab.data('url'));
                });
                $('.nav-tabs a:first').each(function () {
                    $(this.attributes.href.nodeValue).load($(this.attributes.href.nodeValue).data('url'));
                });
            });
        </script> 

    </head>

    <body style="height: 100%">

        <sql:query var="subjects" dataSource="jdbc/ILGAS">
            SELECT first_name, last_name FROM users
            WHERE users.function = "Expert Reader"
        </sql:query>

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
                

                <!--container for welcome/logout-->
                <div class="container-fluid" style="margin-bottom: 20px; width: 100%">
                    <div class="pull-right">
                        <h6> <small>Welcome ${name} - not ${name}? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                    </div>
                </div> <!--container for welcome/logout-->


                <div class="container-fluid" style="margin-bottom: 10px; width: 100%">
                    <nav class="navbar navbar-default">


                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" 
                                    class="navbar-toggle collapsed" 
                                    data-toggle="collapse" 
                                    data-target="#bs-example-navbar-collapse-1" 
                                    aria-expanded="false"
                                    >

                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <!--<a class="navbar-brand" href="#">Brand</a>-->
                        </div>

                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav nav-tabs"  role="tablist">
                                <li role="tab" class="active"><a href="#info" data-toggle="tab">Info</a></li>
                                <li role="tab" ><a href="#red" data-toggle="tab">Contact details</a></li>
                                <li role="tab" ><a href="#orange" data-toggle="tab">Contracts</a></li>
                                <li role="tab" ><a href="#yellow" data-toggle="tab">Expert Reader</a></li>
                                <li role="tab" ><a href="#green" data-toggle="tab">Translator’s Details</a></li>
                                <li role="tab" ><a href="#blue" data-toggle="tab">Original Work & Sample Translation</a></li>
                            </ul>
                        </div><!-- /.navbar-collapse -->
                        
                        <div id="tab-content" class="tab-content">
                            <!-- Info -->
                            <div class="tab-pane fade active" id="info"> 
                                <h1> Here </h1>

                            </div>
                            <!-- Contact details -->
                            <div class="tab-pane fade" id="red">
                                <h1>Rights Agreement</h1>

                            </div>
                            <!-- Contracts -->
                            <div class="tab-pane fade" id="orange">
                                <h1>Contracts</h1>

                            </div>
                            <!-- Publication Details -->
                            <div class="tab-pane fade" id="yellow">
                                <h1 style="margin-bottom: 10px">Expert Reader:</h1>                              
                                <form action="response.jsp">
                                    <strong>Expert Reader:</strong>
                                    <select name="ExpertReader">
                                        <c:forEach var="row" items="${subjects.rows}">
                                            <option value="${row.last_name}">${row.last_name}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="submit" value="submit" name="submit" />
                                </form>


                            </div>
                            <!-- Translator’s Details -->
                            <div class="tab-pane fade" id="green">  
                                <h1> Here </h1>

                            </div>

                            <!-- Original Work & Sample Translation -->
                            <div class="tab-pane fade" id="blue">
                                <h1>Original Work & Sample Translation</h1>

                            </div>
                        </div>                  
                    </nav>
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