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

        <title>Translation Grant Application System</title>

        <!-- Bootstrap -->

        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>



        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">

        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">


        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>        
        <script src="js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>       
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>       
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
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

                $('#library tbody').on('click', 'tr td.details-control', function () {
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

        <script type="text/javascript">

            $(document).ready(function () {

                var table = $("#jqueryDataTable").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            text: '<i class="fa fa-files-o"></i>',
                            titleAttr: 'Copy',
                            exportOptions: {
                                columns: ':contains("Office")'
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o"></i>',
                            titleAttr: 'Excel'
                        },
                        {
                            extend: 'csvHtml5',
                            text: '<i class="fa fa-file-text-o"></i>',
                            titleAttr: 'CSV'
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o"></i>',
                            titleAttr: 'PDF'
                        }

                    ],
                    "bProcessing": false,
                    "bServerSide": false,
                    "sAjaxSource": "./PopulateTableDevice",
                    "columns": [{
                            "targets": -1,
                            "class": "details-control",
                            "orderable": false,
                            "data": null,
                            "defaultContent": ""
                        },

                        {"data": "bookID"},
                        {"data": "referenceNumber"},
                        {"data": "Author"},
                        {"data": "Title"},
                        {"data": "publisherYear"},
                        {"data": "Genre"},
                        {"data": "translationTitle"},
                        {"data": "translationPublisherYear"},
                        {"data": "Translator"},
                        {"data": "Language"},
                        {"data": "physicalDescription"},
                        {"data": "Duplicates"},
                        {"data": "Copies"},
                        {"data": "Notes"},
                        {"data": "ISBN"},
                        {"data": "ISSN"}
                    ],
                    columnDefs: [
                        {
                            targets: -1,
                            visible: false
                        },
                        {
                            "targets": [-1, 0],
                            "orderable": false
                        },
                        {className: "dt-left", "targets": [1, 2, 3, 4, 5, 6, 7, 8]}
                    ]

                });
                $('#jqueryDataTable tbody').on('click', 'tr td.details-control', function () {

                    $("#jqdtModal").modal("show");
                    $("#referenceNumber").val($(this).closest('tr').children()[2].textContent); // ID
                    $("#Author").val($(this).closest('tr').children()[3].textContent); // uname
                    $("#Title").val($(this).closest('tr').children()[4].textContent); // First
                    $("#Genre").val($(this).closest('tr').children()[6].textContent); // Last
                    $("#Language").val($(this).closest('tr').children()[10].textContent); // Function
                    $("#ISBN").val($(this).closest('tr').children()[15].textContent); // Role
                    console.log(table.row(this).data());
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
        <!--        <script type="text/javascript">
                    $(document).ready(function () {
                        $('#library').DataTable();
                        $('table tbody').on('click', 'tr', function () {
                            console.log(table.row(this).data());
                        });
                        $('#jqueryDataTable').DataTable();
                        $('table tbody').on('click', 'tr', function () {
                            console.log(table.row(this).data());
                        });
                    });
        
                </script>-->
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

                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
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

                    <div class="container-fluid">

                        <div class="table-responsive">
                            <table id="jqueryDataTable" class="display jqueryDataTable table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th class="details-control"></th>
                                        <th class="all">bookID</th>
                                        <th class="all">referenceNumber</th>
                                        <th class="all">Author</th>
                                        <th class="all">Title</th>
                                        <th class="all">publisherYear</th>
                                        <th class="all">Genre</th>
                                        <th class="all">translationTitle</th>                                       
                                        <th class="all">translationPublisherYear</th>
                                        <th class="all">Translator</th>
                                        <th class="all">Language</th>
                                        <th class="all">physicalDescription</th>
                                        <th class="all">Duplicates</th>
                                        <th class="all">Copies</th>
                                        <th class="all">Notes</th>
                                        <th class="all">ISBN</th>
                                        <th class="all">ISSN</th>

                                    </tr>
                                </thead>

                                <tfoot>
                                    <tr>
                                        <th class="details-control"></th>
                                        <th class="all">bookID</th>
                                        <th class="all">referenceNumber</th>
                                        <th class="all">Author</th>
                                        <th class="all">Title</th>
                                        <th class="all">publisherYear</th>
                                        <th class="all">Genre</th>
                                        <th class="all">translationTitle</th>                                       
                                        <th class="all">translationPublisherYear</th>
                                        <th class="all">Translator</th>
                                        <th class="all">Language</th>
                                        <th class="all">physicalDescription</th>
                                        <th class="all">Duplicates</th>
                                        <th class="all">Copies</th>
                                        <th class="all">Notes</th>
                                        <th class="all">ISBN</th>
                                        <th class="all">ISSN</th>
                                    </tr>
                                </tfoot>

                                <tbody>

                                </tbody>
                            </table>
                        </div>             
                    <c:if test="${not empty error}">Error: ${error}</c:if>

                    <!--<div class="modal-bootstrap fade bs-example-modal-sm" id="jqdtModal" tabindex="-1" role="dialog" aria-labelledby="smallModalLabel" aria-hidden="true">-->

                    <!--<div id="jqdtModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="jqdtModalModalLabel" aria-hidden="true">-->
                    <div class="modal fade" id="jqdtModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                </div>
                                <div class="modal-body">


                                    <label> referenceNumber </label>
                                    <p><input type="text" class="input-sm" id="referenceNumber"/></p>
                                    <label> Author </label>
                                    <p><input type="text" class="input-sm" id="Author"/></p>
                                    <label> Title: </label>
                                    <p><input type="text" class="input-sm" id="Title"/></p>
                                    <label> Genre: </label>
                                    <p><input type="text" class="input-sm" id="Genre"/></p>
                                    <label> Language </label>
                                    <p><input type="text" class="input-sm" id="Language"/></p>
                                    <label> ISBN </label>
                                    <p><input type="text" class="input-sm" id="ISBN"/></p>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary">Save changes</button>
                                </div>
                            </div><!-- /.modal-content -->
                        </div><!-- /.modal-dialog -->
                    </div><!-- /.modal -->

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
            </div><!-- end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadowholder container div -->

        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>
    </body>
</html>
