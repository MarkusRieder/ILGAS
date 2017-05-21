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
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script src="js/dataTables.responsive.min.js"></script>
        <script src="js/dataTables.bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
        <script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"></script>



        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {
                $('#library').DataTable({
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



        <!--increase size of "Show entries" -->
        <style>
            select.input-sm {
                height: 33px;
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


        <!--script to enable click on document link--> 
        <script type="text/javascript">
            $(document).ready(function () {
                $('#library tbody').on('click', 'td', function () {
                    var table = $('#library').DataTable();
                    alert(table.cell(this).data());
                });
                $('#expReader tbody').on('click', 'td', function () {
                    var table = $('#expReader').DataTable();
                    alert(table.cell(this).data());
                });
            });
        </script>

        <!--http://stackoverflow.com/questions/18999501/bootstrap-3-keep-selected-tab-on-page-refresh -->
        <script type="text/javascript">
            $(document).ready(function () {
                if (location.hash) {
                    $("a[href='" + location.hash + "']").tab("show");
                }
                $(document.body).on("click", "a[data-toggle]", function (event) {
                    location.hash = this.getAttribute("href");
                });
            });
            $(window).on("popstate", function () {
                var anchor = location.hash || $("a[data-toggle='tab']").first().attr("href");
                $("a[href='" + anchor + "']").tab("show");
            });
        </script>





    </head>

    <body style="height: 100%">

        <sql:query var="libraryQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM Books;          
        </sql:query>
        <c:set var="libraryDetails" value="${libraryQuery.rows[0]}"/>

        <sql:query var="expertQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM users 
            WHERE function = 'Expert Reader';
        </sql:query>
        <c:set var="expertReaderDetails" value="${expertQuery.rows[0]}"/>



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

                <div class="container" style="margin-bottom: 60px; width: 100%">

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="tab" class="active"><a href="#info" data-toggle="tab">Info</a></li>
                        <li role="tab" ><a href="#red" data-toggle="tab">Contact details</a></li>
                        <li role="tab" ><a href="#orange" data-toggle="tab">Contracts</a></li>
                        <li role="tab" ><a href="#yellow" data-toggle="tab">Expert Reader</a></li>
                        <li role="tab" ><a href="#Library" data-toggle="tab">Library</a></li>
                        <li role="tab" ><a href="#blue" data-toggle="tab">Original Work & Sample Translation</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content" >
                        <div class="tab-pane fade active in" id="info">
                            <h2>Home Content Goes Here</h2>

                        </div>
                        <div class="tab-pane fade" id="red">
                            <h2>Profile Content Goes Here</h2>

                        </div>
                        <div class="tab-pane fade" id="orange">
                            <h2>Messages Content Goes Here</h2>

                        </div>
                        <div class="tab-pane fade" id="yellow">
                            <h1 style="margin-bottom: 10px">Expert Reader:</h1>                                     
                            <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                                <div class="table-responsive">
                                    <table id="expReader" class="table table-striped table-bordered" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th class="all">First Name</th>
                                                <th class="all">Last Name</th>
                                                <!--<th class="all">fileDestination</th>-->
                                                <th class="all">Email</th>
                                            </tr>
                                        </thead>

                                        <tfoot>
                                            <tr>
                                                <th class="all">First Name</th>
                                                <th class="all">Last Name</th>
                                                <!--<th class="all">fileDestination</th>-->
                                                <th class="all">Email</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="row" items="${expertQuery.rows}">
                                                <tr>
                                                    <td><c:out value = "${row.first_name} " /></td>
                                                    <td><c:out value = "${row.last_name}" /></td>
                                                    <%--<fmt:formatDate value = "${row.submissionDate}" pattern="dd/MM/yyyy" var="submissionDate"/>--%>
                                                    <!--<td><c:out value = "${submissionDate}"/></td>-->                                                               
                                                    <td><c:out value = "${row.email}" /></td>
                                                </tr>   
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>             
                                <c:if test="${not empty error}">Error: ${error}</c:if>
                                </div> <!-- /container-fluid -->
                                <input type="submit" value="submit" name="submit" />          
                            </div>
                            <div class="tab-pane" id="Library">
                                <h2>Library</h2>
                                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                                    <h3 align="center" style="align-content: center">Display Library</h3>

                                    <div class="table-responsive">
                                        <table id="library" class="table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th class="all">Reference<br/>  Nr</th>
                                                    <th class="all">Author</th>
                                                    <th class="all">Title</th>
                                                    <th class="all">Publisher</th>
                                                    <th class="all">Publisher<br/> Year</th>
                                                    <th class="all">Genre</th>
                                                    <th class="all">Translation<br/> Title</th>
                                                    <th class="all">Translation<br/> Publisher Year</th>
                                                    <th class="all">Translator</th>
                                                    <th class="all">ISBN</th>
                                                </tr>
                                            </thead>

                                            <tfoot>
                                                <tr>
                                                    <th class="all">Reference<br/>  Nr</th>
                                                    <th class="all">Author</th>
                                                    <th class="all">Title</th>
                                                    <th class="all">Publisher</th>
                                                    <th class="all">Publisher<br/> Year</th>
                                                    <th class="all">Genre</th>
                                                    <th class="all">Translation<br/> Title</th>
                                                    <th class="all">Translation<br/> Publisher Year</th>
                                                    <th class="all">Translator</th>
                                                    <th class="all">ISBN</th>
                                                </tr>
                                            </tfoot>
                                            <tbody>
                                            <c:forEach var="row" items="${libraryQuery.rows}">
                                                <tr>
                                                    <td><c:out value = "${row.Referencenumber} " /></td>
                                                    <td><c:out value = "${row.Author}" /></td>
                                                    <td><c:out value = "${row.Title}" /></td>
                                                    <td><c:out value = "${row.Publisher}" /></td>
                                                    <td><c:out value = "${row.Publisheryear}"/></td>
                                                    <td><c:out value = "${row.Genre}" /></td>
                                                    <td><c:out value = "${row.TranslationTitle}" /></td>                                                                                                  
                                                    <td><c:out value = "${row.translationPublisherYear}" /></td>
                                                    <td><c:out value = "${row.Translator}" /></td>
                                                    <td><c:out value = "${row.ISBN}" /></td>
                                                </tr>   
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>             
                                <c:if test="${not empty error}">Error: ${error}</c:if>
                            </div> <!-- /container-fluid -->
                        </div>
                        <div class="tab-pane fade" id="blue">
                            <h2>Settings Content Goes Here</h2>

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

            </div><!-- end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadow container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>

    </body>
</html>