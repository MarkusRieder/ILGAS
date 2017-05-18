<%-- 
    Document   : newApplications
    Created on : 07-Ma7-2017, 23:27:58
    Author     : markus
--%>
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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>

        <!--script for DataTable-->
        <script type="text/javascript">
            $(document).ready(function () {
                $('#new').DataTable({
                    columnDefs: [{
                            targets: [0],
                            orderData: [0, 1]
                        }, {
                            targets: [1],
                            orderData: [1, 0]
                        }, {
                            targets: [4],
                            orderData: [4, 0]
                        }]
                });
            });
        </script>
        <!--increase size of show entries-->
        <style>
            select.input-sm {
                height: 33px;
            }
        </style>
    </head>

    <body style="height: 100%">
        <sql:query var="applicationQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM GrantApplication
            WHERE GrantApplication.Status = 'New' 
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

                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                    <h3 align="center" style="align-content: center">Display new applications</h3>


                    <c:forEach items="${applicationQuery.rows}" var="row">
                        <c:out value="${row.name}" />
                    </c:forEach>

                    <div class="table-responsive">
                        <table id="new" class="table table-striped table-bordered" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>Application Number</th>
                                    <th>Company</th>
                                    <th>Agreement</th>
                                    <th>Contract</th>
                                    <th>Number Of Pages</th>
                                    <th>Proposed Date Of Publication</th>
                                    <th>Proposed Date Of Print Run</th>
                                    <th>Translator CV</th>
                                    <!--<th>Notes</th>-->
                                    <th>Status</th>
                                </tr>
                            </thead>

                            <tfoot>
                                <tr>
                                    <th>Application Number</th>
                                    <th>Company</th>
                                    <th>Agreement</th>
                                    <th>Contract</th>
                                    <th>Number Of Pages</th>
                                    <th>Proposed Date Of Publication</th>
                                    <th>Proposed Date Of Print Run</th>
                                    <th>Translator CV</th>
                                    <!--<th>Notes</th>-->
                                    <th>Status</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <c:forEach var="row" items="${applicationQuery.rows}">
                                    <tr>
                                        <td><c:out value = "${row.ApplicationNumber} " /></td>
                                        <td><c:out value = "${row.company}" /></td>
                                        <td><c:out value = "${row.agreement}"/></td>
                                        <td><c:out value = "${row.contract} " /></td>
                                        <td><c:out value = "${row.numberOfPages}"/></td>
                                        <fmt:formatDate value = "${row.proposedDateOfPublication}" pattern="dd/MM/yyyy" var="proposedDateOfPublication"/>
                                        <td><c:out value="${proposedDateOfPublication}" />
                                            <fmt:formatDate value = "${row.proposedDateOfPrintRun}" pattern="dd/MM/yyyy" var="proposedDateOfPrintRun"/>
                                        <td><c:out value = "${proposedDateOfPrintRun}"/></td>
                                        <td><c:out value = "${row.translatorCV}"/></td>
<!--                                        <td><c:out value = "${row.Notes}"/></td>-->
                                        <td><c:out value = "${row.Status}"/></td>
                                    </tr>   
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>


                    <c:if test="${not empty error}">Error: ${error}</c:if>
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
        </div><!-- end of Shadowholder container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>

    </body>
</html>
