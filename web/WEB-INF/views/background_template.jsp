<%-- 
    Document   : background_template
    Created on : 25-May-2017, 08:52:17
    Author     : markus
--%>

<%@ page import="java.io.*,java.io.*,org.apache.poi.hwpf.HWPFDocument,org.apache.poi.hwpf.extractor.WordExtractor" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
        <link rel="stylesheet" type="text/css" href="css/responsive.dataTables.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script src="js/dataTables.responsive.min.js"></script>
        <script src="js/dataTables.bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"></script>


        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.DataTable').DataTable({iDisplayLength: 50});
                $('#newA').DataTable({
                    responsive: {
                        details: {
                            display: $.fn.dataTable.Responsive.display.modal({
                                header: function (row) {
                                    var data = row.data();
                                    return 'Details for Application Number: ' + data[0] + ' - Publisher: ' + data[1];
                                }
                            }),
                            renderer: function (api, rowIdx, columns) {
                                var data = $.map(columns, function (col, i) {
                                    return '<tr>' +
                                            '<td>' + col.title + ':' + '</td> ' +
                                            '<td>' + col.data + '</td>' +
                                            '</tr>';
                                }).join('');

                                return $('<table/>').append(data);
                            }
                        }
                    }
                });
            });
        </script>


        <!--increase size of show entries-->
        <style>
            select.input-sm {
                height: 33px;
            }
        </style>

        <!--style for mini navebar-->
        <style>
            .navbar-xs { min-height:22px; border-radius:0} 
            .navbar-xs .navbar-brand{ padding: 2px 8px;font-size: 14px;line-height: 14px; } 
            .navbar-xs .navbar-nav > li > a { border-right:1px solid #ddd; padding-top: 2px; padding-bottom: 2px; line-height: 16px }
        </style>

        <!--script to enable click on document link--> 
        <script type="text/javascript">
            $(document).ready(function () {
                $('#newA tbody').on('click', 'td', function () {
                    var table = $('#newA').DataTable();
                    //alert(table.cell(this).data());
                });
            });
        </script>
    </head>

    <body style="height: 100%">

        <sql:query var="applicationQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM GrantApplication
            WHERE GrantApplication.Status = 'new' 
        </sql:query>
        <c:set var="applicationDetails" value="${applicationQuery.rows[0]}"/>

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
                        <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                    </div>
                </div> <!--container for welcome/logout-->

                <h1 align="center" style="align-content: center">Grant Application System for Literature Ireland</h1>

                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                    <h3 align="center" style="align-content: center">Display new applications</h3>
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
            </div>
            <!-- end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadow container div -->
        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>
    </body>
</html>
