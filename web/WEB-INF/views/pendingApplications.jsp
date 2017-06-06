<%-- 
    Document   : pendingApplications
    Created on : 07-Ma7-2017, 23:27:58
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


        <!--script for DataTable-->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.DataTable').DataTable({iDisplayLength: 50});
                $('#pending').DataTable({

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

        <!--script to enable click on document link--> 
        <script type="text/javascript">
            $(document).ready(function () {
                $('#pending tbody').on('click', 'td', function () {
                    var table = $('#newA').DataTable();
                });
            });
        </script>
    </head>

    <body style="height: 100%">
        <sql:query var="applicationQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM GrantApplication
            WHERE GrantApplication.Status = 'pending' 
            AND publisherID = ?;
            <sql:param value="${publisherID}"/>
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
                    <!--container for welcome/logout-->
                    <div class="container-fluid" style="margin-bottom: 20px; width: 100%">
                        <div class="pull-right">
                            <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                        </div>
                    </div> <!--container for welcome/logout-->
                </div> <!--  End of topbar div -->

                <h1 align="center" style="align-content: center">Grant Application System for Literature Ireland</h1>

                <div class="container-fluid" style="margin-bottom: 20px"></div>

                <h1 style="background-color: red">Make sure they can only see their own applications</h1>
                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                    <h3 align="center" style="align-content: center">Display pending applications</h3>


                    <c:forEach items="${applicationQuery.rows}" var="row">
                        <c:out value="${row.name}" />
                    </c:forEach>

                    <div class="table-responsive">
                        <table id="pending" class="table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th class="all">Application<br/>  Nr</th>
                                    <th class="all">Company</th>
                                    <th class="all">Agreement</th>
                                    <th class="all">Contract</th>
                                    <th class="all">Number<br/> Pages</th>
                                    <th class="all">Proposed<br/> Date of <br/> Publication</th>
                                    <th class="all">Proposed<br/> Date of <br/> Print Run</th>
                                    <th class="all">Translator<br/> CV</th>
                                    <th>Notes</th>
                                    <th class="all">Status</th>
                                </tr>
                            </thead>

                            <tfoot>
                                <tr>
                                    <th class="all">Application<br/>  Nr</th>
                                    <th class="all">Company</th>
                                    <th class="all">Agreement</th>
                                    <th class="all">Contract</th>
                                    <th class="all">Number<br/> Pages</th>
                                    <th class="all">Proposed<br/> Date of <br/> Publication</th>
                                    <th class="all">Proposed<br/> Date of <br/> Print Run</th>
                                    <th class="all">Translator<br/> CV</th>
                                    <th>Notes</th>
                                    <th class="all">Status</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <c:forEach var="row" items="${applicationQuery.rows}">
                                    <tr>
                                        <td><c:out value = "${row.ApplicationNumber} " /></td>
                                        <td><c:out value = "${row.company}" /></td>
                                        <td><a href="http://localhost${row.agreement}" target="_blank" title="Open Document">${row.agreementDocName}</a></td>                                    
                                        <td><a href="http://localhost${row.contract}" target="_blank" title="Open Document">${row.contractDocName}</a></td>                                        
                                        <td><c:out value = "${row.numberOfPages}"/></td>
                                        <fmt:formatDate value = "${row.proposedDateOfPublication}" pattern="dd/MM/yyyy" var="proposedDateOfPublication"/>
                                        <td><c:out value="${proposedDateOfPublication}" />
                                            <fmt:formatDate value = "${row.proposedDateOfPrintRun}" pattern="dd/MM/yyyy" var="proposedDateOfPrintRun"/>
                                        <td><c:out value = "${proposedDateOfPrintRun}"/></td>
                                        <td><a href="http://localhost${row.translatorCV}" target="_blank" title="Open Document">${row.translatorCVDocName}</a></td>                                        
                                        <td><c:out value = "${row.Notes}"/></td>
                                        <td><c:out value = "${row.Status}"/></td>
                                    </tr>   
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>             
                    <c:if test="${not empty error}">Error: ${error}</c:if>
                    </div> <!-- /container-fluid -->
                    <form class="form-horizontal" 
                          role="form"  
                          autocomplete="on"  
                          action="${pageContext.request.contextPath}/Application" 
                    method="POST" 
                    name="regF"
                    >
                    <div class="container col-sm-12" style="margin-bottom: 40px">
                        <button type="submit" class = "btn btn-default btn-sm" name="New Application">
                            New Application
                        </button>

                        <button type = "submit" class = "btn btn-default btn-sm"  name="List New Applications">
                            List New Applications
                        </button>

                        <button type = "submit" class = "btn btn-default btn-sm active" name="List Pending Applications">
                            List Pending Applications
                        </button>

                        <button type = "submit" class = "btn btn-default btn-sm"  name="List Closed Applications">
                            List Closed Applications
                        </button>
                    </div>

                </form>
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