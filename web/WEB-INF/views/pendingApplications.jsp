<%-- 
    Document   : pendingApplications
    Created on : 07-March-2017, 23:27:58
    Author     : markus
--%>

<%@ page import="java.io.*,java.io.*,java.util.*,org.apache.poi.hwpf.HWPFDocument,org.apache.poi.hwpf.extractor.WordExtractor" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html style="height: 100%" >
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Translation Grant Application System</title>
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" /> 
        <!--
           https://www.javaworld.com/article/2072937/java-web-development/solving-the-logout-problem-properly-and-elegantly.html?page=2
           Solving the logout problem properly and elegantly
        -->

        <%
//            response.setHeader("Cache-Control", "no-cache"); //forces caches to obtain a new copy of the page from the origin server
//            response.setHeader("Cache-Control", "no-store"); //directs caches not to store the page under any circumstance
//            response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
//            response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

//            String userName = (String) session.getAttribute("username");
//            if (null == userName) {
//                System.out.println("userName: " + userName + " not found");
//                request.setAttribute("Error", "Session has ended.  Please login.");
//                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/login.jsp");
//                rd.forward(request, response);
//            }
        %>

        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <!-- Bootstrap -->


        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="css/responsive.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="css/irishLiterature.css">



        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script src="js/dataTables.responsive.min.js"></script>
        <script src="js/dataTables.bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"></script>

        <script type="text/javascript"  src="js/pdf.js"></script>
        <script type="text/javascript"  src="js/pdf.worker.js"></script>
        <!-- 
                    <link rel="stylesheet" type="text/css" href="../../kartik/css/fileinput.css" media="all" />
            <script type="text/javascript" src="kartik/js/plugins/sortable.js"></script> 
                    <script type="text/javascript" src="kartik/js/plugins/piexif.js"></script>
                    <script type="text/javascript" src="kartik/js/plugins/purify.js"></script>
            <script type="text/javascript" src="kartik/js/fileinput.js"></script>
        -->
        <!-- 
                    <script type="text/javascript" src="../../kartik/js/plugins/sortable.js"></script>
                    <script type="text/javascript" src="../../kartik/js/plugins/piexif.js"></script>
                            <script type="text/javascript" src="../../kartik/js/plugins/purify.js"></script>
                            <script type="text/javascript" src="../../kartik/js/fileinput.js"></script>-->         <!--
                            <style>
                                    .ui-state-highlight, 
                                    .ui-widget-content .ui-state-highlight, 
                                    .ui-widget-header .ui-state-highlight {
                                    border: 1px solid #003399;
                                    background: #003399 url("css/images/ui-bg_glass_55_fbf9ee_1x400.png") 50% 50% repeat-x;
                            }
                    
                            
                    .ui-datepicker { 
                    width: 17em; 
                    padding: .2em .2em 0; 
                    display: none; 
                    z-index: 2000 !important;
                    }
                    
                    /*.ui-datepicker-calendar a.ui-state-default { background: cyan; }*/
                    .ui-datepicker-calendar td.ui-datepicker-today a { background: lime; } 
                    .ui-datepicker-calendar a.ui-state-hover { background: yellow; } 
                    .ui-datepicker-calendar a.ui-state-active { background: red; } 
        
                    </style>-->


        <script>

//var TranslatorDocs = [];
            var translatorArray = [];
            var authorArray = [];
            var languageArray = [];
            var pressCuttingArray = [];
            var Name = "";
            var Author = "";
            var counter = 0;
            var Authorcounter = 0;
            var pressCuttingCounter = 0;
            var translatorCounter = 0;
            var translatorCounter1 = 0;
            var translatorName876 = "";
            var bookCover;
            var bookTranslationTitle;
            var uploadCounter = 1;

            $.datepicker.setDefaults({
                dateFormat: 'dd/mm/yy',
                showOtherMonths: true,
                selectOtherMonths: true,
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                gotoCurrent: true,
                orientation: "bottom" // <-- and add this
            });
            PDFJS.workerSrc = 'js/pdf.worker.js';
//      localStorage.clear();

            var i;

            console.log("local storage - pendingApplications.jsp");
            for (i = 0; i < localStorage.length; i++) {
                console.log(localStorage.key(i) + "=[" + localStorage.getItem(localStorage.key(i)) + "]");
            }

            console.log("session storage - pendingApplications.jsp");
            for (i = 0; i < sessionStorage.length; i++) {
                console.log(sessionStorage.key(i) + "=[" + sessionStorage.getItem(sessionStorage.key(i)) + "]");
            }
        </script>      

        <script type="text/javascript">
            var cntr = 0;
            $(document).ready(function () {
                var table = $("#applications").DataTable({
                    stateSave: true,
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
                    buttons: [{

                            text: '<i class="fa fa-files-o"></i>', titleAttr: 'email',
                            exportOptions: {
                                columns: ':contains("Office")'
                            }
                        },
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
                        {extend: 'csvHtml5',
                            text: '<i class="fa fa-file-text-o"></i>',
                            titleAttr: 'CSV',
                            title: 'Irish Literature Library'
                        },
                        {
                            extend: 'pdfHtml5',
                            text: '<i class="fa fa-file-pdf-o"></i>',
                            titleAttr: 'PDF',
                            title: 'Irish Literature Library',
                            customize: function (doc) {
                                content: [{
                                        alignment: 'justify',
                                        columns: [
                                            {width: 'auto'},
                                            {width: '*'},
                                            {width: '*'}
                                        ],
                                        table: {widths: ['auto', '*', '*']}
                                    }];
                            }
                        }
                    ],
//                    "bProcessing": '<i class="fa fa-spinner fa-spin fa-3x fa-fw"></i><span class="sr-only">Loading...</span>',
                    //  "bProcessing":  "<img src='/images/progress.gif'>",
                    "bServerSide": false,
                    "sAjaxSource": "./pendingApplicationDataServlet",
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
                        //    {"data": "ReferenceNumber"},

                        {"data": "company"},
                        {"data": "agreement",
                            "render": function (data, type, row) {

                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }}, {"data": "contract",
                            "render": function (data, type, row) {

                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "proposedDateOfPublication",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    console.log("date : proposedDateOfPublication" + date);
                                    var month = date.getMonth() + 1;
                                    console.log("date 2: proposedDateOfPublication " + date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear());
                                    return  date.getDate() + "/" + month + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "proposedPrintRun"},
                        {"data": "plannedPageExtent"},
                        {"data": "translatorCV",
                            "render": function (data, type, row) {

                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "numberOfPages"},
                        {"data": "breakDownTranslatorFee"},
                        {"data": "translatorFee",
                            "render": function (data, type, row) {
                                var mValue = parseFloat(0.00);
                                mValue = parseFloat(data);
                                if (mValue > 0) {
                                    //mValue = Math.round(mValue);                                             
                                    return mValue.toFixed(2);
                                } else
                                    return '-';
                                //  return data;
                            }
                        },
                        {"data": "bookNotes",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {

                                    return data;
                                }
                            }},
                        {"data": "Status"},
                        {"data": "copiesSent",
                            "render": function (data, type, row) {
                                // console.log("copiesSent " + data);
                                if (data === 0) {
                                    document.getElementById("copiesSent").checked = false;
                                    return 'No';
                                } else {
                                    document.getElementById("copiesSent").checked = true;
                                    return 'Yes';
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
                                //     console.log("copiesTranslationSample " + data);
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "TC_ACCEPTED",
                            "render": function (data, type, row) {
                                if (data === 0) {
                                    return 'No';
                                } else {
                                    return 'Yes';
                                }
                                ;
                            }},
                        {"data": "APPROVED",
                            "render": function (data, type, row) {
                                if (data === 0) {
                                    return 'No';
                                } else {

                                    return 'Yes';
                                }
                                ;
                            }},
                        {"data": "genre"},
                        {"data": "TranslatorName"},
//                        {"data": "expertReaderName"},
                        {"data": "bookTitle"},
//                        {"data": "translatorTitles"},
                        {"data": "Titles"},
//                        {"data": "translatorCVDocName"},
                        {"data": "cover",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    console.log("data : cover" + data);
                                    return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"></a>';
                                    //return data;
                                }
                            }},
                        {"data": "sampleSentOut",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "sampleReturned",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "readerReport",
                            "render": function (data, type, row) {
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        //                        {"data": "readerReportSummary"},
//                        {"data": "expertReaderList"},
//                        {"data": "unassignedExpertReaderList"},
                        {"data": "idTranslator"},
                        {"data": "publicationYear",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "originalLanguage",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    console.log("originalLanguage " + data);
                                    return data;
                                }
                            }},
                        {"data": "originalPageExtent",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "countryOfPublication",
                            "render": function (data) {
                                //             console.log("countryOfPublication " + data);
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "foreignPublisher",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "foreignCountry",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "targetLanguage",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "boardMeeting",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "amountRequested",
                            "render": function (data, type, row) {
                                var mValue = parseFloat(0.00);
                                mValue = parseFloat(data);
                                if (mValue > 0) {
                                    //mValue = Math.round(mValue);                                             
                                    return mValue.toFixed(2);
                                } else
                                    return '-';
                                // return data;
                            }
                        },
                        {"data": "amountApproved",
                            "render": function (data, type, row) {
                                var mValue = parseFloat(0.00);
                                mValue = parseFloat(data);
                                if (mValue > 0) {
                                    //mValue = Math.round(mValue);                                             
                                    return mValue.toFixed(2);
                                } else
                                    return '-';
                                // return data;
                            }
                        },
                        {"data": "publisherInformedOfMeeting",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "boardComments_Instructions",
                            "render": function (data) {
                                //                                console.log("boardComments_Instructions"  + data);
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "contractSentToPublisher",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "acknowledgementApproved",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "datePublishedBooksReceived",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "datePaymentMadeToPublisher",
                            "render": function (data) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    var date = new Date(data);
                                    var month = date.getMonth() + 1;
                                    return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                                }
                            }},
                        {"data": "paymentReferenceNumber",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "addendumRightsAgreement",
                            "render": function (data, type, row) {
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
//                        {"data": "addendumRightsAgreementName"},
                        {"data": "proofOfPaymentToTranslator",
                            "render": function (data, type, row) {
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
//                        {"data": "proofOfPaymentToTranslatorName"},
                        {"data": "bankDetailsForm",
                            "render": function (data, type, row) {
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
//                        {"data": "bankDetailsFormName"},
                        {"data": "SignedLIContract",
                            "render": function (data, type, row) {
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
//                        {"data": "SignedLIContractName"},
                        {"data": "paymentStatus",
                            "render": function (data, type, row) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                    return data;
                            }},
                        {"data": "previousGrantAid",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    return data;
                                }
                            }},
                        {"data": "award",
                            "render": function (data, type, row) {
                                return (data === 1) ? '<span class="glyphicon glyphicon-ok"></span>' : '<span class="glyphicon glyphicon-remove"></span>';
                            }
                        },
                        {"data": "salesFigures"},
                        {"data": "original",
                            "render": function (data, type, row) {
                                return '<a href="http://www.literatureirelandgrantapplication.com:8080' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
//                        {"data": "originalName"},
                        {"data": "Author"},
                        {"data": "publicationYear"},
                        {"data": "Series"},
                        {"data": "translationTitle"},
                        {"data": "transList",
                            "render": function (data, type, row) {

                                console.log("transList data" + data + " \n ");
                                return data;
                            }},
                        {"data": "rightsAgreement",
                            "render": function (data, type, row) {

                                console.log("rightsAgreement data  " + data + "\n");
                                return data;
                            }},
                        {"data": "ISBN",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    console.log("ISBN data  " + data + "\n");
                                    return data;
                                }
                            }},
                        {"data": "ISSN",
                            "render": function (data) {

                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                {
                                    console.log("ISSN data  " + data + "\n");
                                    return data;
                                }
                            }},
                        {"data": "idTranslator"}


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
//                $("#applications tbody").off("click").on("click", 'tr td.details-control', function (e) {
//                    alert("clicked");
////                });
                //     console.log("bookTitle " + bookTitle),
                //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                $('#additionalExpertReaderModal').empty(); // empty the div before fetching and adding new data

                $('#applications tbody').on('click', 'tr td.details-control', function (e) {
                    e.preventDefault();
                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#additionalExpertReaderModal').empty(); // empty the div before fetching and adding new data

                    cntr++;
                    var agreemnt = "";
                    var contr = "";
                    var transSamp = "";
                    var trans = "";
                    var cver = "";
                    var orig = "";
                    var addendumRightsAgreemnt = "";
                    var proofOfPaymentToTrans = "";
                    var bankDetailsFrm = "";
                    var signedLIContr = "";
                    var TranslName = "";
                    var bookTitles = "";
                    var TranslTitles = "";
                    var readerReport = "";
                    var tr = $(this).closest('tr');
                    var row = table.row(tr);
                    var rowdata = (table.row(tr).data());
                    var expertReaderName = "";
//                    var TranslatorDocs = rowdata.transList;
//                    console.log("1 TranslatorDocs rowdata.transList-> " + rowdata.transList);

//                    var awardValue = rowdata.award;
//                    console.log("awardValue:  " + awardValue);
//                    if (awardValue === 1) {
//                        document.getElementById("award").checked = true;
//                        console.log("awardValue:  TRUE");
//                    } else if (awardValue === 0) {
//                        document.getElementById("award").checked = false;
//                        console.log("awardValue:  FALSE");
//                    }

//                    var statii = rowdata.Status;
//                    if (statii === 'new') {
//
//                        document.getElementById("appStatus").style.backgroundColor = '#aefca1';
//                        document.getElementById("agreement").value = 'new';
//                    } else if (statii === 'pending') {
//
//                        document.getElementById("appStatus").style.backgroundColor = '#a1fcef';
//                        document.getElementById("agreement").value = 'pending';
//                    } else {
//
//                        document.getElementById("appStatus").style.backgroundColor = '#efa1fc';
//                        document.getElementById("agreement").value = 'closed';
//                    }
//                    ;
                    var agreemnt = 'href="http://www.literatureirelandgrantapplication.com:8080' + rowdata.agreement + '';
//                    $("#appAgreement").val(agreemnt);
//                    document.getElementById("agreement").href = agreemnt;

                    var orig = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.original + '';
//                   $("#appOriginal").val(orig);                                  
//                    document.getElementById("original").href = orig;
                    document.getElementById("originalSample1").href = orig;
                    var addendumRightsAgreemnt = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.addendumRightsAgreement + '';
                    $("#appAddendumRightsAgreement").val(addendumRightsAgreemnt);
//                    document.getElementById("addendum").href = addendumRightsAgreemnt;


                    if (typeof (rowdata.proofOfPaymentToTranslator) === "undefined" || rowdata.proofOfPaymentToTranslator === "") {

                        var proofOfPaymentToTrans = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.proofOfPaymentToTranslator + '';
                        $("#appProofPaymentToTranslator").val(proofOfPaymentToTrans);
//                        document.getElementById("proofPayment").href = proofOfPaymentToTrans;
                        $("#proofPaymentDiv1").show();
                        $("#proofPaymentDiv2").hide();
                    } else {
                        var proofOfPaymentToTrans = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.proofOfPaymentToTranslator + '';
                        $("#appProofPaymentToTranslator").val(proofOfPaymentToTrans);
                        document.getElementById("proofPayment_link").href = proofOfPaymentToTrans;
                        $("#proofPaymentDiv2").show();
                        $("#proofPaymentDiv1").hide();
                    }

                    if (typeof (rowdata.bankDetailsForm) === "undefined" || rowdata.bankDetailsForm === "") {
                        var bankDetailsFrm = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.bankDetailsForm + '';
                        $("#appBankDetailsForm").val(bankDetailsFrm);
//                        document.getElementById("bankDetailForm").href = bankDetailsFrm;
                        $("#bankDetailForm1").show();
                        $("#bankDetailForm2").hide();
                    } else {
                        var bankDetailsFrm = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.bankDetailsForm + '';
                        $("#appBankDetailsForm").val(bankDetailsFrm);
                        document.getElementById("bankDetailForm_link").href = bankDetailsFrm;
                        $("#bankDetailForm2").show();
                        $("#bankDetailForm1").hide();
                    }

                    if (typeof (rowdata.SignedLIContract) === "undefined" || rowdata.SignedLIContract === "") {
                        var signedLIContr = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.SignedLIContract + '';
                        $("#appSignedLIContract").val(signedLIContr);
//                        document.getElementById("signedLIcontract").href = signedLIContr;

                        $("#signedLIContract1").show();
                        $("#signedLIContract2").hide();
                    } else {
                        var signedLIContr = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.SignedLIContract + '';
                        $("#appSignedLIContract").val(signedLIContr);
                        document.getElementById("signedLIcontract_link").href = signedLIContr;
                        $("#signedLIContract2").show();
                        $("#signedLIContract1").hide();
                    }

                    if (typeof (rowdata.cover) === "undefined" || rowdata.cover === "") {

                        // no cover - show upload
                        var cver = '..images/not-available.jpg';
                        $("#showUploadCover1").show();
                        $("#showUploadCover2").hide();
//                        document.getElementById("cover21").src = cver;
                    } else {
                        // we have a cover - show cover
                        $("#showUploadCover2").show();
                        $("#showUploadCover1").hide();
                        var cver = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.cover + '';

                        $("#cover").val(cver);
                        console.log("81 xyz show bookCover cover " + bookCover);
                        console.log("81 xyz show Book cover for \n" + rowdata.translationTitle);
                        document.getElementById("cover21").src = cver;
                        document.getElementById("showUploadCoverTitle").innerHTML = "Book cover for \n" + rowdata.translationTitle;

                        bookTranslationTitle = rowdata.translationTitle;
                        console.log("81 xyz show Book bookTranslationTitle for \n" + bookTranslationTitle);
                    }



//                    var contr = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.contract + '';
//                    document.getElementById("contract").href = contr;
//
//                    var trans = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.translatorCV + '';
//                    document.getElementById("translatorCV").href = trans;
//
                    var transSamp = 'http://www.literatureirelandgrantapplication.com:8080' + rowdata.copiesTranslationSample + '';
                    document.getElementById("translationSample1").href = transSamp;
                    $("#applicationsModal").modal("show");
//                    $("#applications").DataTable().ajax.reload();
                    $("#appApplicationNumber").val($(this).closest('tr').children()[1].textContent);
                    $("#appApplicationYear").val($(this).closest('tr').children()[2].textContent);
                    $("#appReferenceNumber").val($(this).closest('tr').children()[3].textContent);
                    $("#appCompany").val($(this).closest('tr').children()[4].textContent);
//                    $("#appAgreement").val($(this).closest('tr').children()[5].textContent);

                    var appReferenceNumber = rowdata.ReferenceNumber;
                    document.getElementById("appReferenceNumber").innerHTML = appReferenceNumber;
                    document.getElementById("ReferenceNumber").value = appReferenceNumber;
                    //          console.log("appReferenceNumber " + appReferenceNumber);
                    $("#unassignedERRefNo").val(appReferenceNumber);
                    var TranslName = rowdata.TranslatorName;
                    //          console.log("TranslName " + TranslName);
                    $("#translatorNames").val(TranslName);
                    console.log("TranslatorName  ", TranslName.length);
                    var bookTitles = rowdata.Titles;
                    $("#currentItem").val(bookTitles.join(""));

                    console.log("8 xyz bookTitle: " + rowdata.bookTitle);
                    document.getElementById("bookTitle").value = rowdata.bookTitle;

                    if (typeof (rowdata.ISBN) === "undefined") {
                        var ISBN = 'n/a';
                        document.getElementById("isbn").readOnly = false;
                        document.getElementById("isbn").value = ISBN;
                    } else {
                        document.getElementById("isbn").readOnly = true;
                        document.getElementById("isbn").value = rowdata.ISBN;
                    }
                    if (typeof (rowdata.ISSN) === "undefined") {
                        var ISSN = 'n/a';
                        document.getElementById("isnn").readOnly = false;
                        document.getElementById("isnn").value = ISSN;
                    } else {
                        document.getElementById("isnn").readOnly = true;
                        document.getElementById("isnn").value = rowdata.ISSN;
                    }




                    var Authors = rowdata.Author;
                    document.getElementById("authors").value = rowdata.Author;
                    document.getElementById("authorArray").value = rowdata.Author;

                    document.getElementById("bookNotes").value = rowdata.bookNotes;
                    document.getElementById("originalPageExtent").value = rowdata.originalPageExtent;

                    languageArray = rowdata.targetLanguage;
                    console.log("languageArray  ", languageArray);


                    // Generate table translatorTrackTable
                    var TranslTitles = rowdata.translatorTitles;
//                    console.log("TranslTitles: " + translationTitle);
                    var TranslatorDocs = "";
                    var TranslatorDocs = [];
                    TranslatorDocs = rowdata.transList; //  .transList.values();
                    translatorArray = rowdata.transList;
                    console.log("8 xyz translatorArray  ", translatorArray);
                    $("#translatorArray").val(translatorArray);

                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#translatorTableDiv').empty(); // empty the div before fetching and adding new data
                    var docName = "";
                    var translatorTableDiv = document.getElementById("translatorTableDiv");
                    var tble = document.createElement('TABLE');
                    tble.id = 'TranslatorTable';
                    tble.border = '1';
                    tble.title = 'TranslatorTable';
                    tble.className = "table";
                    tble.style = 'width: auto;overflow-x: auto';
                    var tableBody = document.createElement('TBODY');
                    var header = document.createElement('thead');
                    header.style = 'font-weight: bold;';
                    var headingRow = document.createElement('tr');
                    var headingCell1 = document.createElement('td');
                    var headingText1 = document.createTextNode('Translator name');
                    headingCell1.appendChild(headingText1);
                    headingRow.appendChild(headingCell1);
                    var headingCell2 = document.createElement('td');
                    var headingText2 = document.createTextNode('Translator CV');
                    headingCell2.appendChild(headingText2);
                    headingRow.appendChild(headingCell2);
//                    var headingCell3 = document.createElement('td');
//                    var headingText3 = document.createTextNode('Translator translation sample');
//                    headingCell3.appendChild(headingText3);
//                    headingRow.appendChild(headingCell3);

                    header.appendChild(headingRow);
                    tble.appendChild(header);
                    var translatorNamesForGenerateTranslatorTab = [];
                    var translators = [];
                    for (var i = 0; i < TranslatorDocs.length; ++i) {
                        console.log("TranslatorDocs.length " + TranslatorDocs.length);
                        for (var j = 0; j < TranslatorDocs[i].length; ++j) {

                            // skip undefined values to preserve sparse array
                            if (TranslatorDocs[i][j] === undefined)
                                continue;
                            // create row if it doesn't exist yet
                            if (translators[j] === undefined)
                                translators[j] = [];
                            // swap the x and y coords for the copy
                            translators[i][j] = TranslatorDocs[i][j];
                            console.log("1 translators[" + j + "][" + i + "] " + translators[j][i]);
                        }
                    }

                    //TABLE ROWS
                    for (i = 0; i < translators.length; i++) {
                        var tr = document.createElement('TR');
                        for (j = 0; j < translators[i].length; j++) {
                            console.log("translators[i].length: " + translators[i].length);
                            console.log("translators[i]: " + translators[i]);
                            console.log("2 translators[i][j] " + translators[i][j]);
                            var td = document.createElement('TD');
                            if (i === 0) {
                                td.className = 'highlightHeader';
                            }
                            // remove "undefined" cells
                            if (typeof (translators[i][j]) === "undefined") {
                                translators[i][j] = '';
                            }

                            console.log("3 translators[i][j] " + translators[i][j]);
                            var nls = translators[i][j].split(",");
                            for (k = 0; k < nls.length; k++) {
                                console.log("1 nls [" + k + " ] " + nls[k]);
                            }
                            var newTranslatorName = nls[0];
                            newTranslatorName = newTranslatorName.substring(1);

                            console.log("newTranslatorName " + newTranslatorName);

                            translatorNamesForGenerateTranslatorTab.push(newTranslatorName);
                            console.log("translatorNamesForGenerateTranslatorTab " + translatorNamesForGenerateTranslatorTab);
                            for (o = 0; o < translatorNamesForGenerateTranslatorTab.length; o++) {
                                console.log("translatorNamesForGenerateTranslatorTab " + translatorNamesForGenerateTranslatorTab[o]);
                            }

                            for (l = 0; l < nls.length; l++) {
                                docName = "";
                                if (l === 0) {
                                    td = document.createElement('td');
                                    td.className = 'highlightHeader';
                                    var rep = nls[l].substr(1);
                                    console.log("rep [" + l + " ] " + rep);
                                    td.appendChild(document.createTextNode(rep));
                                    tr.appendChild(td);
                                } else if (l === 2) {
                                    td = document.createElement('td');
                                    var btn = document.createElement('input');
                                    btn.type = "button";
                                    btn.className = "btn btn-info";
                                    btn.value = nls[1].trim();
                                    var dir = nls[l].substr(1);
                                    var destination = dir.replace("/home/glassfish/glassfish/domains/domain1/docroot/documents", "/documents");
                                    console.log("destination " + destination);
                                    var entry = "location.href='http://www.literatureirelandgrantapplication.com:8080" + destination + "'";
                                    console.log("localhost " + entry);
                                    btn.setAttribute("onclick", entry);
                                    td.appendChild(btn);
                                    console.log("nls[l] [" + l + " ] " + nls[l]);
                                    td.appendChild(btn);
                                    tr.appendChild(td);
                                } else if (l === 3) {

                                    docName = nls[l].trim();
                                }

// Display translator translation sample
// 
//                                else if (l === 4) {
//                                    https://ilikekillnerds.com/2016/05/removing-character-startend-string-javascript/
//                                    Remove the last character
//                                    var myString = 'thisIsMyString!';
//                                    var sillyString = myString.slice(0, -1);

//
//                                    td = document.createElement('td');
//                                    var btn = document.createElement('input');
//                                    btn.type = "button";
//                                    btn.className = "btn btn-info";
//                                    btn.value = "Translator translation sample";
//
//                                    var dir = nls[l].substr(1);
//                                    var destination = dir.replace("/home/markus/public_html/", "/~markus/");
//                                    console.log("destination " + destination);
//
//                                    var entry = "location.href='http://www.literatureirelandgrantapplication.com:8080" + destination + "'";
//                                    console.log("localhost " + entry);
//
//                                    btn.setAttribute("onclick", entry);
//                                    td.appendChild(btn);
//                                    console.log("nls[l] [" + l + " ] " + nls[l]);
//                                    td.appendChild(btn);
//                                    tr.appendChild(td);
//                                }
                            }
                            tr.appendChild(td);
                            tableBody.appendChild(tr);
                            tr = document.createElement('tr');
                        }
                        tableBody.appendChild(tr);
                    }
                    tble.appendChild(tableBody);
                    translatorTableDiv.appendChild(tble);
                    var expertReaderName = rowdata.expertReaderList;
//                    console.log("expertReaderName:  " + expertReaderName);
//                    console.log("expertReaderName length:  " + expertReaderName.length);

//                    document.getElementById("unassignedERRefNo").value = appReferenceNumber;
//                    document.getElementById("NewAssignedERRefNo").value = appReferenceNumber;
                    /*
                     * get the whole List with the arrays  
                     * no of arrays = expertReaderName.length
                     */
                    //          alert(cntr);

                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#additionalExpertReader').empty(); // empty the div before fetching and adding new data


                    //Get all Expert Readers that are not assigned at the moment
                    var unassignedExpertReaderList = rowdata.unassignedExpertReaderList;
                    //           console.log(unassignedExpertReaderList.length);


//                    var select = document.getElementById("selectUnassignedER");
//                    // Optional: Clear all existing options first:
//                    select.innerHTML = "";
//                    // Populate list with options:
//                    var defaultSelect = "Select Expert Reader";
//                    //set default
//                    select.innerHTML += "<option value=\"" + defaultSelect + "\">" + defaultSelect + "</option>";
//                    for (var i = 0; i < unassignedExpertReaderList.length; i++) {
//                        var opt = unassignedExpertReaderList[i];
//                        select.innerHTML += "<option value=\"" + opt + "\">" + opt + "</option>";
//                    }


                    $('#tn').empty(); // empty the div before fetching and adding new data
                    $('#tnc').empty(); // empty the div before fetching and adding new data

                    // Generate Translator Tabs in "Rights Agreement & Contracts"-Tab

                    // 1: The Nav-Bar

                    var rightsAgreementContractsNavBar = '';
                    rightsAgreementContractsNavBar += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2" style="background-color: #d9d1d1">';
                    rightsAgreementContractsNavBar += '<ul class="nav navbar-nav nav-tabs">';
                    for (var i = 0; i < translators.length; i++) {

                        var j = i + 1;
                        if (i === 0) {

                            rightsAgreementContractsNavBar += '<li class="active"><a href="#tn' + j + '" data-toggle="tab">' + translatorNamesForGenerateTranslatorTab[i] + '</a></li>';
                        } else {

                            rightsAgreementContractsNavBar += '<li><a href="#tn' + j + '" data-toggle="tab">' + translatorNamesForGenerateTranslatorTab[i] + '</a></li>';
                        }
                    }

                    rightsAgreementContractsNavBar += '</ul>'; // ul class="nav navbar-nav nav-tabs"

                    rightsAgreementContractsNavBar += '</div>'; // navbar-collapse

                    $(rightsAgreementContractsNavBar).appendTo('#tn');



                    // The Tabs themselves

                    var rightsAgreementContractsNavContent = '';

                    for (var i = 0; i < translators.length; i++) {

                        var j = i + 1;

                        if (i === 0) {

                            rightsAgreementContractsNavContent += '<div class="tab-pane in active" id="tn' + j + '">';
                        } else {

                            rightsAgreementContractsNavContent += '<div class="tab-pane" id="tn' + j + '">';
                        }


                        rightsAgreementContractsNavContent += '<div class="container wrapperContainer">';

                        //Upload a copy of the agreement with the translation rights holder

                        rightsAgreementContractsNavContent += '<div class="row" style="margin-bottom: 80px;">';
                        rightsAgreementContractsNavContent += '<div style=" margin: 0 auto; position: relative;">';

                        rightsAgreementContractsNavContent += '<div class="col-md-9"  id="agreementToggle' + j + '" style="margin-bottom: 40px; position:absolute; z-index:0;">';
                        rightsAgreementContractsNavContent += '<div  style="margin-bottom: 10px;"><strong class="pull-left"  id="uploadAgreement' + j + '"></strong></div> ';
                        rightsAgreementContractsNavContent += '<br/>';
                        rightsAgreementContractsNavContent += '<div class="margin-bottom: 40px"></div>';
                        rightsAgreementContractsNavContent += '<div class="input-group agreement"  style="margin-bottom: 40px;">';
                        rightsAgreementContractsNavContent += '<label class="btn btn-default btn-file pull-left">';
                        rightsAgreementContractsNavContent += 'Select file <input type="file" onchange="generatedLabels()" name="Agreement-' + j + '" id="agreement' + j + '">';
                        rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-folder-open"></span>';
                        rightsAgreementContractsNavContent += '</label>';
                        rightsAgreementContractsNavContent += '<input id="label_agreement' + j + '" class="pull-left"/>';
                        rightsAgreementContractsNavContent += '<input type="hidden" value="Agreement" name="destination" id="agreement_upload' + j + '"/>';
                        rightsAgreementContractsNavContent += '</div>'; //<div class="input-group agreement" 
                        rightsAgreementContractsNavContent += '</div>'; //<div class="col-md-9" 

                        rightsAgreementContractsNavContent += '<div class="col-md-8" id="agreement_button' + j + '" style="margin-bottom: 40px; position:absolute; z-index:1; display:none;"> ';
                        rightsAgreementContractsNavContent += '<label  class="control-label pull-left" id="agreement_button_label' + j + '" ></label>';
                        rightsAgreementContractsNavContent += '<div class="input-group agreement_buttonText pull-left">';
                        rightsAgreementContractsNavContent += '<a class="btn btn-info btn-file pull-left" role="button" id="agreement_link' + j + '" href="">';
                        rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-file"></span>';
                        rightsAgreementContractsNavContent += 'Click to open</a>';
                        rightsAgreementContractsNavContent += '</div>';
                        rightsAgreementContractsNavContent += '</div>'; // -- col-md-10--


                        rightsAgreementContractsNavContent += '</div>'; //-- position:relative;--
                        rightsAgreementContractsNavContent += '</div>'; // row

                        //Upload a copy of the contract with translator

                        rightsAgreementContractsNavContent += '<div class="row" style="margin-bottom: 80px;">';
                        rightsAgreementContractsNavContent += '<div style=" margin: 0 auto; position: relative; ">';

                        rightsAgreementContractsNavContent += '<div class="col-md-9"  id="contractToggle' + j + '" style="margin-bottom: 40px; position:absolute; z-index:0;">';
                        rightsAgreementContractsNavContent += '<div  style="margin-bottom: 10px;"><strong class="pull-left"  id="uploadContract' + j + '"></strong></div>';
                        rightsAgreementContractsNavContent += '<br/>';
                        rightsAgreementContractsNavContent += '<div class="margin-bottom: 40px"></div>';
                        rightsAgreementContractsNavContent += '<div class="input-group contract"  style="margin-bottom: 40px;">';
                        rightsAgreementContractsNavContent += '<label class="btn btn-default btn-file pull-left">';
                        rightsAgreementContractsNavContent += 'Select file <input type="file" onchange="generatedLabels()" name="Contract-' + j + '" id="contract' + j + '">';
                        rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-folder-open"></span>';
                        rightsAgreementContractsNavContent += '</label>';
                        rightsAgreementContractsNavContent += '<input id="label_contract' + j + '" class="pull-left"/>';
                        rightsAgreementContractsNavContent += '<input type="hidden" value="Contract" name="destination" id="contract_upload' + j + '"/>';
                        rightsAgreementContractsNavContent += '</div>'; //<div class="input-group agreement" 
                        rightsAgreementContractsNavContent += '</div>'; //<div class="col-md-9" 

                        rightsAgreementContractsNavContent += '<div class="col-md-5" id="contract_button' + j + '" style="margin-bottom: 40px; position:absolute; z-index:1; display:none;"> ';
                        rightsAgreementContractsNavContent += '<label  class="control-label pull-left" id="contract_button_label' + j + '" ></label>';
                        rightsAgreementContractsNavContent += '<div class="input-group contract_buttonText pull-left">';
                        rightsAgreementContractsNavContent += '<a class="btn btn-info btn-file pull-left" role="button" id="contract_link' + j + '" href="">';
                        rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-file"></span>';
                        rightsAgreementContractsNavContent += 'Click to open</a>';
                        rightsAgreementContractsNavContent += '</div>';
                        rightsAgreementContractsNavContent += '</div>'; // -- col-md-10--


                        rightsAgreementContractsNavContent += '</div>'; //-- position:relative;--
                        rightsAgreementContractsNavContent += '</div>'; // row

                        //Upload form for addendum to the rights agreement

                        rightsAgreementContractsNavContent += '<div class="row" style="margin-bottom: 80px;">';
                        rightsAgreementContractsNavContent += '<div style=" margin: 0 auto; position: relative; ">';


                        rightsAgreementContractsNavContent += '<div class="col-md-9"  id="addendumToggle' + j + '"  style="margin-bottom: 40px; position:absolute; z-index:0; ">';
                        rightsAgreementContractsNavContent += '<div  style="margin-bottom: 10px;"><strong class="pull-left" id="uploadAddendum' + j + '" ></strong> <small class="pull-left"> &nbsp;  (where applicable)</small></div>';
                        rightsAgreementContractsNavContent += '<br/>';
                        rightsAgreementContractsNavContent += '<div class="margin-bottom: 40px"></div>';
                        rightsAgreementContractsNavContent += '<div class="input-group addendum"  style="margin-bottom: 40px;">';
                        rightsAgreementContractsNavContent += '<label class="btn btn-default btn-file pull-left">';
                        rightsAgreementContractsNavContent += 'Select file <input type="file" onchange="generatedLabels()" name="Addendum-' + j + '" id="addendum' + j + '">';
                        rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-folder-open"></span>';
                        rightsAgreementContractsNavContent += '</label>';
                        rightsAgreementContractsNavContent += '<input id="label_addendum' + j + '" class="pull-left"/>';
                        rightsAgreementContractsNavContent += '<input type="hidden" value="Addendum" name="destination" id="addendum_upload' + j + '"/>';
                        rightsAgreementContractsNavContent += '</div>'; //<div class="input-group agreement" 
                        rightsAgreementContractsNavContent += '</div>'; //<div class="col-md-12" 

                        rightsAgreementContractsNavContent += '<div class="col-md-8" id="addendum_button' + j + '"  style="margin-bottom: 40px; position:absolute;z-index:1; display:none;">  ';
                        rightsAgreementContractsNavContent += '<label  class="control-label pull-left" id="addendum_button_label' + j + '" ></label>';
                        rightsAgreementContractsNavContent += '<div class="input-group addendum_buttonText pull-left" style="width: 190px; hight: 34px" >';
                        rightsAgreementContractsNavContent += '<a class="btn btn-info btn-file pull-left" role="button" id="addendum_link' + j + '" href="">';
                        rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-file"></span>';
                        rightsAgreementContractsNavContent += 'Click to open</a>';
                        rightsAgreementContractsNavContent += '</div>';
                        rightsAgreementContractsNavContent += '</div>'; // -- col-md-5--


                        rightsAgreementContractsNavContent += '</div>'; //-- position:relative;--
                        rightsAgreementContractsNavContent += '</div>'; // row

                        rightsAgreementContractsNavContent += '</div>';  //  --container--
                        rightsAgreementContractsNavContent += '</div>'; //<div class="tab-pane"
                    }

                    $(rightsAgreementContractsNavContent).appendTo('#tnc');


                    //Fill the tabs


                    var w = 1;
                    for (var j = 0; j < rowdata.rightsAgreement.length; j++) {
                        var rightsAgreementArray = rowdata.rightsAgreement[j].split(",");
                        for (var v = 0; v < rightsAgreementArray.length; v++) {

                            switch (v) {
                                case 0:
                                    // Agreement

                                    if (rightsAgreementArray[v].substr(1) !== 'null') {
                                        console.log("8 xyz case 0  [" + j + "]");
                                        console.log("8 xyz  rightsAgreementArray  :", rightsAgreementArray[v].substr(1) + ":");
                                        document.getElementById('agreement_link' + w).href = "http://www.literatureirelandgrantapplication.com:8080" + rightsAgreementArray[v].substr(1) + " ";
                                    }
                                    break;
                                case 1:
                                    // AgreementDocName
                                    console.log("8 xyz case 1 [" + j + "]");
                                    if (rightsAgreementArray[v].substr(1) === 'null') {
                                        console.log("8 xyz  ", translatorNamesForGenerateTranslatorTab[j]);
                                        document.getElementById('uploadAgreement' + w).innerHTML = 'Upload a copy of the agreement with ' + translatorNamesForGenerateTranslatorTab[j];
                                        document.getElementById('label_agreement' + w).value = "not entered";

                                    } else {
                                        console.log("8 xyz case 1 toggle ");
                                        $('#agreementToggle' + w).toggle();
                                        $('#agreement_button' + w).toggle();

                                        document.getElementById("agreement_button_label" + w).innerHTML = 'Open copy of the agreement with the translation rights holder' + translatorNamesForGenerateTranslatorTab[j];

                                    }
                                    break;
                                case 2:
                                    // Contract

                                    if (rightsAgreementArray[v].substr(1) !== 'null') {

                                        document.getElementById('contract_link' + w).href = "http://www.literatureirelandgrantapplication.com:8080" + rightsAgreementArray[v].substr(1) + " ";
                                    }
                                    break;
                                case 3:
                                    // ContractDocName

                                    if (rightsAgreementArray[v].substr(1) === 'null') {

                                        document.getElementById('label_contract' + w).value = "not entered";
                                        document.getElementById('uploadContract' + w).innerHTML = 'Upload a copy of the contract with ' + translatorNamesForGenerateTranslatorTab[j];

                                    } else {

                                        $('#contractToggle' + w).toggle();
                                        $('#contract_button' + w).toggle();

                                        document.getElementById("contract_button_label" + w).innerHTML = 'Open copy of the contract with ' + translatorNamesForGenerateTranslatorTab[j];

                                    }
                                    break;
                                case 4:
                                    // AddendumRightsAgreement

                                    if (rightsAgreementArray[v].substr(1) !== 'null') {

                                        document.getElementById('addendum_link' + w).href = "http://www.literatureirelandgrantapplication.com:8080" + rightsAgreementArray[v].substr(1) + " ";
                                    }
                                    break;
                                case 5:
                                    // AddendumRightsAgreementName

                                    if (rightsAgreementArray[v].slice(0, -1) === 'null') {

                                        document.getElementById('label_addendum' + w).value = "not entered";
                                        document.getElementById('uploadAddendum' + w).innerHTML = 'Upload a copy of the addendum to the rights agreement ' + translatorNamesForGenerateTranslatorTab[j];

                                    } else {

                                        $('#addendumToggle' + w).toggle();
                                        $('#addendum_button' + w).toggle();

                                        document.getElementById("addendum_button_label" + w).innerHTML = 'Open copy of the addendum to the rights agreement with ' + translatorNamesForGenerateTranslatorTab[j];
                                    }
                                    break;
                            }
                        }
                        w++;  // next translator
                    }


                    $("#appcontract").val(contr);
                    $("#proposedDateOfPublication").val($(this).closest('tr').children()[7].textContent);
                    $("#appproposedPrintRun").val($(this).closest('tr').children()[8].textContent);
                    $("#plannedPageExtent").val($(this).closest('tr').children()[9].textContent);
                    $("#appnumberOfPages").val($(this).closest('tr').children()[11].textContent);
                    $("#breakDownTranslatorFee").val($(this).closest('tr').children()[12].textContent);
                    $("#translatorFee").val($(this).closest('tr').children()[13].textContent);
                    $("#bookNotes").val($(this).closest('tr').children()[14].textContent);
                    $("#appStatus").val($(this).closest('tr').children()[15].textContent);
                    $("#copiesSent").val($(this).closest('tr').children()[16].textContent);
                    $("#dateCopiesWereSent").val($(this).closest('tr').children()[17].textContent);
//                    $("#copiesTranslationSample").val($(this).closest('tr').children()[18].textContent);
                    $("#appTC_ACCEPTED").val($(this).closest('tr').children()[19].textContent);
                    $("#appAPPROVED").val($(this).closest('tr').children()[20].textContent);
                    $("#appGenre").val($(this).closest('tr').children()[21].textContent);
                    $("#TranslatorName").val($(this).closest('tr').children()[22].textContent);
                    $("#appBookTitle").val($(this).closest('tr').children()[23].textContent);

                    $("#cover").val($(this).closest('tr').children()[25].textContent);

                    $("#sampleSentOut").val($(this).closest('tr').children()[29].textContent);
                    $("#sampleReturned").val($(this).closest('tr').children()[30].textContent);
                    $("#appLanguageOriginal").val($(this).closest('tr').children()[31].textContent);
                    $("#originalPageExtent").val($(this).closest('tr').children()[32].textContent);
                    $("#appCountryOfPublication").val($(this).closest('tr').children()[33].textContent);
                    $("#appForeignCountry").val($(this).closest('tr').children()[33].textContent);
                    $("#appForeignPublisher").val($(this).closest('tr').children()[34].textContent);
//                  $("#appDateOfPublicationOriginal").val($(this).closest('tr').children()[35].textContent);
                    $("#publicationYear1").val($(this).closest('tr').children()[35].textContent);
                    $("#languages").val($(this).closest('tr').children()[36].textContent);
//                    $("#appLanguageOriginal").val($(this).closest('tr').children()[36].textContent);
//                    $("#originalPageExtent").val($(this).closest('tr').children()[37].textContent);
                    $("#amountRequested").val($(this).closest('tr').children()[38].textContent);
                    $("#amountApproved").val($(this).closest('tr').children()[39].textContent);
                    $("#foreignPublisher").val($(this).closest('tr').children()[34].textContent);
                    $("#publisherInformedOfMeetingn").val($(this).closest('tr').children()[40].textContent);
                    $("#appTargetLanguage").val($(this).closest('tr').children()[36].textContent);
                    $("#acknowledgementApproved").val($(this).closest('tr').children()[43].textContent);
//                    $("#award").val($(this).closest('tr').children()[62].textContent);
//                    $("#salesFigures").val($(this).closest('tr').children()[63].textContent);
//                    $("#authors").val($(this).closest('tr').children()[66].textContent);
                    $("#publicationYear1").val($(this).closest('tr').children()[57].textContent);
                    $("#series").val($(this).closest('tr').children()[58].textContent);
                    $("#translationTitle").val($(this).closest('tr').children()[59].textContent);
//                    $("#isbn").val($(this).closest('tr').children()[62].textContent);
//                    $("#issn").val($(this).closest('tr').children()[63].textContent);
                    //                  console.log(table.row(this).data());


                    console.log("12345  1 ApplicationNumber " + $(this).closest('tr').children()[1].textContent);
                    console.log("12345  2 ApplicationYear " + $(this).closest('tr').children()[2].textContent);
                    console.log("12345  3 ReferenceNumber " + $(this).closest('tr').children()[3].textContent);
                    console.log("12345  4 company " + $(this).closest('tr').children()[4].textContent);
                    console.log("12345  5 agreement " + $(this).closest('tr').children()[5].textContent);
                    console.log("12345  6 contract " + $(this).closest('tr').children()[6].textContent);
                    console.log("12345  7 proposedDateOfPublication " + $(this).closest('tr').children()[7].textContent);
                    console.log("12345  8 appproposedPrintRun " + $(this).closest('tr').children()[8].textContent);
                    console.log("12345  9 plannedPageExtent " + $(this).closest('tr').children()[9].textContent);
                    console.log("12345 10 translatorCV " + $(this).closest('tr').children()[10].textContent);

                    console.log("12345 11 appnumberOfPages " + $(this).closest('tr').children()[11].textContent);
                    console.log("12345 12 breakDownTranslatorFee " + $(this).closest('tr').children()[12].textContent);
                    console.log("12345 13 translatorFee " + $(this).closest('tr').children()[13].textContent);
                    console.log("12345 14 bookNotes " + $(this).closest('tr').children()[14].textContent);
                    console.log("12345 15 appStatus " + $(this).closest('tr').children()[15].textContent);
                    console.log("12345 16 copiesSent " + $(this).closest('tr').children()[16].textContent);
                    console.log("12345 17 dateCopiesWereSent " + $(this).closest('tr').children()[17].textContent);
                    console.log("12345 18 copiesTranslationSample " + $(this).closest('tr').children()[18].textContent);
                    console.log("12345 19 appTC_ACCEPTED " + $(this).closest('tr').children()[19].textContent);
                    console.log("12345 20 appAPPROVED " + $(this).closest('tr').children()[20].textContent);

                    console.log("12345 21 appGenre " + $(this).closest('tr').children()[21].textContent);
                    console.log("12345 22 TranslatorName " + $(this).closest('tr').children()[22].textContent);
                    console.log("12345 23 bookTitle " + $(this).closest('tr').children()[23].textContent);
                    console.log("12345 24 Titles " + $(this).closest('tr').children()[24].textContent);
                    console.log("12345 25 cover " + $(this).closest('tr').children()[25].textContent);
                    console.log("12345 26 sampleSentOut " + $(this).closest('tr').children()[26].textContent);
                    console.log("12345 27 sampleReturned " + $(this).closest('tr').children()[27].textContent);
                    console.log("12345 28 readerReport " + $(this).closest('tr').children()[28].textContent);
                    console.log("12345 29 idTranslator " + $(this).closest('tr').children()[29].textContent);
                    console.log("12345 30 publicationYear " + $(this).closest('tr').children()[30].textContent);

                    console.log("12345 31 appLanguageOriginal " + $(this).closest('tr').children()[31].textContent);
                    console.log("12345 32 originalPageExtent " + $(this).closest('tr').children()[32].textContent);
                    console.log("12345 33 countryOfPublication / appForeignCountry " + $(this).closest('tr').children()[33].textContent);
                    console.log("12345 34 foreignPublisher / appForeignPublisher " + $(this).closest('tr').children()[34].textContent);
                    console.log("12345 35 publicationYear1 " + $(this).closest('tr').children()[35].textContent);
                    console.log("12345 36 languages / appTargetLanguage " + $(this).closest('tr').children()[36].textContent);
                    console.log("12345 37 ???? " + $(this).closest('tr').children()[37].textContent);
                    console.log("12345 38 amountRequested " + $(this).closest('tr').children()[38].textContent);
                    console.log("12345 39 amountApproved " + $(this).closest('tr').children()[39].textContent);
                    console.log("12345 40 publisherInformedOfMeeting" + $(this).closest('tr').children()[40].textContent);


                    console.log("12345 41 boardComments_Instructions " + $(this).closest('tr').children()[41].textContent);
                    console.log("12345 42 contractSentToPublisher " + $(this).closest('tr').children()[42].textContent);
                    console.log("12345 43 acknowledgementApproved " + $(this).closest('tr').children()[43].textContent);
                    console.log("12345 44 datePublishedBooksReceived " + $(this).closest('tr').children()[44].textContent);
                    console.log("12345 45 datePaymentMadeToPublisher " + $(this).closest('tr').children()[45].textContent);
                    console.log("12345 46 paymentReferenceNumber " + $(this).closest('tr').children()[46].textContent);
                    console.log("12345 47 addendumRightsAgreement " + $(this).closest('tr').children()[47].textContent);
                    console.log("12345 48 proofOfPaymentToTranslator " + $(this).closest('tr').children()[48].textContent);
                    console.log("12345 49 bankDetailsForm " + $(this).closest('tr').children()[49].textContent);
                    console.log("12345 50 SignedLIContract " + $(this).closest('tr').children()[50].textContent);

                    console.log("12345 51 paymentStatus " + $(this).closest('tr').children()[51].textContent);
                    console.log("12345 52 previousGrantAid " + $(this).closest('tr').children()[52].textContent);
                    console.log("12345 53 award " + $(this).closest('tr').children()[53].textContent);
                    console.log("12345 54 salesFigures " + $(this).closest('tr').children()[54].textContent);
                    console.log("12345 55 original " + $(this).closest('tr').children()[55].textContent);
                    console.log("12345 56 Author " + $(this).closest('tr').children()[56].textContent);
                    console.log("12345 57 publicationYear1 " + $(this).closest('tr').children()[57].textContent);
                    console.log("12345 58 Series " + $(this).closest('tr').children()[58].textContent);
                    console.log("12345 59 translationTitle " + $(this).closest('tr').children()[59].textContent);
                    console.log("12345 60 transList " + $(this).closest('tr').children()[60].textContent);
                    console.log("12345 61 " + $(this).closest('tr').children()[61].textContent);
                    console.log("12345 62 ISBN " + $(this).closest('tr').children()[62].textContent);
                    console.log("12345 63 ISSN " + $(this).closest('tr').children()[63].textContent);
//                    console.log("12345 64 " + $(this).closest('tr').children()[64].textContent);
//                    console.log("12345 65 " + $(this).closest('tr').children()[65].textContent);
//                    console.log("12345 66 authors " + $(this).closest('tr').children()[66].textContent);
//                    console.log("12345 67 publicationYear " + $(this).closest('tr').children()[67].textContent);
//                    console.log("12345 68 series " + $(this).closest('tr').children()[68].textContent);
//                    console.log("12345 69 translationTitle " + $(this).closest('tr').children()[69].textContent);
//                    console.log("12345 70 " + $(this).closest('tr').children()[70].textContent);

//                    console.log("12345 71 " + $(this).closest('tr').children()[71].textContent);
//                    console.log("12345 72 " + $(this).closest('tr').children()[72].textContent);
//                    console.log("12345 73 " + $(this).closest('tr').children()[72].textContent);
                    console.log("generateTranslatorTab translatorArray " + translators.length);

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
            // Returns if a value is an array
            function isArray(value) {
                return value && typeof value === 'object' && value.constructor === Array;
            }
            function hasEmptyElement(array) {
                for (var i = 0; i < array.length; i++) {
                    if (typeof array[i] === 'undefined') {
                        return true;
                        // and then ?
                        // should I use double for loop or helper variable?
                    }
                }
            }
        </script>

        <!-- the following functions will copy
     the selected file name (for upload) to the label input-->
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
                $('div.addendum').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_addendum").value = label;
                });
            });
            $(function () {
                $('div.translator_cv').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
//                  var label_translatorid2 = "label_translator" + id2;
                    document.getElementById("label_translator0").value = label;
                });
            });
            $(function () {
                $(document).on('change', 'div.translatorcv :file', function () {

                    var id = parseInt(this.id.replace("translator_cv", ""));
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    var label_translatorid = "label_translator" + id;
                    document.getElementById(label_translatorid).value = label;
                });
            });
            $(function () {
                $('div.originalSample').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_originalSample").value = label;
                });
            });
            $(function () {
                $('div.translationSample').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_translationSample").value = label;
                });
            });
            $(function () {
                $('div.cover').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    alert("Cover " + label);
                    document.getElementById("label_cover").value = label;
                });
            });
            $(function () {
                $('div.proofPayment').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_proofPayment").value = label;
                });
            });
            $(function () {
                $('div.bankDetailForm').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_BankDetailForm").value = label;
                });
            });
            $(function () {
                $('div.signedLIcontract').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_signedLIcontract").value = label;
                });
            });

            function generatedLabels() {
                $(document).on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    var id = input[0].id;
                    var label_id = "label_" + id;
                    document.getElementById(label_id).value = label;
                });
            }


            function storeImage() {
                // Get Content
                var uploadCoverContent = document.getElementById("showUploadCover1").innerHTML;

                bookCover = 'http://www.literatureirelandgrantapplication.com:8080' + bookCover + '';
                $("#cover").val(bookCover);
                console.log("8 xyz storeImage Cover cover " + bookCover);

                console.log("8 xyz storeImage Book cover for \n" + bookTranslationTitle);
                document.getElementById("cover21").src = bookCover;
                document.getElementById("showUploadCoverTitle").innerHTML = "Book cover for \n" + bookTranslationTitle;

                // Store Content
                localStorage.setItem("uploadCoverContent", uploadCoverContent);

                console.log("storeImage localStorage.uploadCoverContent ", localStorage.uploadCoverContent.length);
                if (!localStorage.uploadCoverContent === 0) {
                    console.log("storeImage uploadCoverContent " + uploadCoverContent);
                    for (i = 0; i < uploadCoverContent.length; i++) {
                        console.log("storeImage uploadCoverContent " + uploadCoverContent[i]);
                    }
//                    alert("backToTranslators false");
//                    return false;
                }

            }
        </script>

        <!--add more Translators-->
        <script type="text/javascript">
            $(document).ready(function () {
                counter = 1;
                $("#addElement").click(function (event) {
                    counter++;
                    var $newDiv = $("<div class='input-group' style='margin-bottom :2px'>" + counter + ". Translator  </div>");
                    var $newInput = $("<input placeholder='Translator Name' type='text'> ");
                    $newInput
                            .attr("name", "Name" + counter)
                            .attr("id", "name" + counter)
                            .addClass("text wsp");
                    $newInput.appendTo($newDiv);
                    $newDiv.appendTo($("#generatedForm"));
                });
            });
        </script>

        <script>
            // Copy the first translator name to the pop up modal
            function  copyFirstTranslatorName() {

                var fn = document.getElementById("translatorName");
                document.getElementById("first0").value = fn.value;
                Name = fn.value;
                translatorArray.push(Name);
                console.log(" first entry in translatorArray ", fn.value);
                if (!localStorage.translatorContent === 0) {
                    //function retrieve(){
                    document.getElementById("torget").innerHTML = localStorage.getItem("translatorContent");
                    console.log("backToTranslators localStorage.translatorContent ", localStorage.translatorContent.length);
                    for (i = 0; i < translatorContent.length; i++) {
                        console.log("restored translatorContent " + translatorContent);
                    }
                }
            }

        </script>

        <script>
            function backToTranslators() {
                var upload_number = 2;
                // Get Content
                var translatorContent = document.getElementById("translatorTableDiv").innerHTML;
                var coverageCuttingsContent = document.getElementById("result").innerHTML;
                // Store Content
                localStorage.setItem("translatorContent", translatorContent);
                localStorage.setItem("coverageCuttingsContent", coverageCuttingsContent);

                console.log("backToTranslators localStorage.coverageCuttingsContent length ", localStorage.coverageCuttingsContent.length);
                if (!localStorage.coverageCuttingsContent === 0) {
                    console.log("backToTranslators coverageCuttingsContent " + coverageCuttingsContent);
                    for (i = 0; i < coverageCuttingsContent.length; i++) {
                        console.log("backToTranslators coverageCuttingsContent " + coverageCuttingsContent[i]);
                    }
//                    alert("backToTranslators false");
//                    return false;
                }

//                var test1 = document.getElementById("result");
//                console.log("test1 length  " + test1.length);
//                for (var z = 0; z < test1.length; z++) {
//
//                    console.log("test1 [" + z + "]  " + test1[z].value);
//                }



                for (var i = 2; i <= counter; i++) {

                    var nr = "name" + i;
                    var item = document.getElementById(nr);
                    itemValue = item.value;
                    translatorArray.push(itemValue);
                    console.log("backToTranslators next entry in translatorArray ", itemValue);
                    var moreUploadTag = '';
                    moreUploadTag += '<div class="col-md-8" style="margin-bottom: 20px">';
                    moreUploadTag += '<label for="label_translator' + upload_number + '" class="control-label pull-left" id="123">Upload a copy of ' + itemValue + '\'s CV: </label>';
                    moreUploadTag += '<br>';
                    moreUploadTag += ' <small class="pull-left" style="margin-bottom: 10px">this should include a list of previous published literary translations</small>';
                    moreUploadTag += '<div class="input-group translatorcv pull-left" style="margin-bottom: 40px;">';
                    moreUploadTag += '<label class="btn btn-default btn-file pull-left">';
                    moreUploadTag += 'Select file ';
                    moreUploadTag += '<input multiple="" name="file" id="translator_cv' + upload_number + '" type="file">';
                    moreUploadTag += '<span class="glyphicon glyphicon-folder-open"></span>';
                    moreUploadTag += '</label>';
                    moreUploadTag += '<input id="label_translator' + upload_number + '" class="pull-left">';
                    moreUploadTag += '<br>';
                    moreUploadTag += '<br>';
                    moreUploadTag += '<input id="translator_cv_upload' + upload_number + '" value="Translator_CV" name="destination" type="hidden">';
                    moreUploadTag += '</div>';
                    moreUploadTag += '</div>';
                    $(moreUploadTag).appendTo('#additionalTranslator');
                    upload_number++;
                }

//                $('#bs-example-navbar-collapse-1 a[href="#Drawdown"]').tab('show');
//                $('#addTranslatorModalDiv').toggle();
////                Change Title from "Translator" to "Translators"
//                document.getElementById("translatorNameLabel").innerHTML = 'Translators';
//                Disable first Translator input element
//                document.getElementById("translatorName").readonly = 'true';
//                Display all Translators in input element each
                for (var i = 1; i < translatorArray.length; i++) {
                    console.log("backToTranslators translatorArray " + translatorArray[i]);
                    var additionalTranslatorTag = '';
                    additionalTranslatorTag += '<div class="form-group has-feedback">';
                    additionalTranslatorTag += ' <input id="translatorName"  ';
                    additionalTranslatorTag += 'type="text"  ';
                    additionalTranslatorTag += 'class="form-control"';
                    additionalTranslatorTag += 'name="translatorName"';
                    additionalTranslatorTag += 'value="' + translatorArray[i] + '"';
                    additionalTranslatorTag += 'readonly = true';
                    additionalTranslatorTag += '</div>';
                    $(additionalTranslatorTag).appendTo('#addTransl');
                }

                var rightsAgreementContractsNavBar = '';
                rightsAgreementContractsNavBar += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2" style="background-color: #d9d1d1">';
                rightsAgreementContractsNavBar += '<ul class="nav navbar-nav nav-tabs">';
                for (var i = 0; i < translatorArray.length; i++) {

                    var j = i + 1;
                    if (i === 0) {

                        rightsAgreementContractsNavBar += '<li class="active"><a href="#tn' + j + '" data-toggle="tab">' + translatorArray[i] + '</a></li>';
                    } else {

                        rightsAgreementContractsNavBar += '<li><a href="#tn' + j + '" data-toggle="tab">' + translatorArray[i] + '</a></li>';
                    }
                }

                rightsAgreementContractsNavBar += '</ul>'; // ul class="nav navbar-nav nav-tabs"

                rightsAgreementContractsNavBar += '</div>'; // navbar-collapse

//                $(rightsAgreementContractsNavBar).appendTo('#tn');
                var rightsAgreementContractsNavContent = '';

                for (var i = 0; i < translatorArray.length; i++) {

                    var j = i + 1;
                    if (i === 0) {

                        rightsAgreementContractsNavContent += '<div class="tab-pane in active" id="tn' + j + '">';
                    } else {

                        rightsAgreementContractsNavContent += '<div class="tab-pane" id="tn' + j + '">';
                    }

                    //  --container--
                    rightsAgreementContractsNavContent += '<div class="container wrapperContainer">';
                    //Upload a copy of the agreement with the translation rights holder

                    rightsAgreementContractsNavContent += '<div class="col-md-10"   style="margin-bottom: 10px">';
                    rightsAgreementContractsNavContent += '<div  style="margin-bottom: 40px;margin-top: 30px"> <strong class="pull-left">Upload a copy of the agreement with the translation rights holder' + j + '</strong> <small class="pull-left"> &nbsp;  (where applicable)</small> </div>';
                    rightsAgreementContractsNavContent += '<br/>';
                    rightsAgreementContractsNavContent += '<div class="margin-bottom: 40px"></div>';
                    rightsAgreementContractsNavContent += '<div class="input-group agreement"  style="margin-bottom: 40px;">';
                    rightsAgreementContractsNavContent += '<label class="btn btn-default btn-file pull-left">';
                    rightsAgreementContractsNavContent += 'Select file <input type="file"  name="file" id="agreement' + j + '">';
                    rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-folder-open"></span>';
                    rightsAgreementContractsNavContent += '</label>';
                    rightsAgreementContractsNavContent += '<input id="label_agreement' + j + '" class="pull-left"/>';
                    rightsAgreementContractsNavContent += '<input type="hidden" value="Agreement" name="destination" id="agreement_upload' + j + '"/>';
                    rightsAgreementContractsNavContent += '</div>'; //<div class="input-group agreement" 
                    rightsAgreementContractsNavContent += '</div>'; //<div class="col-md-10" 


                    //Upload a copy of the contract with

                    rightsAgreementContractsNavContent += '<div class="col-md-9" style="margin-bottom: 10px">';
                    rightsAgreementContractsNavContent += '<div  style="margin-bottom: 10px;"><strong class="pull-left">Upload a copy of the contract with ' + translatorArray[i] + '</strong></div>';
                    rightsAgreementContractsNavContent += '<br/>';
                    rightsAgreementContractsNavContent += '<div class="margin-bottom: 40px"></div>';
                    rightsAgreementContractsNavContent += '<div class="input-group contract"  style="margin-bottom: 40px;">';
                    rightsAgreementContractsNavContent += '<label class="btn btn-default btn-file pull-left">';
                    rightsAgreementContractsNavContent += 'Select file <input type="file"  name="file" id="contract' + j + '">';
                    rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-folder-open"></span>';
                    rightsAgreementContractsNavContent += '</label>';
                    rightsAgreementContractsNavContent += '<input id="label_contract' + j + '" class="pull-left"/>';
                    rightsAgreementContractsNavContent += '<input type="hidden" value="Contract" name="destination" id="contract_upload' + j + '"/>';
                    rightsAgreementContractsNavContent += '</div>'; //<div class="input-group agreement" 
                    rightsAgreementContractsNavContent += '</div>'; //<div class="col-md-9" 


                    //Upload form for addendum to the rights agreement

                    rightsAgreementContractsNavContent += '<div class="col-md-12" style="margin-bottom: 10px">';
                    rightsAgreementContractsNavContent += '<div  style="margin-bottom: 10px;"><strong class="pull-left">Upload a copy of the addendum to the rights agreement ' + translatorArray[i] + '</strong> <small class="pull-left"> &nbsp;  (where applicable)</small></div>';
                    rightsAgreementContractsNavContent += '<br/>';
                    rightsAgreementContractsNavContent += '<div class="margin-bottom: 40px"></div>';
                    rightsAgreementContractsNavContent += '<div class="input-group addendum"  style="margin-bottom: 40px;">';
                    rightsAgreementContractsNavContent += '<label class="btn btn-default btn-file pull-left">';
                    rightsAgreementContractsNavContent += 'Select file <input type="file"  name="file" id="addendum' + j + '">';
                    rightsAgreementContractsNavContent += '<span class="glyphicon glyphicon-folder-open"></span>';
                    rightsAgreementContractsNavContent += '</label>';
                    rightsAgreementContractsNavContent += '<input id="label_addendum' + j + '" class="pull-left"/>';
                    rightsAgreementContractsNavContent += '<input type="hidden" value="Contract" name="destination" id="addendum_upload' + j + '"/>';
                    rightsAgreementContractsNavContent += '</div>'; //<div class="input-group agreement" 
                    rightsAgreementContractsNavContent += '</div>'; //<div class="col-md-12" 

                    rightsAgreementContractsNavContent += '</div  class="container EndwrapperContainer">'; // <!--container-->
                    rightsAgreementContractsNavContent += '</div>'; //<div class="tab-pane"
                }

//                $(rightsAgreementContractsNavContent).appendTo('#tnc');
                $("#translatorArray").val(translatorArray);

            }
        </script>

        <script>
            //managing stacked modals
            //https://stackoverflow.com/questions/28077066/bootstrap-modal-issue-scrolling-gets-disabled
            $(document).ready(function () {
                $('.btn[data-toggle=modal]').on('click', function () {

                    var $btn = $(this);
                    var currentDialog = $btn.closest('.modal-dialog'),
                            targetDialog = $($btn.attr('data-target'));
                    if (!currentDialog.length)
                        return;
                    targetDialog.data('previous-dialog', currentDialog);
                    currentDialog.addClass('aside');
                    var stackedDialogCount = $('.modal.in .modal-dialog.aside').length;
                    if (stackedDialogCount <= 5) {
                        currentDialog.addClass('aside-' + stackedDialogCount);
                    }

                });

                $('.modal').on('hidden.bs.modal', function () {

                    var $dialog = $(this);
                    var previousDialog = $dialog.data('previous-dialog');
                    var Dialogindex = $dialog.data('modal-index');
                    if (previousDialog) {
                        previousDialog.removeClass('aside');
                        $dialog.data('previous-dialog', undefined);

                    }
                    if (Dialogindex) {
                        if ($('.modal:visible').length) {
                            $('body').addClass('modal-open');
                        }
                        $('body').css('overflow-y', '');
                    } else {
                        $('body').css('overflow-y', 'hidden');
                    }
                    if (Dialogindex) {
                        if ($('.modal:visible').length) {
                            $('body').addClass('modal-open');
                        }
                        $('body').css('overflow-y', '');
                    } else {
                        $('body').css('overflow-y', 'hidden');
                    }
                });
            });
        </script>

        <script>
            var fileTypes = [
                'image/jpeg',
                'image/pjpeg',
                'image/png',
                'image/*',
                'application/pdf',
                '.doc,.docx,.xml,.pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document'

            ];
            function validFileType(file) {
                for (var i = 0; i < fileTypes.length; i++) {
                    if (file.type === fileTypes[i]) {
                        return true;
                    }
                }

                return false;
            }
        </script>

        <script>
            window.onload = function () {
                //Check File API support
                if (window.File && window.FileList && window.FileReader)
                {
                    $('#files').on("change", function (event) {
                        var files = event.target.files; //FileList object
                        var output = document.getElementById("result");
//                        console.log(" output " + output);

//                        const keys = Object.keys(output);
//                        console.log(keys); // [apple, orange, pear]
//                        const values = Object.values(output);
//                        console.log(values); // [28, 17, 54]
//                        const entries = Object.entries(output);
//                        console.log(entries);
                        // [
                        //   [apple, 28],
                        //   [orange, 17],
                        //   [pear, 54]
                        // ]


                        for (var i = 0; i < files.length; i++)
                        {

                            var file = files[i];
                            var fileName = files[i].name;
                            console.log("2 xyz fileName  " + fileName);
                            //Only pics
//                            if (file.type.match('image.*')) {
                            if (validFileType(files[i])) {
                                if (this.files[0].size < 2097152) {
                                    // continue;
                                    var picReader = new FileReader();
                                    picReader.addEventListener("load", function (event) {
                                        var picFile = event.target;
                                        var div = document.createElement("div");
                                        div.style = "background-color: #d9d1d1;";
                                        div.innerHTML =
                                                " <a class='column' style='text-decoration: none;'> <img class='thumbnail' src='" + picFile.result + "'" + "title='" + file.name + " />"
                                                + "<span  class='caption'>" + file.name + "</span></a>";
                                        output.insertBefore(div, null);

//
//$('#pressCuttingsClone').before('<div class="file_upload" id="coverageCuttings'+uploadCounter+'"><input name="CoverageCuttings" type="file"></div>');

//                                        var input = document.createElement("input");
//                                        input.setAttribute("type", "file");
//                                        input.setAttribute("id", "files" + uploadCounter);
//                                        input.setAttribute("name", "PressCuttings" + uploadCounter);
//                                        input.setAttribute("multiple", "");
//                                        input.className = "upload";
//                                        document.getElementById("pressCuttingsClone").appendChild(input);
//$('#files' + uploadCounter).val(file.name);
//                                        document.getElementById("files" + uploadCounter).value = file.name;

//var input = document.createElement("input");
//  input.setAttribute("type","file");
//  input.setAttribute("id" ,"files" );
//  input.setAttribute("name","imgs[]");
//  input.setAttribute("multiple","");
//  input.className = "upload";
//  input.value = picFile.result;
//
//          document.getElementById("pressCuttingsClone").appendChild(input);
//  console.log(input);
                                        console.log("uploadCounter  " + uploadCounter);
                                        uploadCounter++;


//                                        var div = document.createElement("div");
//                                        div.innerHTML =
//                                                " <a class='column' style='text-decoration: none;'> <img class='thumbnail' src='" + picFile.result + "'" + "title='" + file.name + " />"
//                                                + "<span  class='caption'>" + file.name + "</span></a>";
//                                        output.insertBefore(div, null);
//
//                                        var elmnt = document.getElementById("result");
//                                        var cln = elmnt.cloneNode(true);
////                                    document.body.appendChild(cln);
//                                        document.getElementById("pressCuttingsClone").appendChild(cln);
//                                        var images = $('#output img');
//                                        console.log("images");
//                                        console.log(images);
//                                        img = $(this);
//                                        console.log("img");
//                                        console.log(img);
//                                        $('#coverageCuttings').val(img);

                                    });
                                    //Read the image
                                    $('#clear, #result').show();
                                    picReader.readAsDataURL(file);

                                } else {
                                    alert("Image Size is too big. Minimum size is 2MB.");
                                    $(this).val("");
                                }
                            } else {
                                alert("You can only upload image file.");
                                $(this).val("");
                            }

                        }


                    });
                } else
                {
                    console.log("Your browser does not support File API");
                }

//                {
                var emptyTextBoxes = $('input:text').filter(function () {
                    return (this.value !== "" || this.value.length !== 0);
                });
                var string = "The following input fields have been marked readonly - \n";

                emptyTextBoxes.each(function () {
                    string += "\n" + this.id;
                    document.getElementById(this.id).readOnly = true;
                });
                console.log("7 xyz ", string);

//                }

            };

            $('#files').on("click", function () {
                $('.thumbnail').parent().remove();
                $('result').hide();
                $(this).val("");
            });

            $('#clear').on("click", function () {
                $('.thumbnail').parent().remove();
                $('#result').hide();
                $('#files').val("");
                $(this).hide();
            });

        </script>


        <style>
            .coverageCuttings.modal {
                width: 900px; 
                margin: 0 auto; 
            }
            coverageCuttings.modal-content {
                height: 100%;
                border-radius: 0;
                position:relative;
            }
            .coverageCuttings.modal-body {
                position: relative;
                overflow-y: auto;
                max-height: 200px;
                padding: 15px;
            }
            .coverageCuttings.modal-footer {
                border-radius: 0;
                bottom:0px;
                position:absolute;
                width:100%;
            }


            #clear{
                display:none;
            }
            #result {
                border: 4px dotted #cccccc;
                display: none;
                float: right;
                margin:0 auto;
                width: 511px;
            }

            /* Three image containers (use 33.33% for three, 25% for four, and 50% for two, etc) */
            .column {
                float: left;
                width: 33.33%;
                padding: 5px;
            }

            /* Clear floats after image containers */
            .row::after {
                content: "";
                clear: both;
                display: table;
            }

            .autoModal.modal .modal-body{
                max-height: 100%;
            }

            div.upload {
                position: relative;
                overflow: hidden;
            }
            input.upload {
                position: absolute;
                font-size: 50px;
                opacity: 0;
                right: 0;
                top: 0;
            }

            .center-block {
                display: block;
                margin-right: auto;
                margin-left: auto;
            }

        </style>
        <style>

            /*
            * Checkboxes with tick mark
            */

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

            .checkbox label input[type="checkbox"]:readonly + .cr,
            .radio label input[type="radio"]:readonly + .cr {
                opacity: .5;
            }


            .checkbox-inline.no_indent,
            .checkbox-inline.no_indent+.checkbox-inline.no_indent {
                margin-left: 0;
                margin-right: 10px;
            }
            .checkbox-inline.no_indent:last-child {
                margin-right: 0;
            }

            .highlightHeader {
                background:yellow;
                /*      background-color:#d9d1d1;*/
            }

            .centerCover {
                display: block;
                margin-left: auto;
                margin-right: auto;

            }


            .imageupload{
                margin: 20px 0;
            }

        </style>

        <script>

        </script>

    </head>

    <body style="height: 100%">

        <sql:query var="applicationQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM GrantApplication
            WHERE GrantApplication.Status = 'pending' 
            AND publisherID = ?;
            <sql:param value="${publisherID}" />
        </sql:query>
        <c:set var="applicationDetails" value="${applicationQuery.rows[0]}"/>

        <sql:query var="companyQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM international_publishers
            WHERE  international_publishers.Company_Number = ?
            <sql:param value="${publisherID}" />
        </sql:query>    
        <c:set var="companyDetails" value="${companyQuery.rows[0]}"/>

        <div id="shadowholder">
            <div class="shadowtop"> </div>
            <div id="container">
                <div id="topspacer"> </div>
                <div id="topbar">
                    <div class="animateddiv">
                        <a><img src="images/flashtext-animated2.gif" height="80" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a class="logo"><span class="hidden">Literature Ireland</span></a>

                </div> <!--  End of topbar div -->


                <!--container for welcome/logout-->
                <div class="container-fluid" style="margin-bottom: 20px; width: 100%">
                    <div class="pull-right">
                        <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                    </div>
                </div> <!--container for welcome/logout-->

                <h1 align="center" style="align-content: center">Translation Grant Application System for Literature Ireland</h1>

                <div class="container-fluid" style="margin-bottom: 20px"></div>

                <!-- Main Grid Container -->  
                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">

                    <h3 align="center" style="align-content: center">Display pending applications</h3>
                    <br/>

                    <!--Application-->
                    <div class="tab-pane   active in" id="Application">
                        <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">

                            <!-- Main Grid -->  
                            <div class="table-responsive">
                                <table id="applications" class="table display table-striped table-bordered  dt-responsive nowrap" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th class="details-control"></th>   
                                            <th class="never">Application<br/>  No</th>
                                            <th class="never">Application<br/>  Year</th>
                                            <th class="all">Reference<br/>  No</th>
                                            <th class="never">Publisher</th>       
                                            <th class="never">Agreement</th>
                                            <th class="never">Contract</th>
                                            <th class="never">Proposed<br/> Date of <br/> Publication</th>
                                            <th class="never">Proposed<br/> Print Run</th>
                                            <th class="never">Planned Page <br/>  Extent</th>
                                            <th class="never">Translator<br/> CV</th>
                                            <th class="never">Number<br/> Pages</th>
                                            <th class="never">Break-down of <br/> Translator fee</th>
                                            <th class="never">Translator  <br/> Fee</th>
                                            <th class="never">Notes</th>
                                            <th class="never">Status</th>
                                            <th class="never">Copies <br/> Sent</th>
                                            <th class="never">Date Copies  <br/> Were Sent</th>
                                            <th class="never">Copies of  <br/> Translation Sample</th>
                                            <th class="never">T&C has been <br/> Accepted</th>
                                            <th class="never">Approved</th> 
                                            <th class="never">Genre</th>   
                                            <th class="never"></th>
                                            <!--<th class="never">Expert Reader</th>-->
                                            <th class="all">Book Title</th>
                                            <!--<th class="never">24Translator Titles</th>-->
                                            <th class="never">25 Titles</th>
                                            <!--<th class="never">26 Translator CV Doc Name</th>-->
                                            <th class="never">27 Cover</th>
                                            <th class="never">28 Sample Sent Out</th>
                                            <th class="never">29 Sample Returned</th>
                                            <th class="never">30 Reader Report</th>
                                            <!--<th class="never">31 Expert Reader List</th>-->
                                            <!--<th class="never">32 Unassigned Expert Reader List</th>-->    
                                            <th class="never">33 idTranslator</th>
                                            <th class="never">34 Original Date of Publication</th>
                                            <th class="never">35 Original Language</th>
                                            <th class="never">36 Page Extent <br/>(of the original)</th>
                                            <th class="never">37 Country of Publication</th>    
                                            <th class="never">38 Foreign Publisher</th>
                                            <th class="never">39 Foreign Country</th>
                                            <th class="never">Target Language</th>
                                            <th class="never">Board Meeting</th>
                                            <th class="never">Amount Requested</th>
                                            <th class="never">Amount Approved</th>
                                            <th class="never">Publisher informed of Meeting</th>
                                            <th class="never">Board Comments/Instructions</th>
                                            <th class="never">Contract Sent to Publisher</th>
                                            <th class="never">Acknowledgement Approved</th>
                                            <th class="never">Date Published Books Received</th>    
                                            <th class="never">Date Payment made to Publisher</th>
                                            <th class="never">Payment Reference Number</th>
                                            <th class="never">Addendum</th>
                                            <!--<th class="never">Addendum Name</th>-->
                                            <th class="never">Proof of Payment</th>    
                                            <!--<th class="never">Proof of Payment Name</th>-->
                                            <th class="never">Bank Details</th>
                                            <!--<th class="never">Bank Details Name</th>-->    
                                            <th class="never">Signed LI Contract</th>
                                            <!--<th class="never">Signed LI ContractName</th>-->
                                            <th class="never">Payment Status</th>
                                            <th class="never">Previous Grant Aid</th>
                                            <th class="never">Award</th>    
                                            <th class="never">Sales Figures</th>
                                            <th class="never">Original</th>
                                            <!--<th class="never">Original Name</th>-->
                                            <th class="all">Author(s)</th>
                                            <th class="never"></th>                                            
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                        </tr>
                                    </thead>

                                    <tfoot>
                                        <tr>
                                            <th class="details-control"></th>   
                                            <th class="never">Application<br/>  No</th>
                                            <th class="never">Application<br/>  Year</th>
                                            <th class="all">Reference<br/>  No</th>
                                            <th class="never">Publisher</th>       
                                            <th class="never">Agreement</th>
                                            <th class="never">Contract</th>
                                            <th class="never">Proposed<br/> Date of <br/> Publication</th>
                                            <th class="never">Proposed<br/> Print Run</th>
                                            <th class="never">Planned Page <br/>  Extent</th>
                                            <th class="never">Translator<br/> CV</th>
                                            <th class="never">Number<br/> Pages</th>
                                            <th class="never">Break-down of <br/> Translator fee</th>
                                            <th class="never">Translator  <br/> Fee</th>
                                            <th class="never">Notes</th>
                                            <th class="never">Status</th>
                                            <th class="never">Copies <br/> Sent</th>
                                            <th class="never">Date Copies  <br/> Were Sent</th>
                                            <th class="never">Copies of  <br/> Translation Sample</th>
                                            <th class="never">T&C has been <br/> Accepted</th>
                                            <th class="never">Approved</th> 
                                            <th class="never">Genre</th>   
                                            <th class="never"></th>
                                            <!--<th class="never">Expert Reader</th>-->
                                            <th class="all">Book Title</th>
                                            <!--<th class="never">24Translator Titles</th>-->
                                            <th class="never">25 Titles</th>
                                            <!--<th class="never">26 Translator CV Doc Name</th>-->
                                            <th class="never">27 Cover</th>
                                            <th class="never">28 Sample Sent Out</th>
                                            <th class="never">29 Sample Returned</th>
                                            <th class="never">30 Reader Report</th>
                                            <!--<th class="never">31 Expert Reader List</th>-->
                                            <!--<th class="never">32 Unassigned Expert Reader List</th>-->    
                                            <th class="never">33 idTranslator</th>
                                            <th class="never">34 Original Date of Publication</th>
                                            <th class="never">35 Original Language</th>
                                            <th class="never">36 Page Extent <br/>(of the original)</th>
                                            <th class="never">37 Country of Publication</th>    
                                            <th class="never">38 Foreign Publisher</th>
                                            <th class="never">39 Foreign Country</th>
                                            <th class="never">Target Language</th>
                                            <th class="never">Board Meeting</th>
                                            <th class="never">Amount Requested</th>
                                            <th class="never">Amount Approved</th>
                                            <th class="never">Publisher informed of Meeting</th>
                                            <th class="never">Board Comments/Instructions</th>
                                            <th class="never">Contract Sent to Publisher</th>
                                            <th class="never">Acknowledgement Approved</th>
                                            <th class="never">Date Published Books Received</th>    
                                            <th class="never">Date Payment made to Publisher</th>
                                            <th class="never">Payment Reference Number</th>
                                            <th class="never">Addendum</th>
                                            <!--<th class="never">Addendum Name</th>-->
                                            <th class="never">Proof of Payment</th>    
                                            <!--<th class="never">Proof of Payment Name</th>-->
                                            <th class="never">Bank Details</th>
                                            <!--<th class="never">Bank Details Name</th>-->    
                                            <th class="never">Signed LI Contract</th>
                                            <!--<th class="never">Signed LI ContractName</th>-->
                                            <th class="never">Payment Status</th>
                                            <th class="never">Previous Grant Aid</th>
                                            <th class="never">Award</th>    
                                            <th class="never">Sales Figures</th>
                                            <th class="never">Original</th>
                                            <!--<th class="never">Original Name</th>-->
                                            <th class="all">Author(s)</th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                            <th class="never"></th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <!-- Main Grid -->   
                                    </tbody>
                                </table>
                            </div> <!-- Main Grid -->       

                        </div> <!-- container-fluid -->  
                    </div> <!-- tab-pane "Application" -->     

                    <c:if test="${not empty error}">Error: ${error}</c:if>

                    </div> <!-- container-fluid -->
                    <form  method="POST" id="applicationEditForm" name="applicationForm" action="${pageContext.request.contextPath}/PendingApplicationServlet" enctype="multipart/form-data">
                    <%request.getSession().setAttribute("task", "Pending Applications");%>
                    <%request.getSession().setAttribute("publisherID", "publisherID");%>
                    <div class="modal applicationsModal" id="applicationsModal" data-modal-index="1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header" style="background-color: #c3bcbc">
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title">Finalize application <span id="appReferenceNumber"></span></h4>

                                </div>
                                <div class="modal-body" style="background-color: #d9d1d1">

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

                                            <!-- Collect the nav links, forms, and other content for toggling -->
                                            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"  style="font-size: 0.8em !important;  background-color: #d9d1d1">
                                                <ul class="nav navbar-nav nav-tabs two-lines">
                                                    <li class="active"><a href="#Contact" data-toggle="tab">Contact <br/>Details</a></li>
                                                    <li><a href="#books" data-toggle="tab">Book<br/> Details</a></li>                                                    
                                                    <li><a href="#Publication" data-toggle="tab">Publication<br/>  Details</a></li>
                                                    <li><a href="#Translator" data-toggle="tab">Translator's <br/> Details</a></li>
                                                    <li><a href="#Rights" data-toggle="tab">Rights Agreement <br/> & Contracts </a></li>
                                                    <li><a href="#Drawdown" data-toggle="tab">Drawdown<br/> Requirements</a></li>  
                                                    <li><a href="#Original" data-toggle="tab"><span>Original Work<br/>& Sample Translation</span></a></li>
                                                </ul>
                                            </div><!-- /.navbar-collapse -->

                                  <!--          <form  method="POST" id="applicationEditForm" name="applicationForm" action="${pageContext.request.contextPath}/PendingApplicationServlet" enctype="multipart/form-data">
                                            <%request.getSession().setAttribute("task", "Pending Applications");%> -->
                                            <div id="applicationEditForm-tab-content" class="tab-content"  style="background-color: #E8F6FF">


                                                <!-- Contact details -->
                                                <div class="tab-pane active" id="Contact">

                                                    <!--wrapper for Contact tab pane-->
                                                    <div class="container">

                                                        <!--first row-->
                                                        <!--get Company and Company_Number via autocomplete-->
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-6">
                                                                <input  id="company" 
                                                                        name="company" 
                                                                        type="text" 
                                                                        value="${publisherName}"
                                                                        data-toggle="tooltip"
                                                                        title="Please Enter your Company's Name - if it does not show up please fill in the form"
                                                                        class="form-control"
                                                                        placeholder="Company Name"
                                                                        readonly
                                                                        >
                                                            </div>

                                                            <div class="col-sm-4">        
                                                                <input id="Company_Number"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Company_Number"                                
                                                                       value="${publisherID}"                                   
                                                                       placeholder="internal Company Number"
                                                                       readonly
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <!--second row-->
                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="col-sm-6">
                                                                <label class="pull-left">Address1</label>
                                                                <input id="Address1"
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Address1"                                
                                                                       value="${companyDetails.Address1}"                                
                                                                       placeholder="Address1"
                                                                       >
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <label class="pull-left">Post code</label>
                                                                <input id="postCode"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="postCode"                                
                                                                       value="${companyDetails.postCode}"                                
                                                                       placeholder="Post Code"
                                                                       >
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label class="pull-left">City</label>
                                                                <input id="City"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="City"                                
                                                                       value="${companyDetails.City}"                                
                                                                       placeholder="City"
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <!--third row-->
                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="col-sm-6">
                                                                <label class="pull-left">Address2</label>
                                                                <input id="Address2"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Address2"                                
                                                                       value="${companyDetails.Address2}"                                
                                                                       placeholder="Address2"
                                                                       >
                                                            </div>

                                                            <div class="col-sm-5">
                                                                <label class="pull-left">Country</label>
                                                                <input id="country"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Country"                                
                                                                       value="${companyDetails.Country}"                                
                                                                       placeholder="Country"
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <!--fourth row-->
                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="col-sm-6">
                                                                <label class="pull-left">Address3</label>
                                                                <input id="Address3"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Address3"                                
                                                                       value="${companyDetails.Address3}"                                
                                                                       placeholder="Address3"
                                                                       >
                                                            </div>
                                                            <div class="col-sm-2">   
                                                                <label class="pull-left">&nbsp;</label>
                                                                <input id="countryCode"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Country_Code"                                
                                                                       value="${companyDetails.CountryCode}"                               
                                                                       readonly
                                                                       placeholder="Country Code"
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <!--fifth row-->
                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="col-sm-6">      
                                                                <label class="pull-left">Address4</label>
                                                                <input id="Address4"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Address4"                                
                                                                       value="${companyDetails.Address4}"                                
                                                                       placeholder="Address4"
                                                                       >
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <label class="pull-left">Telephone</label>
                                                                <input id="Telephone"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Telephone"                                
                                                                       value="${companyDetails.Telephone}"                                
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <!--sixth row-->
                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="col-sm-6"></div>
                                                            <div class="col-sm-3">
                                                                <label class="pull-left">Fax number</label>
                                                                <input id="Fax"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Fax"                                
                                                                       value="${companyDetails.Fax}"
                                                                       >
                                                            </div>
                                                        </div> <!--row-->


                                                        <!--seventh row-->
                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="col-sm-6">
                                                                <label class="pull-left">Email</label>
                                                                <input id="Email"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="Email"                                
                                                                       value="${companyDetails.Email}"                                
                                                                       placeholder="Main Email"
                                                                       >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label class="pull-left">Website</label>
                                                                <input id="WWW"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="WWW"                                
                                                                       value="${companyDetails.WWW}"                                
                                                                       placeholder="Web Address"
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <!--eighth row-->
                                                        <div class="row" style="margin-bottom: 10px;margin-top: 20px">
                                                            <div class="col-sm-4"> 
                                                                <div class="well well-sm">
                                                                    <div class="checkbox">                                                        
                                                                        <input id="doNotMail" 
                                                                               type="checkbox" 
                                                                               name="doNotMail" 
                                                                               value="${companyDetails.doNotMail}" 
                                                                               checked =""
                                                                               >  
                                                                        <label for="doNotMail">Do not add to newsletter</label>
                                                                    </div><!--checkbox-->
                                                                </div> <!--well-->
                                                            </div> <!--<div class="col-sm-3">-->   
                                                        </div> <!--row-->
                                                        <input type="hidden" id="translatorArray" name="translatorArray" >
                                                        <input type="hidden" id="authorArray" name="authorArray" >
                                                        <input type="hidden" id="ReferenceNumber" name="ReferenceNumber" >
                                                        <!--keep in one line otherwise placeholder doesn't show-->
                                                        <textarea id="companyNotes"  class="form-control" style="width: 870px; height: 343px;" name="companyNotes" placeholder="enter optional notes"> <c:out value="${companyDetails.Notes}" /></textarea>
                                                    </div> <!--container-->
                                                </div> <!-- tab-pane "Contact" -->

                                                <!-- Book Details -->
                                                <div class="tab-pane " id="books">
                                                    <p class="header1">
                                                        Book Details
                                                    </p>
                                                    <div class="container-fluid">
                                                        <div class="row"  style="display: block;
                                                             margin-right: auto;
                                                             margin-left: auto;">

                                                            <!--First row-->
                                                            <!--in Panel-->
                                                            <div class = "panel panel-default">
                                                                <div class = "panel-body">

                                                                    <div class="row" style="margin-bottom: 10px">
                                                                        <div class="col-sm-8">    

                                                                            <label for="authors" class="pull-left">Author(s)</label><br/>
                                                                            <div class="form-group">

                                                                                <textarea class="form-control" id="authors" readonly name="authors" ></textarea>
                                                                                <!--       <input id="aFirstName"                                
                                                                                      type="text"                                
                                                                                      class="form-control"                                
                                                                                      name="AuthorFirstName"                                
                                                                                      value=""    
                                                                                      placeholder="Author First Name"
                                                                                      >
                                                                               <i class="glyphicon glyphicon-search form-control-feedback"></i>-->
                                                                            </div>  <!-- input-group -->
                                                                        </div>
                                                                    </div> <!--row-->




                                                                    <!--Second row-->
                                                                    <div class="row" style="margin-bottom: 15px">

                                                                        <div class="col-sm-5">    
                                                                            <label for="appBookTitle" class="pull-left">Title<br/> &nbsp;</label> 
                                                                            <input id="appBookTitle"                                
                                                                                   type="text"                                
                                                                                   class="form-control"                                
                                                                                   name="appBookTitle"                                
                                                                                   value=""    
                                                                                   placeholder="Title"
                                                                                   >
                                                                        </div>
                                                                        <input type="hidden" id="bookTitle" name="bookTitle" >
                                                                        <div class="col-sm-4">          
                                                                            <label for="appForeignPublisher" class="pull-left">Publisher (of the original)<br/> &nbsp;</label>                                                           
                                                                            <input id="appForeignPublisher"                                
                                                                                   type="text"                                
                                                                                   class="form-control"                                
                                                                                   name="appForeignPublisher"                                
                                                                                   value="${companyDetails.Company}"    
                                                                                   placeholder="Publisher"
                                                                                   >                                                     
                                                                        </div>

                                                                        <div class="col-sm-3">    
                                                                            <label for="publicationYear" class="control-label pull-left">Year of Publication<br/> (of the original) </label>

                                                                            <input id="publicationYear"                                
                                                                                   type="text"                                
                                                                                   class="form-control"                                
                                                                                   name="publicationYear"                                
                                                                                   value=""    
                                                                                   placeholder="Publication Year"
                                                                                   >
                                                                        </div>
                                                                    </div> <!--row-->


                                                                    <!--Third row-->

                                                                    <div class="row" style="margin-bottom: 10px">

                                                                        <div class="col-sm-4">    
                                                                            <div class="form-group has-feedback">
                                                                                <label for="appGenre" class="pull-left">Genre</label>
                                                                                <input id="appGenre"                                
                                                                                       type="text"                                
                                                                                       class="form-control"                                
                                                                                       name="genre"                                
                                                                                       value=""    
                                                                                       placeholder="Genre"
                                                                                       >
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!--Fourth row-->
                                                                    <div class="row" style="margin-bottom: 10px">

                                                                        <div class="col-xs-8">

                                                                            <div class="row">

                                                                                <div class="col-xs-6">
                                                                                    <div class="mini-box">
                                                                                        <div class="form-group has-feedback">
                                                                                            <label for="appLanguageOriginal" class="pull-left" >Language <br/>(of the original)</label>
                                                                                            <input id="appLanguageOriginal"                                
                                                                                                   type="text"                                
                                                                                                   class="form-control"                                
                                                                                                   name="languageOfTheOriginal"                                
                                                                                                   value=""    
                                                                                                   placeholder="Language"

                                                                                                   >
                                                                                        </div>
                                                                                    </div>
                                                                                </div> <!--col-xs-6-->

                                                                                <div class="col-xs-6" style="margin-bottom: 20px">
                                                                                    <div class="mini-box">
                                                                                        <label for="appCountryOfPublication" class="control-label pull-left" >Country of publication <br/>(of the original)</label>
                                                                                        <input id="appCountryOfPublication"                                
                                                                                               type="text"                                
                                                                                               class="form-control"                                
                                                                                               name="appCountryOfPublication"                                
                                                                                               value=""    
                                                                                               placeholder="Country of Publication"
                                                                                               >
                                                                                    </div>
                                                                                </div> <!--col-xs-6-->
                                                                            </div> <!--row-->

                                                                            <div class="row">

                                                                                <div class='col-sm-6'  style="margin-bottom: 40px;">                                                
                                                                                    <label for="originalPageExtent" class="control-label pull-left">Page extent of the <br/> (of the original): </label>
                                                                                    <div class="input-group pull-left"  style="margin-bottom: 40px;">
                                                                                        <span class="input-group-addon" id="sizing-addon3">  
                                                                                            <span class="glyphicon glyphicon-book"></span>                                                            
                                                                                        </span>
                                                                                        <input type="text" name="originalPageExtent" id="originalPageExtent" class="form-control" placeholder="number of pages" aria-describedby="sizing-addon3">
                                                                                    </div>
                                                                                </div>
                                                                            </div> <!--row-->
                                                                        </div><!--col-xs-8-->
                                                                    </div> <!-- row-->


                                                                    <!--Eigthrow-->

                                                                    <div class="row" style="margin-bottom: 10px">

                                                                        <div class="col-sm-4">   
                                                                            <label for="bookNotes" class="pull-left">Notes</label>
                                                                            <div class="form-group">
                                                                                <textarea class="form-control" id="bookNotes" name="bookNotes" style="width: 800px; height: 215px" placeholder="Notes"></textarea>
                                                                            </div>
                                                                        </div>                                                    
                                                                    </div> <!-- row  -->
                                                                </div>  <!-- panel-body-->     
                                                            </div>  <!-- panel --> 
                                                        </div> <!-- row  -->
                                                    </div>  <!-- container-fluid  -->
                                                </div><!-- tab-pane "Book" -->

                                                <!-- Rights Agreement -->
                                                <div class="tab-pane" id="Rights">
                                                    <p class="header1" style="margin-bottom: 40px">
                                                        Rights Agreement & Contracts
                                                    </p>

                                                    <div class="container-fluid"  style="background-color: #d9d1d1">
                                                        <div class="row"  style="display: block;
                                                             margin-right: auto;
                                                             margin-left: auto;">

                                                            <nav class="navbar navbar-default" >
                                                                <div class="container-fluid"  style="background-color: #d9d1d1">
                                                                    <!-- Brand and toggle get grouped for better mobile display -->
                                                                    <div class="navbar-header">
                                                                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-2" aria-expanded="false">
                                                                            <span class="sr-only">Toggle navigation</span>
                                                                            <span class="icon-bar"></span>
                                                                            <span class="icon-bar"></span>
                                                                            <span class="icon-bar"></span>
                                                                        </button>
                                                                        <!--<a class="navbar-brand" href="#">Brand</a>-->
                                                                    </div>
                                                                    <!-- Collect the nav links, forms, and other content for toggling -->
                                                                    <div  id="tn">                                                        
                                                                    </div>  <!-- tn -->
                                                                    <div class="tab-content" id="tnc">

                                                                    </div>  <!-- tnc -->
                                                                </div>  <!-- <div class="container-fluid"  -->
                                                            </nav>  <!-- <nav class="navbar -->
                                                        </div>  <!-- row  -->
                                                    </div> <!-- container-fluid  -->
                                                </div> <!-- class="tab-pane" id="Rights" -->

                                                <!-- Publication Details -->
                                                <div class="tab-pane" id="Publication">
                                                    <p class="header1" style="margin-bottom: 40px">
                                                        Publication Details
                                                    </p>

                                                    <div class="container-fluid">
                                                        <div class="col-xs-12 content">

                                                            <div class="row">


                                                                <div class='col-sm-4'>
                                                                    <label for="proposedDateOfPublication" class="control-label pull-left">Proposed date of publication</label>
                                                                    <div class="input-group pull-left"   style="margin-bottom: 40px;">
                                                                        <input type="text" name="proposedDateOfPublication" id="proposedDateOfPublication" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                        <label class="input-group-addon" for="proposedDateOfPublication">
                                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                                        </label>
                                                                    </div>
                                                                    <script>
                                                                        $("#proposedDateOfPublication").datepicker();
                                                                    </script>
                                                                </div>

                                                                <div class="col-sm-4">          
                                                                    <label for="foreignPublisher" class="pull-left">Publisher (of the original)</label>                                                           
                                                                    <input id="foreignPublisher"                                
                                                                           type="text"                                
                                                                           class="form-control"                                
                                                                           name="foreignPublisher"                                
                                                                           placeholder="Publisher"
                                                                           >                                                     
                                                                </div>
                                                            </div> <!-- row -->

                                                            <div class="row">

                                                                <div class='col-sm-4'  style="margin-bottom: 40px;">                                                
                                                                    <label for="plannedPageExtent" class="control-label pull-left">Planned page extent of the <br/>  published translation </label>
                                                                    <div class="input-group pull-left"  style="margin-bottom: 40px;">
                                                                        <span class="input-group-addon" id="sizing-addon2">  
                                                                            <span class="glyphicon glyphicon-book"></span>                                                            
                                                                        </span>
                                                                        <input type="text" name="plannedPageExtent" id="plannedPageExtent" class="form-control" placeholder="number of pages" aria-describedby="sizing-addon2">
                                                                    </div>
                                                                </div>

                                                                <div class="col-sm-4">
                                                                    <label for="appForeignCountry" class="control-label pull-left">Foreign Country <br/> &nbsp;</label>
                                                                    <input  id="appForeignCountry" 
                                                                            name="appForeignCountry" 
                                                                            type="text"                                                                
                                                                            class="form-control"     
                                                                            >
                                                                </div>

                                                            </div>  <!-- row -->

                                                            <div class="row">
                                                                <div class='col-sm-4'>
                                                                    <label for="appproposedPrintRun" class="control-label pull-left">Proposed print run </label>
                                                                    <div class="input-group pull-left"  style="margin-bottom: 40px;">
                                                                        <span class="input-group-addon" id="sizing-addon1">  
                                                                            <span class="glyphicon glyphicon-book"></span>                                                            
                                                                        </span>
                                                                        <input type="text" name="appproposedPrintRun" id="appproposedPrintRun" class="form-control" placeholder="number of books" aria-describedby="sizing-addon1">  
                                                                    </div>
                                                                </div>

                                                                <div class="col-sm-4">        
                                                                    <label for="appTargetLanguage" class="control-label pull-left"> Target Language</label>
                                                                    <input id="appTargetLanguage"                                
                                                                           type="text"                                
                                                                           class="form-control"                                
                                                                           name="appTargetLanguage"                                
                                                                           >
                                                                </div>
                                                            </div> <!-- row -->

                                                            <div class="row">

                                                                <div class="col-sm-4" style="margin-bottom: 20px">
                                                                    <label for="translationTitle" class="pull-left">Translation Title<br/> &nbsp;</label>
                                                                    <input id="translationTitle"                                
                                                                           type="text"                                
                                                                           class="form-control"                                
                                                                           name="translationTitle"                                
                                                                           value=""    
                                                                           placeholder="Translation Title"
                                                                           >
                                                                </div>

                                                                <div class="col-xs-5">
                                                                    <div class="mini-box" style="margin-bottom: 20px">
                                                                        <label for="publicationYear1" class="control-label pull-left">Year of Publication<br/> (of the original) </label>
                                                                        <div class="input-group pull-left">
                                                                            <input type="text" 
                                                                                   name="publicationYear1" 
                                                                                   id="publicationYear1" 
                                                                                   class="form-control" 
                                                                                   placeholder="DD/MM/YYYY"
                                                                                   />    
                                                                        </div>
                                                                    </div>
                                                                    <script>
                                                                        $("#appDateOfPublicationOriginal").datepicker();
                                                                    </script>
                                                                </div> <!--col-xs-6-->

                                                            </div> <!-- row -->


                                                            <div class="row">

                                                                <div class="col-xs-4">
                                                                    <div class="mini-box"   style="margin-bottom: 20px">
                                                                        <label for="appCompany" class="pull-left">Translation Publisher</label>
                                                                        <input id="appCompany"                                
                                                                               type="text"                                
                                                                               class="form-control"                                
                                                                               name="appCompany"                                
                                                                               value=""    
                                                                               placeholder="Translation Publisher"
                                                                               >
                                                                    </div>
                                                                </div> <!--col-xs-6-->

                                                                <div class="col-xs-5">
                                                                    <div class="mini-box">
                                                                        <div class="form-group has-feedback">
                                                                            <label for="languages" class="pull-left" >Languages</label>
                                                                            <input id="languages"                                
                                                                                   type="text"                                
                                                                                   class="form-control"                                
                                                                                   name="languages"                                
                                                                                   value=""    
                                                                                   placeholder="Languages"
                                                                                   >
                                                                            <!--<i class="glyphicon glyphicon-search form-control-feedback"></i>-->
                                                                        </div>
                                                                    </div>
                                                                </div> <!--col-xs-6-->

                                                                <input type="hidden" id="languageArray" name="languageArray" >

                                                            </div> <!-- row -->
                                                            <div class="row">
                                                                <div class="col-xs-4">
                                                                    <div class="mini-box" style="margin-bottom: 20px">
                                                                        <label for="series" class="pull-left" style="margin-top: 10px">Series</label>
                                                                        <input id="series"                                
                                                                               type="text"                                
                                                                               class="form-control"                                
                                                                               name="series"                                
                                                                               value=""    
                                                                               placeholder="Series"
                                                                               >
                                                                    </div>
                                                                </div> <!--col-xs-6-->
                                                            </div> <!-- row -->

                                                        </div>  <!-- col-xs-12 content -->
                                                    </div> <!-- container-fluid -->
                                                </div> <!-- tab-pane "Publication Details" -->

                                                <!-- Translator's Details -->
                                                <div class="tab-pane" id="Translator"> 
                                                    <p class="header1" style="margin-bottom: 40px">
                                                        Translator Details
                                                    </p>

                                                    <div class="container-fluid">

                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="panel panel-default">
                                                                <div class="panel-body">

                                                                    <div class="col-md-12" id="translatorTableDiv" style="margin-left: 40px;"></div>

                                                                </div>
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 10px">
                                                            <div class="panel panel-default">
                                                                <div class="panel-body">
                                                                    <div class="col-md-4" style="margin-top: 40px; margin-bottom: 20px">                                              

                                                                        <label for="translatorFee" class="control-label pull-left">Translator(s)'s fee</label>                                                                        
                                                                        <div class="input-group pull-left" style="margin-bottom: 20px">
                                                                            <label class="input-group-addon" for="translatorFee">
                                                                                <span class="glyphicon glyphicon-euro"></span>                                     
                                                                            </label>
                                                                            <input type="text" class="form-control pull-left" name="translatorFee" id="translatorFee" placeholder="fee">    
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-4" style="margin-top: 40px; margin-bottom: 20px">  
                                                                        <label for="breakDownTranslatorFee" class="control-label pull-left">Break-down of translator(s)'s fee</label>                                                  
                                                                        <div class="form-group">
                                                                            <!--keep in one line otherwise placeholder doesn't show-->
                                                                            <textarea class="form-control" placeholder="Break-down of translator fee" name="breakDownTranslatorFee" id='breakDownTranslatorFee' style="width: 280px; height: 196px;"></textarea>
                                                                        </div>
                                                                    </div>
                                                                </div>  <!--panel--body-->
                                                            </div> <!--panel-default-->
                                                        </div> <!-- row -->
                                                    </div> <!-- container-fluid -->
                                                </div> <!-- tab-pane "Translator Details" -->                               

                                                <!-- Drawdown Requirements -->
                                                <div class="tab-pane" id="Drawdown">
                                                    <p class="header1" style="margin-bottom: 40px">
                                                        Drawdown Requirements
                                                    </p>

                                                    <div class="container-fluid">

                                                        <div class="row"> 

                                                            <!--<div style=" margin: 0 auto; position: relative;">-->
                                                            <div class="col-sm-4"></div>
                                                            <div id="showUploadCover1" class="col-sm-4"  style="margin-bottom:  40px; ">

                                                                <!-- bootstrap-imageupload. -->                                                               
                                                                <div class="imageupload panel panel-default">
                                                                    <div class="panel-heading clearfix">
                                                                        <h3 class="panel-title ">Select book cover</h3>
                                                                    </div>
                                                                    <div class="file-tab panel-body" id="cover1" style="display:block; margin:auto; margin-left: 30px">

                                                                        <label class="btn btn-default btn-file" onclick="storeImage();">
                                                                            <span>Browse</span>
                                                                            <!-- The file is stored here. -->

                                                                            <input type="file" id="Cover1" name="Cover" style="width:200px;height:300px;">

                                                                        </label>

                                                                        <button type="button" class="btn btn-default">Remove</button>
                                                                    </div>
                                                                </div>
                                                                <input type="hidden" value="Cover" name="image-file" id="label_cover1"/>
                                                            </div>

                                                            <div id="showUploadCover2" class="col-sm-4"  style="margin-bottom:  40px; "> 
                                                                <div class="panel panel-default">
                                                                    <div class="panel-heading clearfix">
                                                                        <h3 class="panel-title " id="showUploadCoverTitle"></h3>
                                                                    </div>

                                                                    <div class="panel-body" id="cover2" style="display:block;  margin:auto;">

                                                                        <img src="" id="cover21"  alt="" style="width:200px;height:300px;">

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!--</div> position: relative;-->

                                                        </div> <!--row-->

                                                    </div>  <!--<div class="container-fluid">-->

                                                    <div class="container-fluid">

                                                        <div class="row" style="position:static !important;">
                                                            <div class="col-sm-3">
                                                                <!--<div class="mini-box">-->   
                                                                <label for="isbn" class="pull-left">ISBN</label>
                                                                <input id="isbn"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="isbn"                                
                                                                       value=""    
                                                                       placeholder="ISBN"
                                                                       >

                                                                <!--</div>-->
                                                            </div> <!--col-xs-6-->
                                                            <div class="col-sm-3"></div>
                                                            <div class="col-sm-3">
                                                                <!--<div class="mini-box">-->
                                                                <label for="isnn" class="pull-left">ISSN</label>
                                                                <input id="isnn"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="issn"                                
                                                                       value=""    
                                                                       placeholder="ISSN"
                                                                       >
                                                                <!--</div>-->                                                                                    
                                                            </div> <!--col-xs-6-->
                                                        </div> <!--row-->

                                                        <div class="row">
                                                            <div style=" margin: 0 auto; position: relative; ">
                                                                <div  id="proofPaymentDiv1"  class="col-md-6"   style="margin-top: 40px; margin-bottom: 40px; position: absolute; z-index:0;">
                                                                    <strong class="pull-left">Proof of Payment to the translator</strong> 
                                                                    <div class="input-group proofPayment pull-left"  
                                                                         data-toggle="tooltip"
                                                                         title="pdf or image file most of the time but we should allow word doc/open office equivalent." 
                                                                         data-placement="bottom" >
                                                                        <label class="btn btn-default btn-file pull-left">
                                                                            Select file 
                                                                            <input type="file"  
                                                                                   name="proofPayment" 
                                                                                   id="proofPayment"
                                                                                   >
                                                                            <span class="glyphicon glyphicon-folder-open"></span>
                                                                        </label>
                                                                        <input id="label_proofPayment" class="pull-left">                                                                               
                                                                        <br/>
                                                                        <br/>          
                                                                        <input type="hidden" name="userID" value="${userID}">
                                                                        <input type="hidden" name="name" value="${name}">
                                                                        <input type="hidden" name="publisherID" value=<%=request.getParameter("publisherID")%> />
                                                                        <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                                        <!--Destination:-->
                                                                        <input type="hidden" id="proofPayment_upload" value="proofPayment" name="destination" />                                          
                                                                    </div>
                                                                </div> <!--proofPaymentDiv1-->

                                                                <div class="col-md-5" id="proofPaymentDiv2" style="margin-top: 40px; margin-bottom: 40px; position:absolute; z-index:1; display:none;"> 
                                                                    <label  class="control-label pull-left" id="proofPayment_button_label" >Open proof of payment to the translator</label>
                                                                    <div class="input-group pull-left">
                                                                        <a class="btn btn-info btn-file pull-left" role="button" id="proofPayment_link" href="">
                                                                            <span class="glyphicon glyphicon-file"></span>
                                                                            Click to open</a>
                                                                    </div>
                                                                </div> <!--proofPaymentDiv2-->

                                                            </div> <!--position: relative-->

                                                            <div class="col-md-6"   style="margin-top: 40px; margin-bottom: 40px; "></div>
                                                            <div class="col-md-4"   style="margin-top: 40px; margin-bottom: 40px">
                                                                <strong class="pull-left">Amount Requested</strong> 
                                                                <div class="input-group pull-left">
                                                                    <label class="input-group-addon" for="amountRequested">
                                                                        <span class="glyphicon glyphicon-euro"></span>                                     
                                                                    </label>
                                                                    <input type="text" class="form-control" name="amountRequested" id="amountRequested" placeholder="Amount Requested" disabled="">    
                                                                </div>
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row"  style="margin-bottom: 40px;">
                                                            <div style="margin: 0 auto; position: relative;">
                                                                <div  id="bankDetailForm1"   class="col-md-6"   style="margin-bottom: 40px; position: absolute; z-index:0;">                                                    
                                                                    <strong class="pull-left">Completed bank details form</strong> <br/>
                                                                    <div class="input-group bankDetailForm pull-left"  
                                                                         data-toggle="tooltip"
                                                                         title="pdf or image file most of the time but we should allow word doc/open office equivalent." 
                                                                         data-placement="bottom" >
                                                                        <label class="btn btn-default btn-file pull-left">
                                                                            Select file 
                                                                            <input type="file"  
                                                                                   name="bankDetailForm" 
                                                                                   id="bankDetailForm" >
                                                                            <span class="glyphicon glyphicon-folder-open"></span>
                                                                        </label>
                                                                        <input id="label_BankDetailForm" class="pull-left">                                                                               
                                                                        <br/>
                                                                        <br/>          
                                                                        <input type="hidden" name="userID" value="${userID}">
                                                                        <input type="hidden" name="publisherID" value="${publisherID}">
                                                                        <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                                        <!--Destination:-->
                                                                        <input type="hidden" id="bankDetailForm_upload" value="bankDetailForm" name="destination" />                                          
                                                                    </div>
                                                                </div> <!--bankDetailForm1-->

                                                                <div class="col-md-5" id="bankDetailForm2" style="margin-bottom: 40px; position:absolute; z-index:1; display:none;"> 
                                                                    <label  class="control-label pull-left" id="bankDetailForm_button_label" >Open completed bank details form</label>
                                                                    <div class="input-group pull-left">
                                                                        <a class="btn btn-info btn-file pull-left" role="button" id="bankDetailForm_link" href="">
                                                                            <span class="glyphicon glyphicon-file"></span>
                                                                            Click to open</a>
                                                                    </div>
                                                                </div> <!--bankDetailForm2-->

                                                            </div> <!--position: relative-->

                                                            <div class="col-md-6"   style="margin-bottom: 40px"></div>
                                                            <div class="col-md-4"   style="margin-bottom: 40px">
                                                                <strong class="pull-left">&nbsp;</strong>    
                                                                <!--<button type="button" data-toggle="modal" data-target="#pressCuttingsModal">Launch modal</button>-->
                                                                <label class="btn btn-default pull-left callPressCuttingsModal" data-toggle="modal" data-target="#pressCuttingsModal">
                                                                    <img src="images/Press_Cutting.png" width="20" alt="Press_Cutting.png" /> 
                                                                    Upload coverage cuttings
                                                                    <!--<span class="glyphicon glyphicon-upload"></span>-->
                                                                </label>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row"  style="margin-bottom: 60px;">
                                                            <div style=" margin: 0 auto; position: relative; ">
                                                                <div  id="signedLIContract1"  class="col-md-6"   style="margin-bottom: 60px;  position: absolute; z-index:0;">
                                                                    <!--<label for="label_signedLIcontract" class="control-label pull-left">Signed Literature Ireland contract</label>-->
                                                                    <strong class="pull-left">Signed Literature Ireland contract</strong> <br/>
                                                                    <div class="input-group signedLIcontract pull-left"  
                                                                         data-toggle="tooltip"
                                                                         title="pdf or image file." 
                                                                         data-placement="bottom" >
                                                                        <label class="btn btn-default btn-file pull-left">
                                                                            Select file 
                                                                            <input type="file"  
                                                                                   name="signedLIcontract" 
                                                                                   id="signedLIcontract" >
                                                                            <span class="glyphicon glyphicon-folder-open"></span>
                                                                        </label>
                                                                        <input id="label_signedLIcontract" class="pull-left">                                                                               
                                                                        <br/>
                                                                        <br/>          
                                                                        <input type="hidden" name="userID" value="${userID}">
                                                                        <input type="hidden" name="publisherID" value="${publisherID}">
                                                                        <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                                        <!--Destination:-->
                                                                        <input type="hidden" id="signedLIcontract_upload" value="signedLIcontract" name="destination" />                                          
                                                                    </div>
                                                                </div>  <!--signedLIContract1-->

                                                                <div class="col-md-5" id="signedLIContract2" style="margin-bottom: 60px; position:absolute; z-index:1; display:none;"> 
                                                                    <label  class="control-label pull-left" id="signedLIcontract_button_label" >Open signed Literature Ireland contract</label>
                                                                    <div class="input-group pull-left">
                                                                        <a class="btn btn-info btn-file pull-left" role="button" id="signedLIcontract_link" href="">
                                                                            <span class="glyphicon glyphicon-file"></span>
                                                                            Click to open</a>
                                                                    </div>
                                                                </div>  <!--signedLIContract2-->

                                                            </div> <!--position: relative-->
                                                        </div> <!--row-->

                                                    </div> <!-- container-fluid -->
                                                </div> <!-- tab-pane "Drawdown Requirements" -->  

                                                <!-- Original Work & Sample Translation -->
                                                <div class="tab-pane" id="Original">
                                                    <p class="header1" style="margin-bottom: 40px">
                                                        Original Work & Sample Translation
                                                    </p>

                                                    <div class="container-fluid">

                                                        <div class="row" >

                                                            <div class="panel panel-default">
                                                                <div class="panel-body">

                                                                    <!--copies of the original work-->
                                                                    <div class="col-md-9" >
                                                                        <div class="checkbox pull-left">                                                             
                                                                            <label for="copiesSent" class="pull-left"><strong>One copy of the original work<sup>*</sup> sent to Literature Ireland by post</strong></label>
                                                                            <label style="font-size: 2.0em; " class="checkbox-inline  no_indent">
                                                                                <input type="checkbox" 
                                                                                       name="copiesSent" 
                                                                                       id="copiesSent" 
                                                                                       checked =""
                                                                                       value="" 
                                                                                       class="form-control">
                                                                                <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
                                                                            </label>
                                                                            <input type="hidden" name="userID" value="${userID}">
                                                                            <input type="hidden" name="name" value="${name}">
                                                                            <input type="hidden" name="publisherID" value="${publisherID}">
                                                                            <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                                            <input type="hidden" name="publisherName" value="${companyDetails.Company}">
                                                                        </div>
                                                                    </div> <!-- col-md-7 -->

                                                                    <div class="pressCuttingsClone" id="pressCuttingsClone"></div>

                                                                    <!--Date copies were sent:-->
                                                                    <div class="col-md-3" >
                                                                        <label for="copiesSent" class="pull-left"><strong>Date copies were sent</strong> </label>
                                                                        <div class="input-group pull-left" >
                                                                            <input type="text" name="dateCopiesWereSent" id="dateCopiesWereSent" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                            <label class="input-group-addon" for="dateCopiesWereSent">
                                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                                            </label>
                                                                        </div>  <!-- input-group -->
                                                                    </div> <!--col-md-3-->

                                                                    <!--datepicker  mail-sent-->
                                                                    <script>
                                                                        $("#dateCopiesWereSent").datepicker();
                                                                    </script>

                                                                </div> <!--panel--body-->
                                                            </div> <!--panel-default-->

                                                        </div> <!-- row -->

                                                        <div class="row" >

                                                            <div class="panel panel-default">        
                                                                <div class="panel-body">
                                                                    <div class="col-md-12">

                                                                        <div class="alert alert-danger" role="alert" id="errorField" style="display:none">
                                                                            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                                                            <span class="sr-only">Error:</span>
                                                                            <span class="message"></span>
                                                                        </div>
                                                                        <div class="alert alert-success" role="alert" id="successField" style="display:none">
                                                                            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                                                            <span class="sr-only">Success:</span>
                                                                            <span class="message"></span>
                                                                        </div>

                                                                        <div class="row">
                                                                            <div class="col-md-6"   style="margin-bottom: 20px">        
                                                                                <label  class="control-label pull-left">Open electronic copy of original work </label>
                                                                                <div class="input-group originalSample1 pull-left" >
                                                                                    <a class="btn btn-info btn-file pull-left" role="button" id="originalSample1" href="">
                                                                                        <span class="glyphicon glyphicon-file"></span>
                                                                                        Copy of original work</a>
                                                                                </div>
                                                                            </div>
                                                                        </div> <!--row-->

                                                                        <div class="row">

                                                                            <div class="col-md-6"   style="margin-bottom: 20px">        
                                                                                <label  class="control-label pull-left">Open copy of translation sample<sup>**</sup><br/> (10 to 12 pages of prose or six poems)</label>
                                                                                <div class="input-group translationSample1 pull-left" >
                                                                                    <a class="btn btn-info btn-file pull-left" role="button" id="translationSample1" href="">
                                                                                        <span class="glyphicon glyphicon-file"></span>
                                                                                        Copy of translation sample</a>
                                                                                </div>
                                                                            </div>
                                                                        </div> <!--row-->                                                            
                                                                        <!-- translationSampleForm -->                                                                                                              
                                                                    </div>  <!-- col-md-12 -->
                                                                </div>  <!--panel--body-->
                                                            </div> <!--panel-default-->

                                                        </div> <!-- row -->

                                                        <div class="row" >

                                                            <div class="panel panel-default">        
                                                                <div class="panel-body">

                                                                    <div class="col-md-9"   >
                                                                        <div class="input-group input-group-lg"> <br/>
                                                                            <button type="submit"                                                                          
                                                                                    data-toggle="tooltip" 
                                                                                    class="btn btn-success"
                                                                                    title="Click to update the application!"
                                                                                    style="margin-bottom: 10px"
                                                                                    >
                                                                                Update the application
                                                                                <span class="glyphicon glyphicon-import"></span>
                                                                            </button>
                                                                        </div><!-- input-group -->
                                                                    </div>  <!-- col-md-9 -->
                                                                </div>  <!-- panel--body -->
                                                            </div>  <!--panel--default-->     

                                                        </div> <!-- row -->

                                                        <hr/>
                                                        <div class="col-md-12">
                                                            <i class="pull-left"><strong> &nbsp; *</strong> Please contact Literature Ireland if a hard copy of the original work cannot be obtained.</i><br/>
                                                            <i class="pull-left">  <strong>**</strong> If more than one translator is involved, a translation sample must be submitted for each translator.</i>
                                                        </div>    
                                                    </div>  <!-- container-fluid -->
                                                </div> <!-- tab-pane "Original Work & Sample Translation" --> 

                                            </div> <!-- applicationEditForm-tab-content -->



                                            <div class="modal-footer"  style="background-color: #c3bcbc">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                            </div>
                                        </div> <!-- container-fluid -->  
                                    </nav>    
                                </div> <!-- /.modal-body -->
                            </div> <!-- /.modal-content -->
                        </div><!-- /.modal-dialog -->
                    </div> <!--modal fade-->
                    <div class="modal autoModal coverageCuttings" id="pressCuttingsModal"  tabindex="-1" role="dialog" aria-labelledby="pressCuttingsModal"  style="background-color: #c3bcbc" data-modal-index="2">
                        <div class="modal-dialog coverageCuttings" style="align-content: center">
                            <div class="modal-content coverageCuttings" style="background-color: #d9d1d1;">

                                <div class="modal-header" style="background-color: #c3bcbc">
                                    <button type="button" class="close" data-dismiss="modal"    aria-hidden="true">&times;</button>
                                    <h4 class="modal-title" id="pressCuttingsModalLabel">add coverage cuttings</h4>
                                </div>

                                <div class="modal-body coverageCuttings" style="background-color: #d9d1d1">

                                    <div class="row" style="background-color: #d9d1d1;">
                                        <div class='col-sm-8' style="margin-bottom: 40px">                                
                                            <div class="col-sm-12 center-block"  style="margin-bottom: 40px">   
                                                <output  id="result"  style="border:1px solid black"></output>

                                            </div>
                                        </div>
                                    </div>
                                    <div id="multipleFiles"> 
                                        <p>Please select either one file or multiple files.</p>
                                        <p>For multiple files please press the <strong>Ctrl-key and </strong> then select with your mouse</p></div>
                                </div>

                                <div class="modal-footer coverageCuttings"  style="background-color: #c3bcbc">
                                    <div class="btn btn-primary btn-sm  pull-left upload">
                                        <span>Choose coverage cuttings</span>
                                        <input class="upload" id="files"  name='coverageCuttings' type="file" multiple="multiple"/>

                                    </div>
                                    <!--<button id="addElement" type="button" value="Add another Translator"  class="btn btn-group-sm  button teal pull-left">Add another Translator</button>-->

                                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="backToTranslators();">Done</button>
                                    <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                </div> <!--modal footer -->

                            </div> <!--modal content-->          
                        </div> <!--modal dialog-->
                    </div> <!--modal fade-->
                    <!--<div class="pressCuttings" id="pressCuttings"></div>-->

                    <!--<input type="hidden" value="pressCuttings" name="pressCuttings_image-file" id="label_pressCuttings"/>-->
                    <!--Destination:-->
                    <!--                <input type="hidden" id="originalSample_upload" value="originalSample" name="destination" />         -->
                </form>
                <form class="form-horizontal" 
                      role="form"  
                      autocomplete="on"  
                      action="${pageContext.request.contextPath}/Application" 
                      method="POST" 
                      name="regF"
                      >
                    <input type="hidden" name="userID" value="${userID}">
                    <input type="hidden" name="name" value="${name}">
                    <input type="hidden" name="publisherID" value="${publisherID}">
                    <input type="hidden" name="Company" value="${companyDetails.Company}">
                    <input type="hidden" name="publisherName" value="${companyDetails.Company}">

                    <div class="container col-sm-12" style="margin-bottom: 40px">
                        <input type="submit" id="NewApplication" name="task"  class = "btn btn-default btn-sm" value="Start New Application" />
                        <input type="submit" id="ListOpenApplications" name="task"  class = "btn btn-default btn-sm" value="List Open Applications" />
                        <input type="submit" id="ListPendingApplications" name="task"  class = "btn btn-default btn-sm active" value="List Pending Applications" />
                        <input type="submit" id="ListClosedApplications" name="task"  class = "btn btn-default btn-sm" value="List Closed Applications" />
                    </div>

                </form>


                <!-- footer start -->
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
            &copy; 2019 mgr Software
        </div>
        <script src="js/bootstrap-imageupload.js"></script>

        <script>
            var $imageupload = $('.imageupload');
            $imageupload.imageupload();

            function  showInfoModal() {
                $("#showInfoModal").modal("show");
            }
            function  showNotesModal() {
                $("#showNotesModal").modal("show");
            }
        </script>


    </body>
</html>
