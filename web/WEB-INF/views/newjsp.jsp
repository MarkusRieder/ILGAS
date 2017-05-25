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

        <!--                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        
                <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
                <link rel="stylesheet" type="text/css" href="css/layout.css">
                <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
                <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
                <link rel="stylesheet" type="text/css" href="css/datepicker.css">
                <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.css">
                <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
                <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
                <link rel="stylesheet" type="text/css" href="css/responsive.dataTables.min.css">
                <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">-->





        <!--<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>-->
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
        <!--        <script src="js/bootstrap-datepicker.js"></script>
                <script src="js/jquery.dataTables.js"></script>
                <script src="js/dataTables.bootstrap.js"></script>
                <script src="js/dataTables.responsive.min.js"></script>
                <script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"></script>
                <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js">
                </script>
        
                <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
                <script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
                <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
                <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
                <script type="text/javascript" language="javascript" src="//cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js "></script>-->


        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js">
        </script>


        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>


        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">



        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js">
        </script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js">
        </script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js">
        </script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js">
        </script>

        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js "></script>



        <script type="text/javascript">
            $(document).ready(function () {
                var table = $('#library').DataTable({

                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            exportOptions: {
                                columns: ':contains("Office")'
                            }
                        },
                        'excelHtml5',
                        'csvHtml5',
                        'pdfHtml5'

                    ]
                });

                $('table tbody tr  td').on('click', function () {
                    $("#myModal").modal("show");
                    $("#txtfname0").val($(this).closest('tr').children()[1].textContent); // ID
                    $("#txtlname1").val($(this).closest('tr').children()[2].textContent); // uname
                    $("#txtfname2").val($(this).closest('tr').children()[3].textContent); // First
                    $("#txtlname3").val($(this).closest('tr').children()[4].textContent); // Last
                    $("#txtlname4").val($(this).closest('tr').children()[5].textContent); // Function
                    $("#txtlname5").val($(this).closest('tr').children()[6].textContent); // Role

                });
            });


        </script>


        <!--increase size of show entries-->
        <style>
            select.input-sm {
                height: 33px;
            }
        </style>

        <style>
            td.details-control {
                background: url('images/details_open.png') no-repeat center center;
                cursor: pointer;
            }
            tr.shown td.details-control {
                background: url('images/details_close.png') no-repeat center center;
            }

        </style>

        <!--script to enable click on document link--> 
        <script type="text/javascript">
            $(document).ready(function () {
//                $('#example tbody').on('click', 'td', function () {
                var table = $('#library').DataTable();
//                    console.log(table.cell(this).data());
                $('#library').DataTable();
                $('#library tbody').on('click', 'tr', function () {
                    console.log(table.row(this).data());
                });
            });
//            });
        </script>
    </head>

    <body style="height: 100%">

        <sql:query var="libraryQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM users;
        </sql:query>
        <c:set var="libraryDetails" value="${libraryQuery.rows[0]}"/>

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

                    <div class="table-responsive">
                        <table id="library" class="table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th class="all">#</th>
                                    <th class="all">uname</th>
                                    <th class="all">first_name</th>
                                    <th class="all">last_name</th>
                                    <th class="all">function</th>
                                    <th class="all">role</th>
                                </tr>
                            </thead>

                            <tfoot>
                                <tr>
                                    <th></th>
                                    <th class="all">#</th>
                                    <th class="all">uname</th>
                                    <th class="all">first_name</th>
                                    <th class="all">last_name</th>
                                    <th class="all">function</th>
                                    <th class="all">role</th>
                                </tr>
                            </tfoot>

                            <tbody>
                                <c:forEach var="row" items="${libraryQuery.rows}">
                                    <tr>
                                        <td class="details-control"></td>
                                        <td><c:out value = "${row.userID} " /></td>
                                        <td><c:out value = "${row.uname} " /></td>
                                        <td><c:out value = "${row.first_name}" /></td>
                                        <td><c:out value = "${row.last_name}" /></td>
                                        <td><c:out value = "${row.function}" /></td>
                                        <td><c:out value = "${row.role}" /></td>
                                    </tr>   
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>             
                    <c:if test="${not empty error}">Error: ${error}</c:if>
                </div> <!-- /container-fluid -->

                <div class="modal fade" id="myModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">EDIT</h4>
                            </div>
                            <div class="modal-body">


                                <label> ID: </label>
                                <p><input type="text" class="input-sm" id="txtfname0"/></p>
                                <label> Uname: </label>
                                <p><input type="text" class="input-sm" id="txtlname1"/></p>
                                <label> First Name: </label>
                                <p><input type="text" class="input-sm" id="txtfname2"/></p>
                                <label> Last Name: </label>
                                <p><input type="text" class="input-sm" id="txtlname3"/></p>
                                <label> Function: </label>
                                <p><input type="text" class="input-sm" id="txtlname4"/></p>
                                <label> Role: </label>
                                <p><input type="text" class="input-sm" id="txtlname5"/></p>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary">Save changes</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
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
