<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>



        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/plug-ins/1.10.15/integration/font-awesome/dataTables.fontAwesome.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">


        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>        
        <script src="js/bootstrap-datepicker.js"></script>
        <!--<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>-->  
        <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>

        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.js"></script>  

        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>       
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
        <script src="//cdn.datatables.net/plug-ins/1.10.12/sorting/datetime-moment.js"></script>
        <script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js "></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/plug-ins/1.10.15/dataRender/datetime.js"></script>



        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {
                var mail;
                var table = $("#user").DataTable({
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
                            titleAttr: 'Excel',
                            title: 'Irish Literature User'
                        },
                        {
                            extend: 'csvHtml5',
                            text: '<i class="fa fa-file-text-o"></i>',
                            titleAttr: 'CSV',
                            title: 'Irish Literature User'
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o"></i>',
                            titleAttr: 'PDF',
                            title: 'Irish Literature User'
                        }
                    ],
                    "bProcessing": false,
                    "bServerSide": false,
                    "sAjaxSource": "./UserDataServlet",
                    "columns": [{
                            "targets": -1,
                            "class": "details-control",
                            "orderable": false,
                            "data": null,
                            "defaultContent": ""
                        },
                        {"data": "USERNAME"},
                        {"data": "FIRST_NAME"},
                        {"data": "LAST_NAME"},
                        {"data": "EMAIL",
                            "render": function (data, type, row) {
                                $mail = 'mailto: ' + data + '';
                                console.log($mail);
                                return '<a href="mailto:' + data + '"><i class="fa fa-envelope" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "FUNCTION"},
                        {"data": "ROLE"},
                        {"data": "EMAIL_VERIFICATION_ATTEMPTS"}
                    ],
                    columnDefs: [
                        {
                            targets: -1,
                            visible: false
                        },

                        {className: "dt-left", "targets": [1, 2, 3]}
                    ]
                });

                $('#user tbody').on('click', 'tr td.details-control', function () {
                    $("#userModal").modal("show");
                    $("#userUname").val($(this).closest('tr').children()[1].textContent); // uname
                    $("#userFirstName").val($(this).closest('tr').children()[2].textContent); // First
                    $("#userLastName").val($(this).closest('tr').children()[3].textContent); // Last
                    $("#userEmail").val($(this).closest('tr').children()[4].textContent); // EMAIL     
                    var m = $mail;
                    alert(m);
                    $("#userEmail").val(m);
                    $("#userFunction").val($(this).closest('tr').children()[5].textContent); // Function
                    $("#userRole").val($(this).closest('tr').children()[6].textContent); // Role
                    //    console.log(table.row(this).data());
                });
//                console.log(table);

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
                            text: '<i class="fa fa-files-o"></i>',
                            titleAttr: 'Copy',
                            exportOptions: {
                                columns: ':contains("Office")'
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            text: '<i class="fa fa-file-excel-o"></i>',
                            titleAttr: 'Excel',
                            title: 'Irish Literature Expert Reader'
                        },
                        {
                            extend: 'csvHtml5',
                            text: '<i class="fa fa-file-text-o"></i>',
                            titleAttr: 'CSV',
                            title: 'Irish Literature Expert Reader'
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o"></i>',
                            titleAttr: 'PDF',
                            title: 'Irish Literature Expert Reader'
                        }

                    ],
                    "columnDefs": [
                        {className: "dt-left", "targets": [1, 2, 3]}
                    ],
                    "bProcessing": false,
                    "bServerSide": false,
                    "sAjaxSource": "./ExpertReaderDataServlet",
                    "columns": [{
                            "targets": -1,
                            "class": "details-control",
                            "orderable": false,
                            "data": null,
                            "defaultContent": ""
                        },

                        {"data": "FIRST_NAME"},
                        {"data": "LAST_NAME"},
                        {"data": "EMAIL"}
                    ]
                });
                $('#expReader tbody').on('click', 'tr td.details-control', function () {
                    $("#expReaderModal").modal("show");
                    $("#FirstNameExpReader").val($(this).closest('tr').children()[1].textContent); // Reference
                    $("#LastNameExpReader").val($(this).closest('tr').children()[2].textContent); // Author
                    $("#EmailExpReader").val($(this).closest('tr').children()[3].textContent); // Year                    
                    //   console.log(table.row(this).data());
                });
            });
        </script>

        <script type="text/javascript">
            $(document).ready(function () {
                var table = $("#books").DataTable({
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
                            titleAttr: 'Excel',
                            title: 'Irish Literature Library'
                        },
                        {
                            extend: 'csvHtml5',
                            text: '<i class="fa fa-file-text-o"></i>',
                            titleAttr: 'CSV',
                            title: 'Irish Literature Library'
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o"></i>',
                            titleAttr: 'PDF',
                            title: 'Irish Literature Library'
                        }

                    ],

                    "bProcessing": false,
                    "bServerSide": false,
                    "sAjaxSource": "./LibraryDataServlet",
                    "columns": [{
                            "targets": 0,
                            "class": "btn-control",
                            "orderable": false,
                            "data": null,
                            "defaultContent": "<i class='fa fa-pencil-square fa-lg'></i>",
                        },
                        {
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
//                        {"data": "Publisher"},
                        {"data": "Publisheryear"},
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
                        {"data": "ISSN"},
                        {"data": "Copies"}
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

                $('#books tbody').on('click', 'tr td.details-control', function () {

                    $("#booksModal").modal("show");
                    $("#referenceNumber").val($(this).closest('tr').children()[3].textContent); // ID
                    $("#Author").val($(this).closest('tr').children()[4].textContent); // uname
                    $("#Title").val($(this).closest('tr').children()[5].textContent); // First
                    $("#Genre").val($(this).closest('tr').children()[7].textContent); // Last
                    $("#Language").val($(this).closest('tr').children()[11].textContent); // Function
                    $("#ISBN").val($(this).closest('tr').children()[16].textContent); // Role
                    //     console.log(table.row(this).data());
                });

//
                $('#books tbody').on('click', 'tr td.btn-control', function () {

                    $("#editBooksModal").modal("show");
                    $("#referenceNumber2").val($(this).closest('tr').children()[3].textContent); // ID
                    $("#Author2").val($(this).closest('tr').children()[4].textContent); // uname
                    $("#Title2").val($(this).closest('tr').children()[5].textContent); // First
                    $("#Genre2").val($(this).closest('tr').children()[7].textContent); // Last
                    $("#Language2").val($(this).closest('tr').children()[11].textContent); // Function
                    //      $("#ISBN2").val($(this).closest('tr').children()[16].textContent); // Role
                    console.log(table.row(this).data());
                });

            });
        </script>


        <script type="text/javascript">
            var agreemnt;
            var contr;
            var transSamp;
            var trans;
            $(document).ready(function () {



//        $.fn.dataTable.moment('dddd, MMMM Do, YYYY');
                var table = $("#applications").DataTable({
                    autoWidth: false,
                    initComplete: function () {
                        this.api().columns('.select-filter').every(function () {
                            var column = this;
                            var select = $('<select><option value=""></option></select>')
                                    .appendTo($(column.footer()).empty())
                                    .on('change', function () {
                                        var val = $.fn.dataTable.util.escapeRegex(
                                                $(this).val()
                                                );
                                        column
                                                .search(val ? '^' + val + '$' : '', true, false)
                                                .draw();
                                    });
                            column.data().unique().sort().each(function (d, j) {
                                select.append('<option value="' + d + '">' + d + '</option>');
                            });
                        });
                    },
                    responsive: {
                        details: {
                            display: $.fn.dataTable.Responsive.display.modal({
                                header: function (row) {
                                    var data = row.data();
                                    return 'Details for ' + data[0] + ' ' + data[1];
                                }
                            }),
                            renderer: $.fn.dataTable.Responsive.renderer.tableAll({
                                tableClass: 'table'
                            })
                        }
                    },
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
                            titleAttr: 'Excel',
                            title: 'Irish Literature Library'
                        },
                        {
                            extend: 'csvHtml5',
                            text: '<i class="fa fa-file-text-o"></i>',
                            titleAttr: 'CSV',
                            title: 'Irish Literature Library'
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o"></i>',
                            titleAttr: 'PDF',
                            title: 'Irish Literature Library'
                        }
                    ],
                    "bProcessing": '<i class="icon-spinner icon-spin"></i> Loading...',
                    "bServerSide": false,
                    "sAjaxSource": "./ApplicationDataServlet",
                    "columns": [
                        {
                            "targets": 0,
                            "class": "details-control",
                            "orderable": false,
                            "data": null,
                            "defaultContent": ""
                        },
                        {"data": "ApplicationNumber"},
                        {"data": "ApplicationYear"},
                        {"data": "ReferenceNumber"},
                        {"data": "company"},
                        {"data": "agreement",
                            "render": function (data, type, row) {

//
                                $agreemnt = 'http://localhost' + data + '';
//                                alert("$agreemnt  " + $agreemnt);
//                                console.log($agreemnt);
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "contract",
                            "render": function (data, type, row) {
                                $contr = 'http://localhost' + data + '';
                                //          console.log(contr);
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "proposedDateOfPublication",
                            "render": function (data) {
                                var date = new Date(data);
                                //          console.log(date);
                                var month = date.getMonth() + 1;
                                //          console.log(month);
                                return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                            }},
                        {"data": "proposedDateOfPrintRun",
                            "render": function (data) {
                                var date = new Date(data);
                                var month = date.getMonth() + 1;
                                return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                            }},
                        {"data": "plannedPageExtent"},
                        {"data": "translatorCV",
                            "render": function (data, type, row) {
                                $trans = 'http://localhost' + data + '';
                                //        console.log($trans);
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "numberOfPages"},
                        {"data": "feePerPage"},
                        {"data": "translatorFee"},
                        {"data": "Notes"},
                        {"data": "Status"},
                        {"data": "copiesSent",
                            "render": function (data, type, row) {
                                if (data === 0) {

                                    return 'Niet';
                                } else {
                                    return 'Da';
                                }
                                ;
                            }},
                        {"data": "dateCopiesWereSent",
                            "render": function (data) {
                                var date = new Date(data);
                                var month = date.getMonth() + 1;
                                return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                            }
                        },
                        {"data": "copiesTranslationSample",
                            "render": function (data, type, row) {
                                $transSamp = 'http://localhost' + data + '';
                                //        console.log($transSamp);
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "TC_ACCEPTED",
                            "render": function (data, type, row) {
                                if (data === 0) {
                                    return 'Nope';
                                } else {
                                    return 'Oui';
                                }
                                ;
                            }},
                        {"data": "APPROVED",
                            "render": function (data, type, row) {
                                if (data === 0) {
                                    return 'Nada';
                                } else {

                                    return 'JaJa';
                                }
                                ;
                            }},
                        {"data": "translatorCVDocName"}
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
                        {
                            "targets": 2,
                            "createdCell": function (td, cellData, rowData, row, col) {
                                if (cellData === 'new') {
                                    $(td).css('color', 'red');
                                }
                            }
                        },
//                        {
//                            targets: [7, 8],
//                            render: function (data) {
//                                return moment(data).format('MM DD, YYYY','DD/MM/YYYY');
//                            }},
                        {className: "dt-left", "targets": [2, 7, 8]}
                    ]

                });

                $('#applications tbody').on('click', 'tr td.details-control', function () {

                    $("#applicationsModal").modal("show");

                    $("#appApplicationNumber").val($(this).closest('tr').children()[1].textContent);
                    $("#appApplicationYear").val($(this).closest('tr').children()[2].textContent);
                    $("#appReferenceNumber").val($(this).closest('tr').children()[3].textContent);
                    $("#appCompany").val($(this).closest('tr').children()[4].textContent);
                    $("#appAgreement").val($(this).closest('tr').children()[5].textContent);

                    var a = $agreemnt;
//                    alert("$agreemnt 2:: " + $agreemnt);
                    $("#appAgreement").val(a);


                    $("#appcontract").val($(this).closest('tr').children()[6].textContent);

                    var c = $contr;
//                    alert("$contr 2:: " + $contr);
                    $("#appcontract").val(c);

                    $("#appproposedDateOfPublication").val($(this).closest('tr').children()[7].textContent);
                    $("#appproposedDateOfPrintRun").val($(this).closest('tr').children()[8].textContent);
                    $("#appplannedPageExtent").val($(this).closest('tr').children()[9].textContent);
                    $("#apptranslatorCV").val($(this).closest('tr').children()[10].textContent);

                    var cv = $trans;
//                    alert("$trans 2:: " + $trans);
                    $("#apptranslatorCV").val(cv);


                    $("#appnumberOfPages").val($(this).closest('tr').children()[11].textContent);
                    $("#appfeePerPage").val($(this).closest('tr').children()[12].textContent);
                    $("#apptranslatorFee").val($(this).closest('tr').children()[13].textContent);
                    $("#appNotes").val($(this).closest('tr').children()[14].textContent);
                    $("#appStatus").val($(this).closest('tr').children()[15].textContent);
                    $("#appcopiesSent").val($(this).closest('tr').children()[16].textContent);
                    $("#appdateCopiesWereSent").val($(this).closest('tr').children()[17].textContent);
                    $("#appcopiesTranslationSample").val($(this).closest('tr').children()[18].textContent);

                    var ts = $transSamp;
//                    alert("$transSamp 2:: " + $transSamp);
                    $("#appcopiesTranslationSample").val(ts);


                    $("#appTC_ACCEPTED").val($(this).closest('tr').children()[19].textContent);
                    $("#appAPPROVED").val($(this).closest('tr').children()[20].textContent);
                    console.log(table.row(this).data());
                });
            });
        </script>


        <!--get selectpicker selection--> 
        <script type="text/javascript">
            $(document).ready(function () {

                $('.selectpicker').on('change', function () {
                    var selected = $(this).find("option:selected").val();
                });
            });
        </script>

        <style>
            td.details-control {
                background: url('images/details_open.png') no-repeat center center;
                cursor: pointer;
            }
            tr.shown td.details-control {
                background: url('images/details_close.png') no-repeat center center;
            }
            application.dataTable tbody td {
                word-break: break-all;
                vertical-align: top;
            }

            textarea {
                resize: vertical;
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

                <div class="container-fluid" style="margin-bottom: 20px">

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

                            <!--Application-->
                            <div class="tab-pane fade  active in" id="Application">
                                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">

                                    <div class="table-responsive">
                                        <table id="applications" class="table display table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th class="details-control"></th>   
                                                    <th class="all">Application<br/>  Nr</th>
                                                    <th class="all">Application<br/>  Year</th>
                                                    <th class="all">Reference<br/>  Nr</th>
                                                    <th class="all">Publisher</th>                                                  
                                                    <!--<th class="all">PublisherID</th>-->
                                                    <!--<th class="all">userID</th>-->
                                                    <th class="all">Agreement</th>
                                                    <th class="all">Contract</th>
                                                    <th class="all">Proposed<br/> Date of <br/> Publication</th>
                                                    <th class="all">Proposed<br/> Date of <br/> Print Run</th>
                                                    <th class="all">Planned Page <br/>  Extent</th>
                                                    <th class="all">Translator<br/> CV</th>
                                                    <th class="all">Number<br/> Pages</th>
                                                    <th class="all">Fee per  <br/> Page</th>
                                                    <th class="all">Translator  <br/> Fee</th>
                                                    <th class="all">Notes</th>
                                                    <th class="all select-filter">Status</th>
                                                    <th class="all">Copies <br/> Sent</th>
                                                    <th class="all">Date Copies  <br/> Were Sent</th>
                                                    <th class="all">Copies of  <br/> Translation Sample</th>
                                                    <th class="all">T&C has been <br/> Accepted</th>
                                                    <th class="all">Approved</th>    
                                                    <th class="all"></th>

                                                </tr>
                                            </thead>

                                            <tfoot>
                                                <tr>
                                                    <th class="details-control"></th>   
                                                    <th class="all">Application<br/>  Nr</th>
                                                    <th class="all">Application<br/>  Year</th>
                                                    <th class="all">Reference<br/>  Nr</th>
                                                    <th class="all">Publisher</th>                                                  
                                                    <!--<th class="all">PublisherID</th>-->
                                                    <!--<th class="all">userID</th>-->
                                                    <th class="all">Agreement</th>
                                                    <th class="all">Contract</th>
                                                    <th class="all">Proposed<br/> Date of <br/> Publication</th>
                                                    <th class="all">Proposed<br/> Date of <br/> Print Run</th>
                                                    <th class="all">Planned Page <br/>  Extent</th>
                                                    <th class="all">Translator<br/> CV</th>
                                                    <th class="all">Number<br/> Pages</th>
                                                    <th class="all">Fee per  <br/> Page</th>
                                                    <th class="all">Translator  <br/> Fee</th>
                                                    <th class="all">Notes</th>
                                                    <th class="all select-filter">Status</th>
                                                    <th class="all">Copies <br/> Sent</th>
                                                    <th class="all">Date Copies  <br/> Were Sent</th>
                                                    <th class="all">Copies of  <br/> Translation Sample</th>
                                                    <th class="all">T&C has been <br/> Accepted</th>
                                                    <th class="all">Approved</th>    
                                                    <th class="all"></th>
                                                </tr>
                                            </tfoot>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>                   
                                </div> <!-- container-fluid -->  


                                <!--userModal-->

                                <div class="modal fade" id="applicationsModal" tabindex="-1" role="dialog" aria-labelledby="applicationsModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="applicationsModalLabel">Display Applications</h4>
                                            </div>
                                            <div class="modal-body">


                                                <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                    <div class="col-sm-4">
                                                        <label for="appReferenceNumber" class="control-label pull-left">Reference Number</label>
                                                        <input  id="appReferenceNumber" 
                                                                type="text"                                                  
                                                                class="form-control"    
                                                                name="appReferenceNumber"    
                                                                >
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="appStatus" class="control-label pull-left">Status</label>
                                                        <input id="appStatus"                                
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appStatus"                                
                                                               >
                                                    </div>
                                                </div> <!--row-->

                                                <!--second row-->

                                                <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                    <div class="col-sm-8">        
                                                        <label for="appCompany" class="control-label pull-left">Publisher</label>
                                                        <input id="appCompany"                                
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appCompany"                                
                                                               >
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">
                                                        <div class="col-sm-6">                                                        
                                                            <input id="appAgreement"
                                                                   type="hidden"        
                                                                   class="form-control"  
                                                                   name="appAgreement"         
                                                                   >
                                                        </div> 

                                                        <a class="btn btn-info" role="button" id="agreement" >
                                                            <span class="glyphicon glyphicon-file"></span>
                                                            Open Agreement</a>
                                                        <script>
                                                            var appAgreement_element = document.getElementById('appAgreement');
                                                            var appagreement = appAgreement_element.value;
//                                                            alert("appAgreement:    " + appAgreement);
                                                            console.log(appagreement);
                                                            document.getElementById("agreement").href = appagreement;
                                                        </script>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-6">
                                                            <input id="appcontract" 
                                                                   type="hidden"     
                                                                   name="appcontract"  
                                                                   >
                                                        </div>

                                                        <a class="btn btn-info" role="button" id="contract" >
                                                            <span class="glyphicon glyphicon-file"></span>
                                                            Open Contract</a>
                                                        <script>
                                                            var contract_element = document.getElementById('appcontract');
                                                            var contrct = contract_element.value;
                                                            console.log(contrct);
                                                            document.getElementById("contract").href = contrct;
                                                        </script>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-6">
                                                            <input id="apptranslatorCV"
                                                                   type="hidden"                                                             
                                                                   name="apptranslatorCV"                                
                                                                   >
                                                        </div>
                                                        <a class="btn btn-info" role="button" id="translatorCV" >
                                                            <span class="glyphicon glyphicon-file"></span>
                                                            Open Translator CV</a>
                                                        <script>
                                                            var translatorCV_element = document.getElementById('apptranslatorCV');
                                                            var trCV = translatorCV_element.value;
                                                            console.log(trCV);
                                                            document.getElementById("translatorCV").href = trCV;
                                                        </script>
                                                    </div>
                                                </div>

                                                <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                    <div class="col-sm-3">
                                                        <label for="appproposedDateOfPublication" class="control-label pull-left">Proposed Date of Publication</label>
                                                        <input id="appproposedDateOfPublication"                                
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appproposedDateOfPublication"                                
                                                               >
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="appproposedDateOfPrintRun" class="control-label pull-left">Proposed Date of Print Run</label>
                                                        <input  id="appproposedDateOfPrintRun" 
                                                                name="appproposedDateOfPrintRun" 
                                                                type="text"                                                                
                                                                class="form-control"     
                                                                >
                                                    </div>

                                                    <div class="col-sm-4">        
                                                        <label for="appplannedPageExtent" class="control-label pull-left">Planned Page<br/> Extend</label>
                                                        <input id="appplannedPageExtent"                                
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appplannedPageExtent"                                
                                                               >
                                                    </div>
                                                </div> <!--row-->

                                                <!--second row-->

                                                <div class="row">
                                                    <div class="col-sm-4">                                               
                                                        <label for="appnumberOfPages" class="control-label pull-left">Number of Pages</label>
                                                        <div class="input-group" style="margin-bottom: 40px">
                                                            <label class="input-group-addon" for="appnumberOfPages">
                                                                <span class="glyphicon glyphicon-duplicate"></span>
                                                            </label>
                                                            <input id="appnumberOfPages"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   >
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-3">
                                                        <label for="appfeePerPage" class="control-label pull-left">Fee per Page</label>
                                                        <div class="input-group" style="margin-bottom: 40px">
                                                            <!--<label for="appReferenceNumber" class="control-label pull-left">Fee per Page</label>-->

                                                            <label class="input-group-addon" for="appfeePerPage">

                                                                <span class="glyphicon glyphicon-euro"></span>                                     
                                                            </label>
                                                            <input type="text" class="form-control" name="appfeePerPage" id="appfeePerPage" placeholder="fee">    
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-3">
                                                        <label for="apptranslatorFee" class="control-label pull-left">Fee per Page</label>
                                                        <div class="input-group" style="margin-bottom: 40px">                                                               
                                                            <label class="input-group-addon" for="apptranslatorFee">                                                           
                                                                <span class="glyphicon glyphicon-euro"></span>                                     
                                                            </label>
                                                            <input type="text" class="form-control" name="apptranslatorFee" id="apptranslatorFee" placeholder="fee">    
                                                        </div>
                                                    </div>
                                                </div> <!--row-->

                                                <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                    <div class="col-sm-12">
                                                        <label for="appNotes" class="control-label pull-left">Notes</label>
                                                        <textarea id="appNotes" 
                                                                  class="form-control"                                               
                                                                  name="Notes"    
                                                                  style="height: 183px"
                                                                  >                 
                                                        </textarea>
                                                    </div>
                                                </div> <!--row-->

                                                <!--second row-->

                                                <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                    <div class="col-sm-3">
                                                        <label for="appcopiesSent" class="control-label pull-left">Have copies been sent?</label>
                                                        <input id="appcopiesSent"
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appcopiesSent"                                
                                                               >
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label for="appdateCopiesWereSent" class="control-label pull-left">Date copies were sent</label>
                                                        <input id="appdateCopiesWereSent"                                
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appdateCopiesWereSent"                                
                                                               >
                                                    </div>
                                                </div> <!--row-->

                                                <div class="row">
                                                    <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">  
                                                        <div class="col-sm-6">
                                                            <input id="appcopiesTranslationSample"                                
                                                                   type="hidden"                                                            
                                                                   name="appcopiesTranslationSample"                                
                                                                   >
                                                        </div>
                                                        <a class="btn btn-info" role="button" id="copiesTranslationSample" >
                                                            <span class="glyphicon glyphicon-file"></span>
                                                            Open Translation Sample</a>
                                                        <script>
                                                            var copiesTS_element = document.getElementById('appcopiesTranslationSample');
                                                            var copiesTS = copiesTS_element.value;
                                                            console.log(copiesTS);
                                                            document.getElementById("copiesTranslationSample").href = copiesTS;
                                                        </script>
                                                    </div>
                                                </div> <!--row-->

                                                <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                    <div class="col-sm-3">
                                                        <label for="appTC_ACCEPTED" class="control-label pull-left">T&C accepted</label>
                                                        <input id="appTC_ACCEPTED"
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appTC_ACCEPTED"                                
                                                               >
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <label for="appAPPROVED" class="control-label pull-left">Application Approved</label>
                                                        <input id="appAPPROVED"
                                                               type="text"                                
                                                               class="form-control"                                
                                                               name="appAPPROVED"                                
                                                               >
                                                    </div>


                                                    <div class="col-sm-2">
                                                        <label for="approve" style="margin-top: 7px" class="control-label pull-left"> &nbsp;</label>
                                                        <button id="approve" type="button" class="btn btn-success">Approve</button>

                                                    </div>

                                                    <div class="col-sm-2">
                                                        <label for="reject" style="margin-top: 7px" class="control-label pull-left"> &nbsp;</label>
                                                        <button  id="reject" type="button" class="btn btn-danger">Reject</button>
                                                    </div>
                                                </div> <!--row-->

                                            </div><!--modal body-->

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal-dialog -->
                                </div><!-- /.modal -->
                                <!--userModal-->
                            </div><!-- <div class="tab-pane fade active in" id="Application"> --> 


                            <!--User-->

                            <div class="tab-pane fade" id="User">
                                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">

                                    <div class="table-responsive">
                                        <table id="user" class="display user table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th class="details-control"></th>              
                                                    <th class="all">User Name</th>
                                                    <th class="all">First Name</th>
                                                    <th class="all">Last Name</th>
                                                    <th class="all">Email</th>
                                                    <th class="all">Function</th>
                                                    <th class="all">Role</th>
                                                    <th class="all"></th>
                                                </tr>
                                            </thead>

                                            <tfoot>
                                                <tr>
                                                    <th class="details-control"></th>
                                                    <th class="all">User Name</th>
                                                    <th class="all">First Name</th>
                                                    <th class="all">Last Name</th>
                                                    <th class="all">Email</th>
                                                    <th class="all">Function</th>
                                                    <th class="all">Role</th>
                                                    <th class="all"></th>
                                                </tr>
                                            </tfoot>

                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>             
                                    <c:if test="${not empty error}">Error: ${error}</c:if>
                                    </div> <!-- /container-fluid -->

                                    <!--userModal-->

                                    <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="userModalLabel">Display Users</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <label> Uname: </label>
                                                    <p><input type="text" class="input-sm" id="userUname"/></p>
                                                    <label> First Name: </label>
                                                    <p><input type="text" class="input-sm" id="userFirstName"/></p>
                                                    <script>
                                                        var FN = document.getElementById('userFirstName');
                                                        var uFN = FN.value;
                                                        var label = "Send email to " + uFN;
                                                        console.log(label);
//                                                        document.getElementById("msg").innerHTML = label;
                                                    </script>
                                                    <label> Last Name: </label>
                                                    <p><input type="text" class="input-sm" id="userLastName"/></p>

                                                    <div class="row">
                                                        <input id="userEmail"
                                                               type="hidden"                                   
                                                               name="userEmail"               
                                                               >                                                    
                                                        <a class="btn btn-info" role="button" id="mails" >
                                                            <span class="glyphicon glyphicon-envelope"></span>
                                                            <p id="msg">Send Email</p> </a>
                                                        <script>
                                                            var mail_element = document.getElementById('userEmail');
                                                            var mail = mail_element.value;
                                                            console.log(mail);
                                                            document.getElementById("mails").href = mail;
                                                        </script>
                                                    </div>

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

                                        <div class="table-responsive">
                                            <table id="expReader" class="table table-striped table-bordered" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th class="details-control"></th>
                                                        <th class="all">First Name</th>
                                                        <th class="all">Last Name</th>
                                                        <th class="all">Email</th>
                                                    </tr>
                                                </thead>

                                                <tfoot>
                                                    <tr>
                                                        <th class="details-control"></th>
                                                        <th class="all">First Name</th>
                                                        <th class="all">Last Name</th>
                                                        <th class="all">Email</th>
                                                    </tr>
                                                </tfoot>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>             
                                    <c:if test="${not empty error}">Error: ${error}</c:if>
                                    </div> <!-- /container-fluid -->

                                    <!--expReaderModal-->

                                    <div class="modal fade" id="expReaderModal" tabindex="-1" role="dialog" aria-labelledby="expReaderModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="expReaderModalLabel">Display Expert Readers</h4>
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

                                        <div class="table-responsive">
                                            <table id="books" class="display table table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th class="btn-control"></th>
                                                        <th class="details-control"></th>
                                                        <th class="all">bookID</th>
                                                        <th class="all">Reference <br/> Number</th>
                                                        <th class="all">Author</th>
                                                        <th class="all">Title</th>
                                                        <!--                                                        <th class="all">Publisher</th>-->
                                                        <th class="all">Publisher <br/>Year</th>
                                                        <th class="all">Genre</th>
                                                        <th class="all">Translation<br/>Title</th>                                       
                                                        <th class="all">Translation<br/>Publisher Year</th>
                                                        <th class="all">Translator</th>
                                                        <th class="all">Language</th>
                                                        <th class="all">Physical<br/>Description</th>
                                                        <th class="all">Duplicates</th>
                                                        <th class="all">Copies</th>
                                                        <th class="all">Notes</th>
                                                        <th class="all">ISBN</th>
                                                        <th class="all">ISSN</th>
                                                        <th class="all"></th>
                                                    </tr>
                                                </thead>

                                                <tfoot>
                                                    <tr>
                                                        <th class="btn-control"></th>
                                                        <th class="details-control"></th>
                                                        <th class="all">bookID</th>
                                                        <th class="all">Reference <br/> Number</th>
                                                        <th class="all">Author</th>
                                                        <th class="all">Title</th>
                                                        <!--                                                        <th class="all">Publisher</th>-->
                                                        <th class="all">Publisher <br/>Year</th>
                                                        <th class="all">Genre</th>
                                                        <th class="all">Translation<br/>Title</th>                                       
                                                        <th class="all">Translation<br/>Publisher Year</th>
                                                        <th class="all">Translator</th>
                                                        <th class="all">Language</th>
                                                        <th class="all">Physical<br/>Description</th>
                                                        <th class="all">Duplicates</th>
                                                        <th class="all">Copies</th>
                                                        <th class="all">Notes</th>
                                                        <th class="all">ISBN</th>
                                                        <th class="all">ISSN</th>
                                                        <th class="all"></th>
                                                    </tr>
                                                </tfoot>

                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>             
                                    <c:if test="${not empty error}">Error: ${error}</c:if>


                                    <div class="modal fade" id="booksModal" tabindex="-1" role="dialog" aria-labelledby="booksModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="booksModalLabel">Display Library</h4>
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


                                    <div class="modal fade" id="editBooksModal" tabindex="-1" role="dialog" aria-labelledby="editBooksModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="editBooksModalLabel">Edit Books</h4>
                                                </div>
                                                <div class="modal-body">


                                                    <label> referenceNumber </label>
                                                    <p><input type="text" class="input-sm" id="referenceNumber2"/></p>
                                                    <label> Author </label>
                                                    <p><input type="text" class="input-sm" id="Author2"/></p>
                                                    <label> Title: </label>
                                                    <p><input type="text" class="input-sm" id="Title2"/></p>
                                                    <label> Genre: </label>
                                                    <p><input type="text" class="input-sm" id="Genre2"/></p>
                                                    <label> Language </label>
                                                    <p><input type="text" class="input-sm" id="Language2"/></p>
                                                    <label> ISBN </label>
                                                    <p><input type="text" class="input-sm" id="ISBN2"/></p>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary">Save changes</button>
                                                </div>
                                            </div><!-- /.modal-content -->
                                        </div><!-- /.modal-dialog -->
                                    </div><!-- /.modal -->



                                </div>
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
