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

        <title>Grant Application System</title>

        <!-- Bootstrap -->


        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
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

        <!--icon exclamation-->
        <style>
            .icon-exclamation {
                color: #ff0000;

                ul {
                    margin: 0;
                }
                ul.dashed {
                    list-style-type: none;
                }
                ul.dashed > li {
                    text-indent: -5px;
                }
                ul.dashed > li:before {
                    content: "-";
                    text-indent: -5px;
                }
            }
        </style>

        <!--Checkboxes with tick mark-->
        <style>
            .checkbox label:after, 
            .radio label:after {
                content: '';
                display: table;
                clear: both;
            }

            .checkbox .cr,
            .radio .cr {
                position: relative;
                display: inline-block;
                border: 1px solid #a9a9a9;
                border-radius: .25em;
                width: 1.3em;
                height: 1.3em;
                float: left;
                margin-right: .5em;
            }

            .radio .cr {
                border-radius: 50%;
            }

            .checkbox .cr .cr-icon,
            .radio .cr .cr-icon {
                position: absolute;
                font-size: .8em;
                line-height: 0;
                top: 50%;
                left: 20%;
            }

            .radio .cr .cr-icon {
                margin-left: 0.04em;
            }

            .checkbox label input[type="checkbox"],
            .radio label input[type="radio"] {
                display: none;
            }

            .checkbox label input[type="checkbox"] + .cr > .cr-icon,
            .radio label input[type="radio"] + .cr > .cr-icon {
                transform: scale(3) rotateZ(-20deg);
                opacity: 0;
                transition: all .3s ease-in;
            }

            .checkbox label input[type="checkbox"]:checked + .cr > .cr-icon,
            .radio label input[type="radio"]:checked + .cr > .cr-icon {
                transform: scale(1) rotateZ(0deg);
                opacity: 1;
            }

            .checkbox label input[type="checkbox"]:disabled + .cr,
            .radio label input[type="radio"]:disabled + .cr {
                opacity: .5;
            }

        </style>

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

            .nav-tabs.two-lines>li {
                height:62px;
            }
            .nav-tabs.two-lines>li>a, .nav-tabs>li>a>div {
                height:100%;

            </style>

            <script type="text/javascript">
                $(function () {
                    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                        var tab = $(e.target.attributes.href.value);
                        $(tab).load(tab.data('url'));
                    });

                    $('.nav-tabs a:first').each(function () {
                        $(this.attributes.href.value).load($(this.attributes.href.value).data('url'));
                    });
                });
            </script> 

            <script>
                $(function () {
                    $('div.agreement').on('change', ':file', function () {
                        var input = $(this),
                                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [numFiles, label]);
                        document.getElementById("label_agreement").value = label;
                    });
                });


                $(function () {
                    $('div.contract').on('change', ':file', function () {
                        var input = $(this),
                                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [numFiles, label]);
                        document.getElementById("label_contract").value = label;
                    });
                });




                $(function () {
                    $('div.translator_cv').on('change', ':file', function () {
                        var input = $(this),
                                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [numFiles, label]);
                        document.getElementById("label_translator").value = label;
                    });
                });

            </script>

            <style>
                .btn-file {
                    position: relative;
                    overflow: hidden;
                }
                .btn-file input[type=file] {
                    position: absolute;
                    top: 0;
                    right: 0;
                    min-width: 100%;
                    min-height: 100%;
                    font-size: 100px;
                    text-align: right;
                    filter: alpha(opacity=0);
                    opacity: 0;
                    outline: none;
                    background: white;
                    cursor: inherit;
                    display: block;
                }
            </style>

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
                                    <h6> <small>Welcome ${name} - not ${name}? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
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
                                            <option>New Application</option>
                                            <option>Pending Applications</option>
                                            <option>Closed Applications</option>
                                        </select>                                        
                                        <span class="help-block" id="error"></span> 
                                    </div>
                                </div> <!--form-group selectpicker-->
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