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



        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {
//                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
//                    $.fn.dataTable.tables({visible: true, api: true}).columns.adjust();
//                });
                var table = $('#user').DataTable({
                    //clear the table, if it exists
//                    if (table) table.clear(),
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
                    $("#userID").val($(this).closest('tr').children()[1].textContent); // ID
                    $("#userUname").val($(this).closest('tr').children()[2].textContent); // uname
                    $("#userFirstName").val($(this).closest('tr').children()[3].textContent); // First
                    $("#userLastName").val($(this).closest('tr').children()[4].textContent); // Last
                    $("#userFunction").val($(this).closest('tr').children()[5].textContent); // Function
                    $("#userRole").val($(this).closest('tr').children()[6].textContent); // Role
                });
            });
        </script>

        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {
                var table = $('#expReader').DataTable({

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

                    ],
                    "columnDefs": [
                        {className: "dt-left", "targets": [1, 2, 3]}
                    ]
                });

                $('table tbody tr  td').on('click', function () {
                    $("#FirstNameExpReader").val($(this).closest('tr').children()[1].textContent); // Reference
                    $("#LastNameExpReader").val($(this).closest('tr').children()[2].textContent); // Author
                    $("#EmailExpReader").val($(this).closest('tr').children()[4].textContent); // Year                    
                });
            });
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
//                    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
//                        $.fn.dataTable.tables({visible: true, api: true}).columns.adjust();
//                    });
                var table = $('#library').DataTable({
                    //clear the table, if it exists
//                        if (table) table.clear(),
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

                $('table tbody tr  td').on('click', function () {
                    $("#Reference").val($(this).closest('tr').children()[1].textContent); // Reference
                    $("#Author").val($(this).closest('tr').children()[2].textContent); // Author
                    $("#Title").val($(this).closest('tr').children()[3].textContent); // Title
                    $("#Year").val($(this).closest('tr').children()[4].textContent); // Year
                    $("#Genre").val($(this).closest('tr').children()[5].textContent); // Genre
                    $("#Translation").val($(this).closest('tr').children()[6].textContent); // Translation
                    $("#PublisherYear").val($(this).closest('tr').children()[5].textContent); // PublisherYear
                    $("#ISBN").val($(this).closest('tr').children()[6].textContent); // ISBN
                });
            });
        </script>

        <!--         <script>
                 $(".modal").on("shown.bs.modal", function () {
                        if ($(".modal-backdrop").length > 1) {
                            $(".modal-backdrop").not(':first').remove();
                        }
                    })
                </script> -->

        <script type="text/javascript">
            function launchModal(whichModal) {
                if (whichModal === 'user') {
                    $("#userModal").modal("show");
                } else if (whichModal === 'library') {
                    $("#libraryModal").modal("show");
                } else if (whichModal === 'expReader') {
                    $("#expReaderModal").modal("show");
                }
            }
            ;
        </script>

        <style>
            td.details-control {
                background: url('images/details_open.png') no-repeat center center;
                cursor: pointer;
            }
            tr.shown td.details-control {
                background: url('images/details_close.png') no-repeat center center;
            }

        </style>


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

        <sql:query var="userQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM users         
        </sql:query>
        <c:set var="userDetails" value="${userQuery.rows[0]}"/>

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

                </div> 
    
                        <nav class="navbar navbar-default" >
                            <div class="container-fluid"  style="background-color: #d9d1d1">
                                <!-- Brand and toggle get grouped for better mobile display -->
                                <div class="navbar-header">
                                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                        <span class="sr-only">Toggle navigation</span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                    <!--<a class="navbar-brand" href="#">Brand</a>-->
                                </div>
                                
                    <!-- Nav tabs -->
                                                    <!-- Collect the nav links, forms, and other content for toggling -->
                                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"  style="background-color: #d9d1d1">
                                    <ul class="nav navbar-nav nav-tabs two-lines" role="tablist">
                    <!--<ul class="nav nav-tabs" role="tablist">-->
                        <li role="tab" class="active"><a href="#Application" data-toggle="tab">Application Management</a></li>
                        <li role="tab" ><a href="#User" data-toggle="tab">User management</a></li>
                        <li role="tab" ><a href="#Contracts" data-toggle="tab">Contracts</a></li>
                        <li role="tab" ><a href="#ExpertReader" data-toggle="tab">Expert Reader</a></li>
                        <li role="tab" ><a href="#Library" data-toggle="tab">Library</a></li>
                        <li role="tab" ><a href="#Misc" data-toggle="tab">Misc</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
                    <!-- Tab panes -->
                    <div class="tab-content" >

                        <!--info-->
                        <div class="tab-pane fade active in" id="Application">
                            <h2>Application Management Content Goes Here</h2>
New Applications <br/>
 <br/>
Pennding Applications <br/>
 <br/>
Closed Applications <br/> <br/>
                        </div>

                        <!--User-->
                        <div class="tab-pane fade" id="User">
                            <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                                <h2>User Content Goes Here</h2>                                
                                <div class="table-responsive">
                                    <table id="user" class="table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th class="all">#</th>
                                                <th class="all">User Name</th>
                                                <th class="all">First Name</th>
                                                <th class="all">Last Name</th>
                                                <th class="all">Function</th>
                                                <th class="all">Role</th>
                                            </tr>
                                        </thead>

                                        <tfoot>
                                            <tr>
                                                <th></th>
                                                <th class="all">#</th>
                                                <th class="all">User Name</th>
                                                <th class="all">First Name</th>
                                                <th class="all">Last Name</th>
                                                <th class="all">Function</th>
                                                <th class="all">Role</th>
                                            </tr>
                                        </tfoot>

                                        <tbody>
                                            <c:forEach var="row" items="${userQuery.rows}">
                                                <tr>
                                                    <td class="details-control" onclick="launchModal('user')"></td>
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
                                <!--userModal-->
                                <div class="modal fade" id="userModal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"  data-toggle="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title">EDIT</h4>
                                            </div>
                                            <div class="modal-body">
                                                <label> ID: </label>
                                                <p><input type="text" class="input-sm" id="userID"/></p>
                                                <label> Uname: </label>
                                                <p><input type="text" class="input-sm" id="userUname"/></p>
                                                <label> First Name: </label>
                                                <p><input type="text" class="input-sm" id="userFirstName"/></p>
                                                <label> Last Name: </label>
                                                <p><input type="text" class="input-sm" id="userLastName"/></p>
                                                <label> Function: </label>
                                                <p><input type="text" class="input-sm" id="userFunction"/></p>
                                                <label> Role: </label>
                                                <p><input type="text" class="input-sm" id="userRole"/></p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal-dialog -->
                                </div><!-- /.modal -->
                                <!--userModal-->
                            </div> <!--User-->

                            <!--Contracts-->
                            <div class="tab-pane fade" id="Contracts">
                                <h2>Contracts Content Goes Here</h2>

                            </div><!--Contracts-->

                            <!--ExpertReader-->
                            <div class="tab-pane fade" id="ExpertReader">
                                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                                    <h2>ExpertReader Content Goes Here</h2>
                                    <div class="table-responsive">
                                        <table id="expReader" class="table table-striped table-bordered" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th class="all">First Name</th>
                                                    <th class="all">Last Name</th>
                                                    <th class="all">Email</th>
                                                </tr>
                                            </thead>

                                            <tfoot>
                                                <tr>
                                                    <th></th>
                                                    <th class="all">First Name</th>
                                                    <th class="all">Last Name</th>
                                                    <th class="all">Email</th>
                                                </tr>
                                            </tfoot>
                                            <tbody>
                                            <c:forEach var="row" items="${expertQuery.rows}">
                                                <tr>
                                                    <td class="details-control" onclick="launchModal('expReader')"></td>
                                                    <td><c:out value = "${row.first_name} " /></td>
                                                    <td><c:out value = "${row.last_name}" /></td>
                                                    <td><c:out value = "${row.email}" /></td>
                                                </tr>   
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>             
                                <c:if test="${not empty error}">Error: ${error}</c:if>
                                </div> <!-- /container-fluid -->
                                <!--expReaderModal-->
                                <div class="modal fade" id="expReaderModal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title">EDIT</h4>
                                            </div>
                                            <div class="modal-body">
                                                <label> First Name: </label>
                                                <p><input type="text" class="input-sm" id="FirstNameExpReader"/></p>
                                                <label> Last Name: </label>
                                                <p><input type="text" class="input-sm" id="LastNameExpReader"/></p>
                                                <label> Email: </label>
                                                <p><input type="text" class="input-sm" id="EmailExpReader"/></p>

                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal-dialog -->                                               
                                </div><!-- /.modal -->      
                            </div> <!--expReaderModal-->



                            <!--Library-->
                            <div class="tab-pane fade" id="Library">
                                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">
                                    <h2>Library Content Goes Here</h2>
                                    <div class="table-responsive">
                                        <table id="library" class="display table table-striped table-bordered  dt-responsive nowrap" role="grid" style="width: 100%;" aria-label="">

                                            <thead>
                                                <tr>
                                                    <th class="details-control sorting_disabled" rowspan="1" colspan="1" style="width: 0px;"  aria-label=""></th>
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
                                                    <th class="details-control"></th>
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
                                                    <td class="details-control" onclick="launchModal('library')" tabindex="1"></td>
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
                            <!--libraryModal-->
                            <div  class="modal fade" id="libraryModal" role="dialog" >    
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-toggle="modal"  data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                            <h4 class="modal-title">EDIT</h4>
                                        </div>
                                        <div class="modal-body">

                                            <label> Reference </label>
                                            <p><input type="text" class="input-sm" id="Reference"/></p>
                                            <label> Author </label>
                                            <p><input type="text" class="input-sm" id="Author"/></p>
                                            <label> Title </label>
                                            <p><input type="text" class="input-sm" id="Title"/></p>
                                            <label> Publisher: </label>
                                            <p><input type="text" class="input-sm" id="Publisher"/></p>
                                            <label> Year </label>
                                            <p><input type="text" class="input-sm" id="Year"/></p>
                                            <label> Genre </label>
                                            <p><input type="text" class="input-sm" id="Genre"/></p>
                                            <label> Translation </label>
                                            <p><input type="text" class="input-sm" id="Translation"/></p>
                                            <label> PublisherYear </label>
                                            <p><input type="text" class="input-sm" id="PublisherYear"/></p>
                                            <label> ISBN </label>
                                            <p><input type="text" class="input-sm" id="ISBN"/></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" id="modal-btn-ok" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div><!-- /.modal -->
                        </div> <!--Library-->

                        <!--Misc-->
                        <div class="tab-pane fade" id="Misc">
                            <h2>Misc Content Goes Here</h2>


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
            </div>
            <!-- end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadow container div -->
        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>
    </body>
</html>
