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



        <title>Translation Grant Application System</title>


        <!--JQuery-->
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <!--<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>-->


        <!-- Bootstrap -->

        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

        <!--http://jschr.github.io/bootstrap-modal/bs3.html-->

        <!--        <link href="css/bootstrap-modal-bs3patch.css" rel="stylesheet" />
                <link href="css/bootstrap-modal.css" rel="stylesheet" />-->

        <!--DataTables-->

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/plug-ins/1.10.15/integration/font-awesome/dataTables.fontAwesome.css">


        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.1/css/bootstrap-datepicker.css" />

        <link rel="stylesheet" href="css/lesshat.css" />
        <link rel="stylesheet" href="css/newfile.css" />

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>        
        <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>

        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.js"></script>  

        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"></script>       
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.3.1/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/plug-ins/1.10.12/sorting/datetime-moment.js"></script>
        <script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js "></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/plug-ins/1.10.15/dataRender/datetime.js"></script>
        <script type="text/javascript" language="javascript"  src="js/bootstrap-datepicker.js"></script>
        <script type="text/javascript" language="javascript"  src="js/jquery-ui.js"></script>

        <!--http://jschr.github.io/bootstrap-modal/bs3.html-->

        <!--        <script src="js/bootstrap-modalmanager.js"></script>
                <script src="js/bootstrap-modal.js"></script>-->


        <script>
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
            var i;
            console.log("local storage - welcome_staff.jsp");
            for (i = 0; i < localStorage.length; i++) {
                console.log(localStorage.key(i) + "=[" + localStorage.getItem(localStorage.key(i)) + "]");
            }

            console.log("session storage");
            for (i = 0; i < sessionStorage.length; i++) {
                console.log(sessionStorage.key(i) + "=[" + sessionStorage.getItem(sessionStorage.key(i)) + "]");
            }

        </script>


        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {

                var table = $("#user").DataTable({

                    dom: 'Bfrtip',
                    buttons: [
                        {

                            text: '<i class="fa fa-envelope" style="font-size:24px;color:blue"></i> Email',
                            titleAttr: 'email',
                            action: function (e, node, config) {
                                $('#email').modal('show');
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
//                                $mail = 'mailto: ' + data + '';
//                                console.log($mail);
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


                    var tr = $(this).closest('tr');
                    var row = table.row(tr);
                    var rowdata = (table.row(tr).data());
//                    console.log("rowdata  "  + rowdata.value);

                    $('#usr_name').html("User Details for: " + rowdata.FIRST_NAME + " " + rowdata.LAST_NAME);
                    var mail = 'mailto: ' + rowdata.EMAIL;
                    $('#msg_val').html("Send email to: " + rowdata.FIRST_NAME + " " + rowdata.LAST_NAME);
                    document.getElementById("mails").href = mail;
                    $("#userModal").modal("show");
                    $("#userUname").val($(this).closest('tr').children()[1].textContent); // uname
                    $("#userFirstName").val($(this).closest('tr').children()[2].textContent); // First
                    $("#userLastName").val($(this).closest('tr').children()[3].textContent); // Last
                    $("#userEmail").val($(this).closest('tr').children()[4].textContent); // EMAIL     
//                    var m = $mail;
//                    alert(m);
//                    $("#userEmail").val(m);
                    $("#userFunction").val($(this).closest('tr').children()[5].textContent); // Function
                    $("#userRole").val($(this).closest('tr').children()[6].textContent); // Role
                    console.log(table.row(this).data());
                });
//                console.log(table);

            });
        </script>

        <script type="text/javascript">

            function getTodaysDate() {
                var date = new Date();
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                if (month < 10)
                    month = "0" + month;
                if (day < 10)
                    day = "0" + day;
                var today = day + "/" + month + "/" + year;
                document.getElementById('sampleSentOut1').value = today;
            }
            ;
        </script>
        <!--script for DataTable Modal popup-->
        <script type="text/javascript">
            $(document).ready(function () {
                var table = $('#expReader').DataTable({

                    /**
                     B - Buttons
                     f - filtering input
                     r - processing display element
                     t - The table!
                     p - pagination control
                     
                     **/

                    dom: 'Bfrtip',
                    buttons: [
                        {

                            text: '<i class="fa fa-files-o"></i>',
                            titleAttr: 'email',
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
                            text: '<i class="fa fa-files-o"></i>',
                            titleAttr: 'email',
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
                            "defaultContent": "<i class='fa fa-pencil-square fa-lg'></i>"
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
                        {"data": "Author",
                            "render": function (data, type, full, meta) {

                                //if length = 1 we have just 1 Author ==> display
                                //if length >  we have more than 1 Author ==>
                                // display first Author - put the rest into modal2
                                //     console.log("Author length :" + data.length);
                                if (type === 'display') {
                                    return '<textarea name="Author" rows="2" cols="40">'
                                            + data
                                            + '</textarea>';
                                }
                                return data;
                            }
                        },
                        {"data": "Title"},
//                        {"data": "Publisher"},
                        {"data": "Publisheryear"},
                        {"data": "Genre"},
                        {"data": "translationTitle"},
                        {"data": "translationPublisherYear"},
                        {"data": "Translator",
                            "render": function (data, type, full, meta) {

                                //if length = 1 we have just 1 Translator ==> display
                                //if length >  we have more than 1 Translator ==>
                                // display first Translator - put the rest into modal2
                                //     console.log("Author length :" + data.length);
                                if (type === 'display') {
                                    return '<textarea name="Translator" rows="2" cols="40">'
                                            + data
                                            + '</textarea>';
                                }
                                return data;
                            }},
                        {"data": "Language"},
//                        {"data": "physicalDescription"},
//                        {"data": "Duplicates"},
                        //{"data": "Copies"},
                        {"data": "ISBN"}, //as dummy for Copies
                        {"data": "Notes"},
                        {"data": "ISBN"},
                        {"data": "ISSN"},
                        {"data": "cover",
                            "render": function (data, type, row) {
                                if (typeof (data) === "undefined") {

                                    return '<img src="http://localhost/images/not-available.jpg" width="275" height="275" alt="not-available"/>';
                                } else {
                                    return '<img src="http://localhost' + data + '">';
                                }
                            }}
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

                    var cver = "";
                    var tr = $(this).closest('tr');
                    var row = table.row(tr);
                    var rowdata = (table.row(tr).data());
                    $("#booksModal").modal("show");
                    $("#referenceNumber").val($(this).closest('tr').children()[3].textContent); // ID
                    //  $("#Author").val($(this).closest('tr').children()[4].textContent); // uname

                    var authors = rowdata.Author;
                    $("#Author").val(authors);
                    if (typeof (rowdata.cover) === "undefined") {
                        var cver = 'images/not-available.jpg';
                    } else {
                        var cver = 'http://localhost' + rowdata.cover + '';
                    }

                    $("#bookCover").val(cver);
                    document.getElementById("bookCover").src = cver;
                    $("#Title").val($(this).closest('tr').children()[5].textContent); // First
                    $("#Genre").val($(this).closest('tr').children()[7].textContent); // Last
                    $("#Language").val($(this).closest('tr').children()[11].textContent); // Function
                    $("#ISBN").val($(this).closest('tr').children()[16].textContent); // Role
                    console.log(table.row(this).data());
                });
                $('#books tbody').on('click', 'tr td.btn-control', function () {

                    var cver = "";
                    var tr = $(this).closest('tr');
                    var row = table.row(tr);
                    var rowdata = (table.row(tr).data());
                    $("#editBooksModal").modal("show");
                    $("#referenceNumber2").val($(this).closest('tr').children()[3].textContent); // ID
                    $("#Author2").val($(this).closest('tr').children()[4].textContent); // uname

                    if (typeof (rowdata.cover) === "undefined") {
                        var cver = 'images/not-available.jpg';
                    } else {
                        var cver = 'http://localhost' + rowdata.cover + '';
                    }

                    $("#bookCover").val(cver);
                    document.getElementById("bookCover").src = cver;
                    $("#Title2").val($(this).closest('tr').children()[5].textContent); // First
                    $("#Genre2").val($(this).closest('tr').children()[7].textContent); // Last
                    $("#Language2").val($(this).closest('tr').children()[11].textContent); // Function
                    //      $("#ISBN2").val($(this).closest('tr').children()[16].textContent); // Role

                    console.log(table.row(this).data());
                });
            });
        </script>

        <script type="text/javascript">
            var cntr = 0;
            $(document).ready(function () {
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

                            text: '<i class="fa fa-files-o"></i>',
                            titleAttr: 'email',
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
                        //                {"data": "ApplicationNumber"},
                        //                {"data": "ApplicationYear"},
                        {"data": "ReferenceNumber"},
                        //    {"data": "ReferenceNumber"},

                        {"data": "company"},
                        {"data": "agreement",
                            "render": function (data, type, row) {

                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "contract",
                            "render": function (data, type, row) {

                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "proposedDateOfPublication",
                            "render": function (data) {

                                var date = new Date(data);
                                var month = date.getMonth() + 1;
                                return  date.getDate() + "/" + (month.length < 10 ? month : "0" + month) + "/" + date.getFullYear();
                            }},
                        {"data": "proposedPrintRun"},
                        {"data": "plannedPageExtent"},
                        {"data": "translatorCV",
                            "render": function (data, type, row) {

                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
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
                                return data;
                            }
                        },
                        {"data": "Notes"},
                        {"data": "Status"},
                        {"data": "copiesSent",
                            "render": function (data, type, row) {
                                if (data === 0) {
                                    return 'No';
                                } else {
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

                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
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
                        {"data": "expertReaderName"},
                        {"data": "bookTitle"},
                        //     {"data": "translatorTitles"},
                        {"data": "TranslatorTrack"},
                        {"data": "Titles"},
                        {"data": "translatorCVDocName"},
                        {"data": "cover"},
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
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
//                        {"data": "readerReportSummary"},
                        {"data": "expertReaderList"},
                        {"data": "unassignedExpertReaderList"},
                        {"data": "idTranslator"},
                        {"data": "originalDateOfPublication",
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
                        {"data": "originalLanguage"},
                        {"data": "originalPageExtent"},
                        {"data": "countryOfPublication"},
                        {"data": "foreignPublisher"},
                        {"data": "foreignCountry"},
                        {"data": "targetLanguage"},
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
                                return data;
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
                                return data;
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
                        {"data": "boardComments_Instructions"},
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
                        {"data": "paymentReferenceNumber"},
                        {"data": "addendumRightsAgreement",
                            "render": function (data, type, row) {
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "addendumRightsAgreementName"},
                        {"data": "proofOfPaymentToTranslator",
                            "render": function (data, type, row) {
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "proofOfPaymentToTranslatorName"},
                        {"data": "bankDetailsForm",
                            "render": function (data, type, row) {
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "bankDetailsFormName"},
                        {"data": "SignedLIContract",
                            "render": function (data, type, row) {
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "SignedLIContractName"},
                        {"data": "paymentStatus",
                            "render": function (data, type, row) {
                                if (typeof (data) === "undefined") {
                                    return "n/a";
                                } else
                                    return data;
                            }},
                        {"data": "previousGrantAid"},
                        {"data": "award",
                            "render": function (data, type, row) {
                                return (data === 1) ? '<span class="glyphicon glyphicon-ok"></span>' : '<span class="glyphicon glyphicon-remove"></span>';
                            }
                        },
                        {"data": "salesFigures"},
                        {"data": "original",
                            "render": function (data, type, row) {
                                return '<a href="http://localhost' + data + '"><i class="fa fa-file-text-o" style="font-size:24px;color:blue"></i></a>';
                            }},
                        {"data": "originalName"},
                        {"data": "Author"},
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


//                        {
//                            
//                           targets: [5,6],
//                           visible: false
                        //},
                        {className: "dt-left", "targets": [2, 7, 8, 64]}
                    ]

                });
//                $("#applications tbody").off("click").on("click", 'tr td.details-control', function (e) {
//                    alert("clicked");
////                });

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
                    var awardValue = rowdata.award;
                    console.log("awardValue:  " + awardValue);
                    if (awardValue === 1) {
                        document.getElementById("award").checked = true;
                        console.log("awardValue:  TRUE");
                    } else if (awardValue === 0) {
                        document.getElementById("award").checked = false;
                        console.log("awardValue:  FALSE");
                    }

                    var statii = rowdata.Status;
                    if (statii === 'new') {

                        document.getElementById("appStatus").style.backgroundColor = '#aefca1';
                        document.getElementById("agreement").value = 'new';
                    } else if (statii === 'pending') {

                        document.getElementById("appStatus").style.backgroundColor = '#a1fcef';
                        document.getElementById("agreement").value = 'pending';
                    } else {

                        document.getElementById("appStatus").style.backgroundColor = '#efa1fc';
                        document.getElementById("agreement").value = 'closed';
                    }
                    ;
                    var agreemnt = 'http://localhost' + rowdata.agreement + '';
                    $("#appAgreement").val(agreemnt);
                    document.getElementById("agreement").href = agreemnt;
                    var orig = 'http://localhost' + rowdata.original + '';
                    $("#appOriginal").val(orig);
                    document.getElementById("original").href = orig;
                    var addendumRightsAgreemnt = 'http://localhost' + rowdata.addendumRightsAgreement + '';
                    $("#appAddendumRightsAgreement").val(addendumRightsAgreemnt);
                    document.getElementById("addendumRightsAgreement").href = addendumRightsAgreemnt;
                    var proofOfPaymentToTrans = 'http://localhost' + rowdata.proofOfPaymentToTranslator + '';
                    $("#appProofPaymentToTranslator").val(proofOfPaymentToTrans);
                    document.getElementById("proofPaymentToTranslator").href = proofOfPaymentToTrans;
                    var bankDetailsFrm = 'http://localhost' + rowdata.bankDetailsForm + '';
                    $("#appBankDetailsForm").val(bankDetailsFrm);
                    document.getElementById("bankDetailsForm").href = bankDetailsFrm;
                    var signedLIContr = 'http://localhost' + rowdata.SignedLIContract + '';
                    $("#appSignedLIContract").val(signedLIContr);
                    document.getElementById("signedLIContract").href = signedLIContr;
                    if (typeof (rowdata.cover) === "undefined") {
                        var cver = 'images/not-available.jpg';
                    } else {
                        var cver = 'http://localhost' + rowdata.cover + '';
                    }

                    $("#cover").val(cver);
                    document.getElementById("cover").src = cver;
                    var contr = 'http://localhost' + rowdata.contract + '';
                    document.getElementById("contract").href = contr;
                    var trans = 'http://localhost' + rowdata.translatorCV + '';
                    document.getElementById("translatorCV").href = trans;
                    var transSamp = 'http://localhost' + rowdata.copiesTranslationSample + '';
                    document.getElementById("copiesTranslationSample").href = transSamp;
                    $("#applicationsModal").modal("show");
                    $('#applications').DataTable().ajax.reload();
                    $("#appApplicationNumber").val($(this).closest('tr').children()[1].textContent);
                    $("#appApplicationYear").val($(this).closest('tr').children()[2].textContent);
                    $("#appReferenceNumber").val($(this).closest('tr').children()[1].textContent);  //ok
                    $("#appCompany").val($(this).closest('tr').children()[2].textContent);  //ok
//                    $("#appAgreement").val($(this).closest('tr').children()[5].textContent);

                    var appReferenceNumber = rowdata.ReferenceNumber;
                    // console.log("appReferenceNumber " + appReferenceNumber);
                    $("#unassignedERRefNo").val(appReferenceNumber);
                    var TranslName = rowdata.TranslatorName;
                    $("#TranslatorName").val(TranslName);
                    var bookTitles = rowdata.Titles;
                    $("#currentItem").val(bookTitles.join(""));
                    //        console.log("bookTitles: " + bookTitles);

                    // Generate table translatorTrackTable
                    var TranslTitles = rowdata.TranslatorTrack;
                    //            console.log("TranslTitles:  TranslatorTrack::   " + TranslTitles);

                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#translTrackDiv').empty(); // empty the div before fetching and adding new data

                    var myTableDiv = document.getElementById("translTrackDiv");
                    var tble = document.createElement('TABLE');
                    tble.id = 'translatorTrackTable';
                    tble.border = '1';
                    tble.width = '100%';
                    tble.title = 'translatorTrackTable';
                    tble.className = "table table-striped table-condensed small";
                    tble.style = 'overflow-x: auto;';
                    var tableBody = document.createElement('TBODY');
                    var translatorTrack = [];

                    for (var i = 0; i < TranslTitles.length; ++i) {
                        for (var j = 0; j < TranslTitles[i].length; ++j) {

                            //           console.log("before TranslTitles[" + i + "][" + j + "] " + TranslTitles[i][j]);


                            // skip undefined values to preserve sparse array
                            if (TranslTitles[i][j] === undefined)
                                continue;
                            // create row if it doesn't exist yet
                            if (translatorTrack[j] === undefined)
                                translatorTrack[j] = [];
                            // swap the x and y coords for the copy
                            translatorTrack[j][i] = TranslTitles[i][j];

                            //   console.log("after --- transformation translatorTrack[" + i + "][" + j + "] " + translatorTrack[i][j]);
                        }

                    }

                    var idx = 0;
                    //TABLE ROWS
                    for (i = 0; i < TranslTitles.length; i++) {
                        var tr = document.createElement('TR');
                        for (j = 0; j < TranslTitles[i].length; j++) {
                            var td = document.createElement('TD');
                            var td2 = document.createElement('TD');


                            td.width = '50%';
                            td2.width = '50%';

                            if (j === 0) {

                                var th = document.createElement('TH');
                                th.style = 'text-align:center';
                                th.className = 'highlightHeader';
                                th.colspan = '2';
                                th.appendChild(document.createTextNode(TranslTitles[i][j]));
                                tr.appendChild(th);

                                var th = document.createElement('TH');
                                th.className = 'highlightHeader';
                                th.appendChild(document.createTextNode(''));
                                tr.appendChild(th);

                                tableBody.appendChild(tr);


                                var heading = ["Author(s)", "Title(s)"];
                                var tr = document.createElement('TR');
                                for (var col = 0; col < heading.length; col++)
                                {
                                    var th2 = document.createElement('TH');
                                    th2.style = 'text-align:center';
                                    th2.width = '50%';
                                    th2.appendChild(document.createTextNode(heading[col]));
                                    tr.appendChild(th2);
                                }
                                tableBody.appendChild(tr);
                                continue;
                            }
                            // remove "undefined" cells
                            if (typeof (TranslTitles[i][j]) === "undefined") {
                                TranslTitles[i][j] = '';
                            }

                            var tr = document.createElement('TR');

                            td.width = '50%';
                            td2.width = '50%';
                            td.style = 'text-align:left';
                            td2.style = 'text-align: left';

                            var record = TranslTitles[i][j];
                            var Author = record[0];
                            var Title = record[1];
                            //      console.log("Author  :  " + Author);
                            //      console.log("Title  :  " + Title);
                            //       console.log("idx " + idx);
                            idx++;

                            td.appendChild(document.createTextNode(Author));
                            td2.appendChild(document.createTextNode(Title));

                            tr.appendChild(td);
                            tr.appendChild(td2);

                            tableBody.appendChild(tr);
                        }

                    }

                    tble.appendChild(tableBody);
                    myTableDiv.appendChild(tble);



                    for (i = 0; i < translatorTrack.length; i++) {
                        for (j = 0; j < translatorTrack[i].length; j++) {

                            // get translators
                            if (i === 0) {
                                var newdiv = $('<div>', {class: 'text-left', text: translatorTrack[i][j]});
                                var a = document.createElement('a');
                                var linkText = document.createTextNode("  see Trackrecord");

                                a.appendChild(linkText);
                                a.title = "see Trackrecord";
                                a.class = "button";
                                a.href = "#stack2";
                                newdiv.append(a);
                            }
                            $('#testcontainer').find('a').attr('data-toggle', 'modal');
                            $('#testcontainer').append(newdiv);

                            //print track record
                            if (i !== 0) {
                                // console.log("translatorTrack[" + i + " ][ " + j + " ] :  " + translatorTrack[i][j]);
                            }
                        }
                    }

                    var expertReaderName = rowdata.expertReaderList;

                    document.getElementById("unassignedERRefNo").value = appReferenceNumber;
                    document.getElementById("NewAssignedERRefNo").value = appReferenceNumber;
                    /*
                     * get the whole List with the arrays  
                     * no of arrays = expertReaderName.length
                     */
                    // alert(cntr);

                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#additionalExpertReader').empty(); // empty the div before fetching and adding new data

                    if (cntr === 1) {


                        //   var addExpertReaderModalDiv = document.getElementById("translTrackDiv");
                        for (var i = 0; i < expertReaderName.length; ++i) {
                            /*
                             * build the link buttons in the listAssignedEReadermodal
                             */



                            var addExpertReaderTag = '';
                            addExpertReaderTag += '<div class="col-md-8" style="margin-bottom: 20px">';
                            addExpertReaderTag += '<button class="btn btn-success btn-xs pull-left" style="margin-bottom: 20px;" data-toggle="modal" data-target="#listAssignedEReadermodal' + i + '">';
                            addExpertReaderTag += 'Assigned Expert Reader for Reference: ' + expertReaderName[i][1] + "<br/> - <u>" + expertReaderName[i][6];
                            addExpertReaderTag += '</u></button>';
                            addExpertReaderTag += '</div>';
                            $(addExpertReaderTag).appendTo('#additionalExpertReader');
//                        var addExpertReaderModal = '';
                            //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
//                                $('#additionalExpertReaderModal').empty();  // empty the div before fetching and adding new data
                            var addExpertReaderModal = document.getElementById("additionalExpertReaderModal");
                            addExpertReaderModal = '';
//                        console.log("i  " + i);
                            var z = i + 4;
                            addExpertReaderModal += '<div class="modal fade" id="listAssignedEReadermodal' + i + '" data-modal-index="' + z + '">';
                            addExpertReaderModal += '<div class="modal-dialog">';
                            addExpertReaderModal += '<div class="modal-content">';
                            addExpertReaderModal += '<div class="modal-header" style="background-color: #c3bcbc">';
                            addExpertReaderModal += '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>';
                            addExpertReaderModal += '<h4 class="modal-title">Assigned Expert Reader</h4>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '<div class="modal-body" style="background-color: #d9d1d1">';
                            addExpertReaderModal += '<div class="row" style="margin-bottom: 20px;margin-top: 5px"> ';
                            addExpertReaderModal += '<div class="col-sm-6">';
                            addExpertReaderModal += '<strong class="pull-left">Expert Reader</strong>';
                            addExpertReaderModal += '<div class="input-group pull-left">';
                            var ExpertReader = "appExpertReader" + i;
//                        console.log("ExpertReader  " + ExpertReader);
                            addExpertReaderModal += '<input type="text" name="appExpertReader' + i + '"';
                            addExpertReaderModal += ' id="appExpertReader' + i + '" class="form-control" />';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += ' </div> ';
                            addExpertReaderModal += '<div class="row" style="margin-top: 30px;margin-bottom: 10px">';
                            addExpertReaderModal += '<div class="col-sm-4">';
                            addExpertReaderModal += '<strong class=" pull-left"> Sample sent out</strong>';
                            addExpertReaderModal += '<div class="input-group pull-left">';
                            var sampleSentOut = "sampleSentOut" + i;
//                        console.log("sampleSentOut  " + sampleSentOut);
                            addExpertReaderModal += '<input type="text" name="sampleSentOut' + i + '" id="sampleSentOut' + i + '" class="form-control" placeholder="DD/MM/YYYY" /> ';
                            addExpertReaderModal += '<label class="input-group-addon" for="sampleSentOut' + i + '">';
                            addExpertReaderModal += '<span class="glyphicon glyphicon-calendar"></span>';
                            addExpertReaderModal += '</label>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += ' </div>';
                            addExpertReaderModal += '<div class="col-sm-4">';
                            addExpertReaderModal += '<strong class=" pull-left"> Sample returned</strong>';
                            addExpertReaderModal += '<div class="input-group pull-left">';
                            var sampleReturned = "sampleReturned" + i;
//                        console.log("sampleReturned  " + sampleReturned);
                            addExpertReaderModal += '<input type="text" name="sampleReturned' + i + '" id="' + sampleReturned + '" class="form-control" placeholder="DD/MM/YYYY" />';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '<div class="row" style="margin-bottom: 20px;">';
                            addExpertReaderModal += '<div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">';
                            addExpertReaderModal += '<div class="col-sm-2">';
                            addExpertReaderModal += '<input id="ReadersReport' + i + '"';
                            addExpertReaderModal += 'type="hidden"';
                            addExpertReaderModal += 'name="ReadersReport"';
                            addExpertReaderModal += ' >';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '<a class="btn btn-info" role="button" id="appReadersReport' + i + '">';
                            addExpertReaderModal += '<span class="glyphicon glyphicon-file"></span>';
                            addExpertReaderModal += 'Reader’s Report</a>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '<div class="col-sm-10">';
                            addExpertReaderModal += '<label for="readerReportSummary' + i + '" class="control-label pull-left"> Reader’s Report Summary</label>';
                            addExpertReaderModal += '<textarea id="readerReportSummary' + i + '" ';
                            addExpertReaderModal += 'class="form-control"';
                            addExpertReaderModal += 'name="readerReportSummary' + i + '" ';
                            addExpertReaderModal += 'style="height: 98px"';
                            addExpertReaderModal += '>';
                            addExpertReaderModal += '</textarea>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '<div class="modal-footer"  style="background-color: #c3bcbc">';
                            addExpertReaderModal += '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>';
                            addExpertReaderModal += '<button type="button" class="btn btn-primary">Save changes</button>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';
                            addExpertReaderModal += '</div>';

                            $(addExpertReaderModal).appendTo('#additionalExpertReaderModal');
                            /* 
                             * get the data from the array
                             */

                            for (var j = 0; j <= 6; ++j) {

                                var ExpReader = expertReaderName[i][6];
                                var expertReaderlElementID = "appExpertReader" + i;
                                document.getElementById(expertReaderlElementID).value = ExpReader;
                                var sampleSentOut = expertReaderName[i][3];
                                var sampleSentOutElementID = "sampleSentOut" + i;
                                document.getElementById(sampleSentOutElementID).value = sampleSentOut;
                                var samplReturned = expertReaderName[i][4];
                                var samplReturnedElementID = "sampleReturned" + i;
                                document.getElementById(samplReturnedElementID).value = samplReturned;
                                var readerSummaryReport = expertReaderName[i][5];
                                var readersSummaryReportElementID = "readerReportSummary" + i;
                                document.getElementById(readersSummaryReportElementID).value = readerSummaryReport;
                                var readerReportLink = 'http://localhost' + expertReaderName[i][2] + '';
                                var readersReportElementID = "appReadersReport" + i;
                                document.getElementById(readersReportElementID).href = readerReportLink;
                            }
                        }
                    }


                    //Get all Expert Readers that are not assigned at the moment
                    var unassignedExpertReaderList = rowdata.unassignedExpertReaderList;

                    var select = document.getElementById("selectUnassignedER");
                    // Optional: Clear all existing options first:
                    select.innerHTML = "";
                    // Populate list with options:
                    var defaultSelect = "Select Expert Reader";
                    //set default
                    select.innerHTML += "<option value=\"" + defaultSelect + "\">" + defaultSelect + "</option>";
                    for (var i = 0; i < unassignedExpertReaderList.length; i++) {
                        var opt = unassignedExpertReaderList[i];
                        select.innerHTML += "<option value=\"" + opt + "\">" + opt + "</option>";
                    }

                    $("#appcontract").val(contr);
                    $("#appproposedDateOfPublication").val($(this).closest('tr').children()[5].textContent);
                    $("#appproposedPrintRun").val($(this).closest('tr').children()[6].textContent);
                    $("#appplannedPageExtent").val($(this).closest('tr').children()[7].textContent);
                    $("#appnumberOfPages").val($(this).closest('tr').children()[11].textContent);
                    $("#appfeePerPage").val($(this).closest('tr').children()[10].textContent);
                    $("#apptranslatorFee").val($(this).closest('tr').children()[11].textContent);   //ok
                    $("#appNotes").val($(this).closest('tr').children()[12].textContent);
                    $("#appStatus").val($(this).closest('tr').children()[13].textContent);  //ok
                    $("#appcopiesSent").val($(this).closest('tr').children()[14].textContent);
                    $("#appdateCopiesWereSent").val($(this).closest('tr').children()[15].textContent);
                    $("#appTC_ACCEPTED").val($(this).closest('tr').children()[17].textContent);
                    $("#appAPPROVED").val($(this).closest('tr').children()[18].textContent);
                    $("#appGenre").val($(this).closest('tr').children()[19].textContent);
                    $("#appExpertReader").val($(this).closest('tr').children()[21].textContent);
                    $("#appBookTitle").val($(this).closest('tr').children()[22].textContent);   //ok
                    $("#expertReaderName").val($(this).closest('tr').children()[22].textContent);
                    $("#sampleSentOut").val($(this).closest('tr').children()[27].textContent);
                    $("#sampleReturned").val($(this).closest('tr').children()[28].textContent);
                    $("#appReadersReport").val($(this).closest('tr').children()[29].textContent);
//                    $("#readerReportSummary").val($(this).closest('tr').children()[32].textContent);

                    $("#appDateOfPublicationOriginal").val($(this).closest('tr').children()[33].textContent);
                    $("#appLanguageOriginal").val($(this).closest('tr').children()[34].textContent);
                    $("#appPageExtentOriginal").val($(this).closest('tr').children()[35].textContent);
                    $("#appCountryOfPublication").val($(this).closest('tr').children()[36].textContent);
                    $("#appForeignPublisher").val($(this).closest('tr').children()[37].textContent);
                    $("#appForeignCountry").val($(this).closest('tr').children()[38].textContent);
                    $("#appTargetLanguage").val($(this).closest('tr').children()[39].textContent);
                    $("#amountRequested").val($(this).closest('tr').children()[41].textContent);
                    $("#previousGrantAid").val($(this).closest('tr').children()[59].textContent);

                    $("#award").val($(this).closest('tr').children()[60].textContent);
                    $("#salesFigures").val($(this).closest('tr').children()[61].textContent);
                    $("#authorList").val($(this).closest('tr').children()[64].textContent);
                    console.log(table.row(this).data());

                    console.log("12345 1 " + $(this).closest('tr').children()[1].textContent);
                    console.log("12345 2 " + $(this).closest('tr').children()[2].textContent);
                    console.log("12345 3 " + $(this).closest('tr').children()[3].textContent);
                    console.log("12345 4 " + $(this).closest('tr').children()[4].textContent);
                    console.log("12345 5 " + $(this).closest('tr').children()[5].textContent);
                    console.log("12345 6 " + $(this).closest('tr').children()[6].textContent);
                    console.log("12345 7 " + $(this).closest('tr').children()[7].textContent);
                    console.log("12345 8 " + $(this).closest('tr').children()[8].textContent);
                    console.log("12345 9 " + $(this).closest('tr').children()[9].textContent);
                    console.log("12345 10 " + $(this).closest('tr').children()[10].textContent);

                    console.log("12345 11 " + $(this).closest('tr').children()[11].textContent);
                    console.log("12345 12 " + $(this).closest('tr').children()[12].textContent);
                    console.log("12345 13 " + $(this).closest('tr').children()[13].textContent);
                    console.log("12345 14 " + $(this).closest('tr').children()[14].textContent);
                    console.log("12345 15 " + $(this).closest('tr').children()[15].textContent);
                    console.log("12345 16 " + $(this).closest('tr').children()[16].textContent);
                    console.log("12345 17 " + $(this).closest('tr').children()[17].textContent);
                    console.log("12345 18 " + $(this).closest('tr').children()[18].textContent);
                    console.log("12345 19 " + $(this).closest('tr').children()[19].textContent);
                    console.log("12345 20 " + $(this).closest('tr').children()[20].textContent);

                    console.log("12345 21 " + $(this).closest('tr').children()[21].textContent);
                    console.log("12345 22 " + $(this).closest('tr').children()[22].textContent);
                    console.log("12345 23 " + $(this).closest('tr').children()[23].textContent);
                    console.log("12345 24 " + $(this).closest('tr').children()[24].textContent);
                    console.log("12345 25 " + $(this).closest('tr').children()[25].textContent);
                    console.log("12345 26 " + $(this).closest('tr').children()[26].textContent);
                    console.log("12345 27 " + $(this).closest('tr').children()[27].textContent);
                    console.log("12345 28 " + $(this).closest('tr').children()[28].textContent);
                    console.log("12345 29 " + $(this).closest('tr').children()[29].textContent);
                    console.log("12345 30 " + $(this).closest('tr').children()[30].textContent);

                    console.log("12345 31 " + $(this).closest('tr').children()[31].textContent);
                    console.log("12345 32 " + $(this).closest('tr').children()[32].textContent);
                    console.log("12345 33 " + $(this).closest('tr').children()[33].textContent);
                    console.log("12345 34 " + $(this).closest('tr').children()[34].textContent);
                    console.log("12345 35 " + $(this).closest('tr').children()[35].textContent);
                    console.log("12345 36 " + $(this).closest('tr').children()[36].textContent);
                    console.log("12345 37 " + $(this).closest('tr').children()[37].textContent);
                    console.log("12345 38 " + $(this).closest('tr').children()[38].textContent);
                    console.log("12345 39 " + $(this).closest('tr').children()[39].textContent);
                    console.log("12345 40 " + $(this).closest('tr').children()[40].textContent);


                    console.log("12345 41 " + $(this).closest('tr').children()[41].textContent);
                    console.log("12345 42 " + $(this).closest('tr').children()[42].textContent);
                    console.log("12345 43 " + $(this).closest('tr').children()[43].textContent);
                    console.log("12345 44 " + $(this).closest('tr').children()[44].textContent);
                    console.log("12345 45 " + $(this).closest('tr').children()[45].textContent);
                    console.log("12345 46 " + $(this).closest('tr').children()[46].textContent);
                    console.log("12345 47 " + $(this).closest('tr').children()[47].textContent);
                    console.log("12345 48 " + $(this).closest('tr').children()[48].textContent);
                    console.log("12345 49 " + $(this).closest('tr').children()[49].textContent);
                    console.log("12345 50 " + $(this).closest('tr').children()[50].textContent);

                    console.log("12345 51 " + $(this).closest('tr').children()[51].textContent);
                    console.log("12345 52 " + $(this).closest('tr').children()[52].textContent);
                    console.log("12345 53 " + $(this).closest('tr').children()[53].textContent);
                    console.log("12345 54 " + $(this).closest('tr').children()[54].textContent);
                    console.log("12345 55 " + $(this).closest('tr').children()[55].textContent);
                    console.log("12345 56 " + $(this).closest('tr').children()[56].textContent);
                    console.log("12345 57 " + $(this).closest('tr').children()[57].textContent);
                    console.log("12345 58 " + $(this).closest('tr').children()[58].textContent);
                    console.log("12345 59 " + $(this).closest('tr').children()[59].textContent);
                    console.log("12345 60 " + $(this).closest('tr').children()[60].textContent);

                    console.log("12345 61 " + $(this).closest('tr').children()[61].textContent);
                    console.log("12345 62 " + $(this).closest('tr').children()[62].textContent);
                    console.log("12345 63 " + $(this).closest('tr').children()[63].textContent);
                    console.log("12345 64 " + $(this).closest('tr').children()[64].textContent);
                    console.log("12345 65 " + $(this).closest('tr').children()[65].textContent);
                    console.log("12345 66 " + $(this).closest('tr').children()[66].textContent);
                    console.log("12345 67 " + $(this).closest('tr').children()[67].textContent);
                    console.log("12345 68 " + $(this).closest('tr').children()[68].textContent);
                    console.log("12345 69 " + $(this).closest('tr').children()[69].textContent);
                    console.log("12345 70 " + $(this).closest('tr').children()[70].textContent);




                });
            });
        </script>

        <script type="text/javascript">

            //             Stacked modals
            //             https://codepen.io/anon/pen/ZJgLGz

            $('.btn[data-toggle=modal]').on('click', function () {
                var $btn = $(this);
                var currentDialog = $btn.closest('.modal-dialog'),
                        targetDialog = $($btn.attr('data-target'));
                ;
                if (!currentDialog.length)
                    return;
                targetDialog.data('previous-dialog', currentDialog);
                currentDialog.addClass('aside');
                var stackedDialogCount = $('.modal.in .modal-dialog.aside').length;
                if (stackedDialogCount <= 5) {
                    currentDialog.addClass('aside-' + stackedDialogCount);
                }
            });
            $('.modal').on('hide.bs.modal', function () {
                var $dialog = $(this);
                var previousDialog = $dialog.data('previous-dialog');
                if (previousDialog) {
                    previousDialog.removeClass('aside');
                    $dialog.data('previous-dialog', undefined);
                }
            });</script>

        <style>
            .ui-datepicker { 
                width: 17em; 
                padding: .2em .2em 0; 
                display: none; 
                position: relative; z-index: 100000 !important;
                /*z-index: 2000 !important;*/
            }

            /*.ui-datepicker-calendar a.ui-state-default { background: cyan; }*/
            .ui-datepicker-calendar td.ui-datepicker-today a { background: lime; } 
            .ui-datepicker-calendar a.ui-state-hover { background: yellow; } 
            .ui-datepicker-calendar a.ui-state-active { background: red; } 

            .highlightHeader {
                background:yellow;
                /*      background-color:#d9d1d1;*/
            }
            table#translatorTrackTable{
                border: 1px solid black;
            }

            /*https://designshack.net/articles/css/joshuajohnson-2/*/

            /*GROW*/
            .grow img {
                height: 300px;
                width: 300px;

                -webkit-transition: all 1s ease;
                -moz-transition: all 1s ease;
                -o-transition: all 1s ease;
                -ms-transition: all 1s ease;
                transition: all 1s ease;
            }

            .grow img:hover {
                width: 400px;
                height: 400px;
            }
        </style>

        <!--get selectpicker selection--> 
        <script type="text/javascript">
            $(document).ready(function () {
                $('.selectpicker').on('change', function () {
                    var selected = $(this).find("option:selected").val();
                });
            });</script>

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
                overflow-x:scroll;
            }

            /*https://stackoverflow.com/questions/10476632/how-to-scroll-the-page-when-a-modal-dialog-is-longer-than-the-screen*/
            .modal-body {
                max-height: calc(100vh - 210px);
                overflow-y: auto;
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
            .img {
                max-width: 40%;
                height: auto;
                display: block;
                margin: auto;
                width: auto\9; /* ie8 */
            }
            .ImageBorder
            {
                border-width: 1px;
                border-color: Black;
            }

            .h4{
                font-size: 14px;
                line-height: 14px;
            }

            .box .box-header{
                background: #36a9e1;
                color: white;
                font-size: 16px;
                overflow: hidden;
                border-radius: 2px 2px 0 0;
            }

            .onlytableScroll{
                overflow-x:scroll;
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


        <script type="text/javascript">
            function pressCuttingsModal() {
                $("#pressCuttingsModal").modal("show");
            }
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
            });</script>


        <!--if Publisher selected display publisherBox-->
        <script type="text/javascript">
            function selectER() {
                var selectBox = document.getElementById("selectUnassignedER");
                var selectedValue = selectBox.options[selectBox.selectedIndex].value;
                alert("selectedValue " + selectedValue);
                document.getElementById("selectUnassignedER").value = selectedValue;
                document.getElementById("selectedUnassignedER").value = selectedValue;
            }
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

                <h1 align="center" style="align-content: center">Translation Grant Application System for Literature Ireland</h1>

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
                                <li role="tab" class="active"><a href="#Application" data-toggle="tab">Application Management</a></li>
                                <li role="tab" ><a href="#User" data-toggle="tab">User Management</a></li>
                                <li role="tab" ><a href="#Contracts" data-toggle="tab">Contracts</a></li>
                                <li role="tab" ><a href="#ExpertReader" data-toggle="tab">Expert Reader</a></li>
                                <li role="tab" ><a href="#Library" data-toggle="tab">Library</a></li>
                                <li role="tab" ><a href="#Genres" data-toggle="tab">Genres</a></li>
                                <li role="tab" ><a href="#Queries" data-toggle="tab">Queries</a></li>
                            </ul>
                        </div><!-- /.navbar-collapse -->
                        <!-- Tab panes -->
                        <div class="tab-content" >

                            <!--Application-->
                            <div class="tab-pane fade  active in" id="Application">
                                <div class="container-fluid" style="margin-top: 40px; margin-bottom: 60px">

                                    <div class="table-responsive">
                                        <table id="applications" class="table display table-striped table-bordered  dt-responsive " width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th class="details-control"></th>   
                                                    <!-- <th class="all">Application<br/>  Nr</th>
                                                     <th class="all">Application<br/>  Year</th>-->
                                                    <th class="all">Reference<br/>  No</th>
                                                    <th class="all">Publisher</th>       
                                                    <!--<th class="all">PublisherID</th>-->
                                                    <!--<th class="all">userID</th>-->
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
                                                    <th class="all select-filter">Status</th>
                                                    <th class="never">Copies <br/> Sent</th>
                                                    <th class="never">Date Copies  <br/> Were Sent</th>
                                                    <th class="never">Copies of  <br/> Translation Sample</th>
                                                    <th class="never">T&C has been <br/> Accepted</th>
                                                    <th class="never">Approved</th> 
                                                    <th class="never">Genre</th>   
                                                    <th class="never"></th>
                                                    <th class="never">Expert Reader</th>
                                                    <th class="all">Book title</th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="all">Author(s)</th>
                                                    <th class="never"></th>
                                                </tr>
                                            </thead>

                                            <tfoot>
                                                <tr>
                                                    <th class="details-control"></th>   
                                                    <!-- <th class="all">Application<br/>  Nr</th>
                                                     <th class="all">Application<br/>  Year</th>-->
                                                    <th class="all">Reference<br/>  No</th>
                                                    <th class="all">Publisher</th>       
                                                    <!--<th class="all">PublisherID</th>-->
                                                    <!--<th class="all">userID</th>-->
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
                                                    <th class="all select-filter">Status</th>
                                                    <th class="never">Copies <br/> Sent</th>
                                                    <th class="never">Date Copies  <br/> Were Sent</th>
                                                    <th class="never">Copies of  <br/> Translation Sample</th>
                                                    <th class="never">T&C has been <br/> Accepted</th>
                                                    <th class="never">Approved</th> 
                                                    <th class="never">Genre</th>   
                                                    <th class="never"></th>
                                                    <th class="never">Expert Reader</th>
                                                    <th class="all">Book title</th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="never"></th>    
                                                    <th class="never"></th>
                                                    <th class="never"></th>
                                                    <th class="all">Author(s)</th>
                                                    <th class="never"></th>
                                                </tr>
                                            </tfoot>
                                            <tbody>
                                                <!-- Main Grid -->  
                                            </tbody>
                                        </table>
                                    </div>                   
                                </div> <!-- container-fluid -->  

                                <div class="modal fade" id="applicationsModal" data-modal-index="1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header" style="background-color: #c3bcbc">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                <h4 class="modal-title">Applications</h4>
                                            </div>
                                            <div class="modal-body" style="background-color: #d9d1d1">

                                                <ul class="nav nav-tabs" id="tabContent">
                                                    <li class="active"><a href="#page1" data-toggle="tab">Original <br/>and Contracts</a></li>
                                                    <li><a href="#page2" data-toggle="tab">Publisher <br/>and Translation</a></li>
                                                    <li><a href="#page3" data-toggle="tab">Reader’s  <br/>Report</a></li>
                                                    <li><a href="#page4" data-toggle="tab">Board  <br/>Meeting</a></li>
                                                    <li><a href="#page5" data-toggle="tab">Contract <br/> &nbsp;</a></li>

                                                </ul>

                                                <div class="tab-content">

                                                    <div class="tab-pane active" id="page1">

                                                        <!--Original and Contracts-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">
                                                            <div class="col-sm-4">
                                                                <label for="appReferenceNumber" class="control-label pull-left">Reference Number</label>
                                                                <input  id="appReferenceNumber" 
                                                                        type="text"                                                  
                                                                        class="form-control"    
                                                                        name="appReferenceNumber"    
                                                                        >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="appStatus" class="control-label pull-left">Status</label>
                                                                <input id="appStatus"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appStatus"                                
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">
                                                            <div class="col-sm-8">
                                                                <label for="appBookTitle" class="control-label pull-left">Book Title</label>
                                                                <input  id="appBookTitle" 
                                                                        type="text"                                                  
                                                                        class="form-control"    
                                                                        name="appBookTitle"    
                                                                        >
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">
                                                            <div class="col-sm-8">
                                                                <label for="authorList" class="control-label pull-left">Author(s)</label>
                                                                <input  id="authorList" 
                                                                        type="text"                                                  
                                                                        class="form-control"    
                                                                        name="authorList"    
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
                                                        </div> <!--row-->

                                                        <div class="row">
                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">
                                                                <div class="col-sm-2">                                                        
                                                                    <input id="appAgreement"
                                                                           type="hidden"        
                                                                           class="form-control"  
                                                                           name="appAgreement"         
                                                                           >
                                                                </div> 

                                                                <a class="btn btn-info" role="button" id="agreement" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Agreement</a>
                                                            </div>

                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                                <div class="col-sm-2">
                                                                    <input id="appcontract" 
                                                                           type="hidden"     
                                                                           name="appcontract"  
                                                                           >
                                                                </div>

                                                                <a class="btn btn-info" role="button" id="contract" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Contract</a>
                                                            </div>
                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                                <div class="col-sm-2">
                                                                    <input id="apptranslatorCV"
                                                                           type="hidden"                                                             
                                                                           name="apptranslatorCV"                                
                                                                           >
                                                                </div>
                                                                <a class="btn btn-info" role="button" id="translatorCV" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Translator CV</a>
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row">
                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                                <div class="col-sm-2">
                                                                    <input id="appOriginal"
                                                                           type="hidden"                                                             
                                                                           name="appOriginal"                                
                                                                           >
                                                                </div>
                                                                <a class="btn btn-info" role="button" id="original" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Original Work</a>
                                                            </div>


                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">  
                                                                <div class="col-sm-2">
                                                                    <input id="appcopiesTranslationSample"                                
                                                                           type="hidden"                                                            
                                                                           name="appcopiesTranslationSample"                                
                                                                           >
                                                                </div>
                                                                <a class="btn btn-info" role="button" id="copiesTranslationSample" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Translation Sample</a>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label for="appDateOfPublicationOriginal" class="control-label pull-left">Year of publication <br/>(of the original)</label>
                                                                <input id="appDateOfPublicationOriginal"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appDateOfPublicationOriginal"                                
                                                                       >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="appPageExtentOriginal" class="control-label pull-left">Page extent <br/>(of the original)</label>
                                                                <input  id="appPageExtentOriginal" 
                                                                        name="appPageExtentOriginal" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>
                                                        </div> <!--row-->


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-4">        
                                                                <label for="appCountryOfPublication" class="control-label pull-left">Country of publication <br/>(of the original)</label>
                                                                <input id="appCountryOfPublication"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appCountryOfPublication"                                
                                                                       >
                                                            </div>

                                                            <div class="col-sm-4">
                                                                <label for="appLanguageOriginal" class="control-label pull-left">&nbsp;<br/>Language <br/>(of the original)</label>
                                                                <input  id="appLanguageOriginal" 
                                                                        name="appLanguageOriginal" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>


                                                            <div class="col-sm-4">        
                                                                <label for="appGenre" class="control-label pull-left">&nbsp;<br/> Genre<br/>&nbsp;</label>
                                                                <input id="appGenre"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appGenre"                                
                                                                       >
                                                            </div>

                                                        </div> <!--row-->

                                                        <!--third row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label for="appcopiesSent" class="control-label pull-left">Has copy been sent?</label>
                                                                <input id="appcopiesSent"
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appcopiesSent"                                
                                                                       >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="appdateCopiesWereSent" class="control-label pull-left">Date copy was sent</label>
                                                                <input id="appdateCopiesWereSent"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appdateCopiesWereSent"                                
                                                                       >
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
                                                        </div> <!--row-->
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">   

                                                            <div class="col-sm-12">
                                                                <label for="appNotesAboutApplication" class="control-label pull-left">Notes about Application</label>
                                                                <textarea id="appNotesAboutApplication" 
                                                                          class="form-control"                                               
                                                                          name="appNotesAboutApplication"    
                                                                          style="height: 98px"
                                                                          >                 
                                                                </textarea>
                                                            </div>

                                                        </div> <!--row-->

                                                    </div> <!--tab-pane" id="page 1" -->

                                                    <div class="tab-pane" id="page2">

                                                        <!--Publisher and Translation-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label for="appForeignPublisher" class="control-label pull-left">Target publisher</label>
                                                                <input id="appForeignPublisher"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appForeignPublisher"                                
                                                                       >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="appForeignCountry" class="control-label pull-left">Target country </label>
                                                                <input  id="appForeignCountry" 
                                                                        name="appForeignCountry" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>

                                                            <div class="col-sm-4">        
                                                                <label for="appTargetLanguage" class="control-label pull-left"> Target language</label>
                                                                <input id="appTargetLanguage"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appTargetLanguage"                                
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">
                                                            <div class="col-lg-12">
                                                                <div class="pull-left">
                                                                    <div class="box">
                                                                        <div class="box-header">
                                                                            <h4 class="marginLeft">                                                                                
                                                                                Track record for Translator(s):  
                                                                            </h4>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-sm-8">
                                                                <div id="translTrackDiv" class="table-responsive">

                                                                </div>
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-8">
                                                                <label for="appfeePerPage" class="control-label pull-left">Break-down of translator(s)'s fee</label>
                                                                <!--<div class="input-group" style="margin-bottom: 40px">-->
                                                                <textarea id="appfeePerPage"  class="form-control" name="appfeePerPage" style="height: 98px"></textarea>
                                                                <!--</div>-->
                                                            </div>


                                                            <div class="col-sm-4">
                                                                <label for="apptranslatorFee" class="control-label pull-left">Translator(s)'s fee</label>
                                                                <div class="input-group" style="margin-bottom: 40px">                                                               
                                                                    <label class="input-group-addon" for="apptranslatorFee">                                                           
                                                                        <span class="glyphicon glyphicon-euro"></span>                                     
                                                                    </label>
                                                                    <input type="text" class="form-control" name="apptranslatorFee" id="apptranslatorFee" placeholder="fee">    
                                                                </div>
                                                            </div>
                                                        </div> <!--row-->


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 

                                                            <div class="col-sm-12">
                                                                <label for="previousGrantAid" class="control-label pull-left"> Previous grant aid</label>
                                                                <textarea id="previousGrantAid" class="form-control" name="previousGrantAid" style="height: 183px" placeholder="author name, title, application year, amount awarded, etc " ></textarea>
                                                            </div>

                                                        </div> <!--row-->

                                                    </div> <!--tab-pane" id="page 2" -->


                                                    <div class="tab-pane" id="page3">

                                                        <!-- Reader’s  Report -->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 20px"> 

                                                            <div class='col-sm-6'>
                                                                <button class="btn btn-success btn-xs" style="margin-bottom: 20px;" onclick="getTodaysDate()" data-toggle="modal" data-target="#assignEReadermodal">
                                                                    Assign expert reader to reference number
                                                                </button>
                                                                <!--<a class="btn" data-toggle="modal" href="#stack2">Launch modal</a>-->
                                                            </div>

                                                        </div> <!--row-->          

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 


                                                            <div id="additionalExpertReader"></div>
                                                        </div> <!--row-->          

                                                    </div> <!--tab-pane" id="page 3" -->


                                                    <div class="tab-pane" id="page4">

                                                        <!--Board  Meeting-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">   

                                                            <div class='col-sm-5'>
                                                                <strong class="pull-left">Board meeting<br/>&nbsp;</strong>
                                                                <div class="input-group  pull-left date datepicker" >
                                                                    <input type="text" name="appDateOfBoardMeeting" id="appDateOfBoardMeeting" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="appDateOfBoardMeeting">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div> 
                                                            </div>

                                                            <script>
                                                                $("#appDateOfBoardMeeting").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>
                                                            <div class="col-sm-4">
                                                                <label for="directorChairDecision" class="control-label">Director/Chair decision</label>
                                                                <br/> 
                                                                <input id="directorChairDecision"
                                                                       type="checkbox"                                
                                                                       class="form-control"                                
                                                                       name="directorChairDecision"  
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">   

                                                            <div class="col-sm-6">
                                                                <strong class="pull-left">Amount requested</strong> 
                                                                <div class="input-group pull-left">
                                                                    <label class="input-group-addon" for="amountRequested">
                                                                        <span class="glyphicon glyphicon-euro"></span>                                     
                                                                    </label>
                                                                    <input type="text" class="form-control" name="amountRequested" id="amountRequested" placeholder="Amount Requested">    
                                                                </div>
                                                            </div>

                                                            <div class='col-sm-6'>
                                                                <strong class="pull-left">Proposed  publication date &nbsp;&nbsp;&nbsp; </strong>
                                                                <div class="input-group pull-left" >
                                                                    <input type="text" name="appproposedDateOfPublication" 
                                                                           id="appproposedDateOfPublication" 
                                                                           class="form-control" 
                                                                           placeholder="DD/MM/YYYY" />    
                                                                </div> 
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-3">        
                                                                <label for="appplannedPageExtent" class="control-label pull-left">Planned page<br/> extend</label>
                                                                <input id="appplannedPageExtent"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appplannedPageExtent"                                
                                                                       >
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <label for="appproposedPrintRun" class="control-label pull-left">Proposed print run</label>
                                                                <input  id="appproposedPrintRun" 
                                                                        name="appproposedPrintRun" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>

                                                            <div class="col-sm-4">
                                                                <label for="award" class="control-label"> &nbsp;<br/>Award &nbsp; &nbsp; &nbsp;</label>
                                                                <br/> 
                                                                <input id="award"
                                                                       type="checkbox"                                
                                                                       class="form-control"                                
                                                                       name="award"  
                                                                       disabled 
                                                                       >
                                                            </div>
                                                        </div> <!--row-->


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">  

                                                            <div class="col-sm-6">
                                                                <strong class="pull-left">Amount approved</strong> 
                                                                <div class="input-group pull-left">
                                                                    <label class="input-group-addon" for="amountApproved">
                                                                        <span class="glyphicon glyphicon-euro"></span>                                     
                                                                    </label>
                                                                    <input type="text" class="form-control" name="amountApproved" id="amountApproved" placeholder="Amount Approved">    
                                                                </div>
                                                            </div>

                                                            <div class='col-sm-6'>
                                                                <strong class="pull-left">Publisher informed of meeting</strong>
                                                                <div class="input-group" >
                                                                    <input type="text" name="datePublisherInformedOfMeeting" id="datePublisherInformedOfMeeting" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="datePublisherInformedOfMeeting">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div> 
                                                            </div>
                                                            
                                                            <script>
                                                                $("#datePublisherInformedOfMeeting").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">   

                                                            <div class="col-sm-12">
                                                                <label for="commentsAboutMeeting" class="control-label pull-left">Board comments/instructions </label>
                                                                <textarea id="commentsAboutMeeting" class="form-control" name="commentsAboutMeeting" style="height: 98px" placeholder="'Refuse funding’ , ‘Award €1,000’ , ‘Postpone to next round’ , ‘Request revised sample'"></textarea>
                                                            </div>

                                                            <div class="row"> 
                                                                <div class='col-xs-12 button-wrapper' style="margin-bottom: 20px;margin-top: 60px"> 
                                                                    <button class='btn btn-success'>Approve</button>
                                                                    <button class='btn btn-warning'>Withdrawn</button>
                                                                    <button class='btn btn-danger'>Reject</button>
                                                                </div>
                                                            </div> <!--row-->
                                                            
                                                        </div>
                                                    </div> <!--tab-pane" id="page 4" -->


                                                    <div class="tab-pane" id="page5">

                                                        <!--Contract -->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-1"></div>
                                                            <div class="col-sm-8">        
                                                                <label class="control-label">Book cover</label>                                                               
                                                                <img id="cover" src="" alt="Book Cover" class="img ImageBorder form-control" title="Book Cover"/>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 


                                                            <div class='col-sm-6'>
                                                                <strong class=" pull-left">Contract sent to publisher</strong>
                                                                <div class="input-group pull-left">
                                                                    <input type="text" name="dateContractSenttoPublisher" id="dateContractSenttoPublisher" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="dateContractSenttoPublisher">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div>
                                                            </div>

                                                            <script>
                                                                $("#dateContractSenttoPublisher").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>

                                                            <div class='col-sm-6'>
                                                                <strong class=" pull-left">Acknowledgement approved</strong>
                                                                <div class="input-group">
                                                                    <input type="text" name="dateILEAcknowledgementApproved" id="dateILEAcknowledgementApproved" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="dateILEAcknowledgementApproved">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div> 
                                                            </div>

                                                            <script>
                                                                $("#dateILEAcknowledgementApproved").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px"> 

                                                            <div class='col-sm-6'>
                                                                <strong class=" pull-left"> Date published books received</strong>
                                                                <div class="input-group">
                                                                    <input type="text" name="datePublishedBooksReceived" id="datePublishedBooksReceived" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="datePublishedBooksReceived">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div>   
                                                            </div>

                                                            <script>
                                                                $("#datePublishedBooksReceived").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>

                                                            <div class='col-sm-6'>
                                                                <strong class=" pull-left"> Date Payment Made to Publisher </strong>
                                                                <div class="input-group">
                                                                    <input type="text" name="datePaymentMadeToPublisher" id="datePaymentMadeToPublisher" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="datePaymentMadeToPublisher">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div>   
                                                            </div>

                                                            <script>
                                                                $("#datePaymentMadeToPublisher").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px"> 

                                                            <div class="col-sm-6">
                                                                <label for="paymentReferenceNumber" class="control-label pull-left">Payment reference number</label>
                                                                <input id="paymentReferenceNumber"
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="paymentReferenceNumber"                                
                                                                       >
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row">

                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                                <div class="col-sm-2">
                                                                    <input id="appAddendumRightsAgreement"
                                                                           type="hidden"                                                             
                                                                           name="appAddendumRightsAgreement"                                
                                                                           >
                                                                </div>

                                                                <a class="btn btn-info" role="button" id="addendumRightsAgreement" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Addendum to rights agreement</a>
                                                            </div>

                                                        </div> <!--row-->  

                                                        <div class="row">

                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px">
                                                                <div class="col-sm-2">
                                                                    <input id="appProofPaymentToTranslator"
                                                                           type="hidden"                                                             
                                                                           name="appProofPaymentToTranslator"                                
                                                                           >
                                                                </div>

                                                                <a class="btn btn-info" role="button" id="proofPaymentToTranslator" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Proof of payment <br/> to the translator</a>
                                                            </div>

                                                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">  
                                                                <div class="col-sm-2">
                                                                    <input id="appBankDetailsForm"                                
                                                                           type="hidden"                                                            
                                                                           name="appcopiesTranslationSample"                                
                                                                           >
                                                                </div>

                                                                <a class="btn btn-info" role="button" id="bankDetailsForm" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Completed bank <br/> details form</a>
                                                            </div>

                                                            <div style="margin-bottom: 20px;margin-top: 30px;">  
                                                                <div class="col-sm-2">
                                                                    <input id="appSignedLIContract"                                
                                                                           type="hidden"                                                            
                                                                           name="appSignedLIContract"                                
                                                                           >
                                                                </div>

                                                                <a class="btn btn-info" role="button" id="signedLIContract">
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Signed Literature <br/> Ireland contract</a>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">  

                                                            <div class="form-group">
                                                                <label for="paymentStatus" >Payment status</label>
                                                                <div class="col-sm-12">
                                                                    <select class="selectpicker" id="paymentStatus">
                                                                        <option>Incomplete</option>
                                                                        <option>Complete</option>
                                                                        <option>Awaiting payment</option>
                                                                        <option>Paid</option>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">   

                                                            <div class="col-md-5"   style="margin-top: 25px; margin-bottom: 40px">
                                                                <strong class="pull-left">&nbsp;</strong>                                                 
                                                                <label class="btn btn-default pull-left" onclick = "pressCuttingsModal();">
                                                                    <img src="images/Press_Cutting.png" width="20" alt="Press_Cutting" /> 
                                                                    Show press coverage                     
                                                                </label>
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">  
                                                            <div class="col-sm-4">
                                                                <label for="salesFigures" class="control-label pull-left">Sales figures</label>
                                                                <input id="salesFigures"
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="salesFigures"  
                                                                       data-toggle="tooltip" 
                                                                       title="Number of copies of the book that have been sold"
                                                                       >
                                                            </div>

                                                            <div class='col-sm-4'>                                                       
                                                                <label for="salesFigures" class="control-label pull-left">Date updated</label>
                                                                <div class="input-group">
                                                                    <input type="text" name="dateUpdate" id="dateUpdate" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                    <label class="input-group-addon" for="dateUpdate">
                                                                        <span class="glyphicon glyphicon-calendar"></span>
                                                                    </label>
                                                                </div>   
                                                            </div>

                                                            <script>
                                                                $("#dateUpdate").datepicker({
                                                                    showWeekDays: true,
                                                                    todayHighlight: true,
                                                                    autoclose: true
                                                                });
                                                            </script>
                                                        </div> <!--row-->
                                                    </div> <!--page 5-->
                                                </div> <!--tab content-->
                                            </div><!--modal body-->

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div> <!--modal-content -->
                                    </div> <!--modal-dialog -->
                                </div><!--modal -->

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
                                                <!-- Main Grid -->   
                                            </tbody>
                                        </table>
                                    </div>             
                                    <c:if test="${not empty error}">Error: ${error}</c:if>
                                    </div> <!-- /container-fluid -->

                                    <!--userModal-->

                                    <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">

                                                <div class="modal-header" style="background-color: #c3bcbc">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="userModalLabel"><span id="usr_name">_</span></h4>
                                                </div>

                                                <div class="modal-body" style="background-color: #d9d1d1">

                                                    <div class="row" style="margin-bottom: 5px;margin-top: 5px">
                                                        <div class="col-sm-4">
                                                            <label for="userUname" class="control-label pull-left">Username</label>
                                                            <input  id="userUname" 
                                                                    type="text"                                                  
                                                                    class="form-control"    
                                                                    name="userUname"    
                                                                    >
                                                        </div>
                                                    </div> <!--row-->

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-4">
                                                            <label for="userFirstName" class="control-label pull-left">First name</label>
                                                            <input id="userFirstName"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userFirstName"                                
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">
                                                            <label for="userLastName" class="control-label pull-left">Last name</label>
                                                            <input id="userLastName"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userLastName"                                
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                        <div class="col-sm-4">
                                                            <label for="userFunction" class="control-label pull-left">Function</label>
                                                            <input id="userFunction"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userFunction"                                
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">
                                                            <label for="userRole" class="control-label pull-left">Role</label>
                                                            <input id="userRole"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userRole"                                
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                        <div class="col-sm-4">
                                                            <input id="userEmail"
                                                                   type="hidden"                                   
                                                                   name="userEmail"               
                                                                   >                                                    
                                                            <a class="btn btn-info btn-sm" role="button" id="mails" >
                                                                <span class="glyphicon glyphicon-envelope"></span>
                                                                <p id="msg"><span id="msg_val">_</span></p> </a>
                                                        </div>
                                                    </div> <!--row-->


                                                </div><!-- /.modal body -->

                                                <div class="modal-footer"  style="background-color: #c3bcbc">
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
                                    <h2>Contracts content goes here</h2>

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
                                                    <!-- Main Grid -->   
                                                </tbody>
                                            </table>
                                        </div>             
                                    <c:if test="${not empty error}">Error: ${error}</c:if>
                                    </div> <!-- /container-fluid -->

                                    <!--expReaderModal-->
                                    <div class="modal fade" id="expReaderModal" tabindex="-1" role="dialog" aria-labelledby="expReaderModalLabel">

                                        <div class="modal-dialog" role="document">

                                            <div class="modal-content">

                                                <div class="modal-header" style="background-color: #c3bcbc">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="expReaderModalLabel">Display expert readers</h4>
                                                </div>

                                                <div class="modal-body" style="background-color: #d9d1d1">

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                        <div class="col-sm-4">
                                                            <label for="FirstNameExpReader" class="control-label pull-left">First name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                            <input type="text" class="input-sm" id="FirstNameExpReader"/>
                                                        </div>

                                                        <div class="col-sm-1"></div>
                                                        <!--
                                                                                                                <div class="col-sm-4">
                                                        
                                                                                                                    <label for="expertReaderReferenceNumber"> Assign Expert Readers to Reference Number: </label>
                                                                                                                    <input type="text" class="input-sm" id="expertReaderReferenceNumber"/>
                                                        
                                                                                                                </div>-->
                                                    </div>

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-4">
                                                            <label for="LastNameExpReader" class="control-label pull-left"> Last name</label>
                                                            <input type="text" class="input-sm" id="LastNameExpReader"/>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-4">
                                                            <label for="EmailExpReader" class="control-label pull-left"> Email</label>
                                                            <input type="text" class="input-sm" id="EmailExpReader"/>
                                                        </div>
                                                    </div>




                                                </div><!-- modal body -->

                                                <div class="modal-footer"  style="background-color: #c3bcbc">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary">Save changes</button>
                                                </div><!-- modal-footer -->

                                            </div><!-- modal-content -->
                                        </div><!-- modal-dialog -->
                                    </div><!-- modal -->

                                </div> <!-- tab-pane expReader-->



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
                                                        <th class="all">Author(s)</th>
                                                        <th class="all">Title</th>
                                                        <th class="all">Publisher <br/>Year</th>
                                                        <th class="all">Genre</th>
                                                        <th class="all">Translation<br/>Title</th>                                       
                                                        <th class="all">Translation<br/>Publisher Year</th>
                                                        <th class="all">Translator</th>
                                                        <th class="all">Language</th>
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
                                                        <th class="all">Author(s)</th>
                                                        <th class="all">Title</th>
                                                        <th class="all">Publisher <br/>Year</th>
                                                        <th class="all">Genre</th>
                                                        <th class="all">Translation<br/>Title</th>                                       
                                                        <th class="all">Translation<br/>Publisher Year</th>
                                                        <th class="all">Translator</th>
                                                        <th class="all">Language</th>
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
                                                    <div class="modal-header" style="background-color: #c3bcbc">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title" id="booksModalLabel">Display Library</h4>
                                                    </div>
                                                    <div class="modal-body" style="background-color: #d9d1d1">

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> referenceNumber </label>
                                                                <p><input type="text" class="input-sm" id="referenceNumber"/></p>
                                                            </div>
                                                        </div>


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-1"></div>
                                                            <div class="col-sm-8">        
                                                                <label class="control-label">Book cover</label>                                                               
                                                                <img id="bookCover" src="" alt="Book Cover" class="img ImageBorder form-control" title="Book Cover"/>
                                                            </div>

                                                        </div>


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-6">
                                                                <label class="pull-left" for="Author"> Author </label>   
                                                                <textarea  id="Author" name="Author"  rows="2" cols="65">
                                                        
                                                                </textarea>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left" for="Title"> Title</label>
                                                                <p><input type="text" class="input-sm" id="Title"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Genre</label>
                                                                <p><input type="text" class="input-sm" id="Genre"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Language(s) </label>
                                                                <p><input type="text" class="input-sm" id="Language"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">                                                                                                          
                                                                <label class="pull-left"> ISBN </label>
                                                                <p><input type="text" class="input-sm" id="ISBN"/></p>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="modal-footer"  style="background-color: #c3bcbc">
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
                                                        <h4 class="modal-title" id="editBooksModalLabel">Edit books</h4>
                                                    </div>
                                                    <div class="modal-body">


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Reference number </label>
                                                                <p><input type="text" class="input-sm" id="referenceNumber2"/></p>
                                                            </div>
                                                        </div>

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-6">
                                                                <label class="pull-left" for="Author2"> Author </label>   
                                                                <textarea  id="Author2" name="Author2"  rows="2" cols="65">
                                                        
                                                                </textarea>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left" for="Title2"> Title</label>
                                                                <p><input type="text" class="input-sm" id="Title2"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Genre</label>
                                                                <p><input type="text" class="input-sm" id="Genre2"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Language(s) </label>
                                                                <p><input type="text" class="input-sm" id="Language2"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">                                                                                                          
                                                                <label class="pull-left"> ISBN </label>
                                                                <p><input type="text" class="input-sm" id="ISBN2"/></p>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="modal-footer"  style="background-color: #c3bcbc">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                        <button type="button" class="btn btn-primary">Save changes</button>
                                                    </div>
                                                </div><!-- /.modal-content -->
                                            </div><!-- /.modal-dialog -->
                                        </div><!-- /.modal -->
                                    </div>
                                </div> <!--Library-->

                                <!--Misc-->
                                <div class="tab-pane fade" id="Genres">
                                    <h2>Genre content goes here</h2>
                                </div>
                                <div class="tab-pane fade" id="Queries">
                                    <h2>Queries go here</h2>
                                </div>
                            </div>
                        </div>
                    </nav>
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

            <div class="modal fade" id="assignEReadermodal" data-modal-index="2">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form 
                            id="assignEReaderForm"  
                            method="POST"
                            role="form"  
                            autocomplete="on"  
                            action="${pageContext.request.contextPath}/GrantApplicationServlet" 
                        >
                        <%request.getSession().setAttribute("task", "AssignExpertReader");%>

                        <input type="hidden" name="AssignExpertReader"  class="form-control" value="AssignExpertReader">
                        <div class="modal-header" style="background-color: #c3bcbc">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">Assign expert reader to reference number</h4>
                        </div>
                        <div class="modal-body" style="background-color: #d9d1d1">

                            <div class="row" style="margin-bottom: 20px;">  
                                <div class='col-sm-4'>
                                    <label for="selectUnassignedER" class="pull-left">Select</label>
                                    <select class="selectpicker" id="selectUnassignedER" onchange="selectER();"></select>
                                </div>
                                <input type="hidden" name="selectedUnassignedER" id="selectedUnassignedER"  class="form-control">
                                <div class='col-sm-4' style="padding-left: 5px">
                                    <label for="unassignedERRefNo"  class="pull-left">for Reference Number</label>
                                    <input id="unassignedERRefNo" value="" disabled />
                                </div>
                            </div> <!--row-->

                            <div class="row" style="margin-bottom: 20px;">  
                                <div class='col-sm-4'>
                                    <strong class=" pull-left">&nbsp;<br/> Sample sent out</strong>
                                    <div class="input-group pull-left">
                                        <input type="text" name="sampleSentOut" id="sampleSentOut1" class="form-control" placeholder="DD/MM/YYYY" />    
                                    </div>
                                </div>
                                <div class='col-sm-4'>
                                    <strong class=" pull-left">Expected return date of report</strong>
                                    <div class="input-group pull-left">
                                        <input type="text" name="expectedReturnDate" id="expectedReturnDate" class="form-control" placeholder="DD/MM/YYYY" />    
                                        <label class="input-group-addon" for="expectedReturnDate">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </label>
                                    </div>
                                </div>
                                <script>
                                    $("#expectedReturnDate").datepicker({
                                        showWeekDays: true,
                                        todayHighlight: true,
                                        autoclose: true
                                    });
                                </script>
                            </div> <!--row-->
                            <input type="hidden" name="NewAssignedERRefNo" id="NewAssignedERRefNo"  class="form-control">
                        </div>
                        <div class="modal-footer"  style="background-color: #c3bcbc">
                            <input type="hidden" name="userID" value="${userID}">
                            <input type="hidden" name="publisherID" value="${publisherID}">
                            <input type="hidden" name="Company" value="${companyDetails.Company}">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" >Assign expert reader</button>
                        </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div class="modal fade" id="listAssignedEReadermodal" data-modal-index="3">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #c3bcbc">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">List assigned expert reader</h4>
                    </div>
                    <div class="modal-body" style="background-color: #d9d1d1">
                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 

                            <div class='col-sm-6'>
                                <strong class=" pull-left">Expert reader</strong>
                                <div class="input-group pull-left">
                                    <input type="text" name="appExpertReader" 
                                           id="appExpertReader" 
                                           class="form-control" 
                                           />    
                                </div>
                            </div>

                        </div> <!--row-->                                                      

                        <div class="row" style="margin-top: 30px;margin-bottom: 10px">
                            <div class='col-sm-4'>
                                <strong class=" pull-left"> Sample sent out</strong>
                                <div class="input-group pull-left">
                                    <input type="text" name="sampleSentOut" id="sampleSentOut" class="form-control" placeholder="DD/MM/YYYY" />    
                                    <label class="input-group-addon" for="sampleSentOut">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </label>
                                </div>
                            </div>

                            <script>
                                $("#sampleSentOut").datepicker({
                                    showWeekDays: true,
                                    todayHighlight: true,
                                    autoclose: true
                                });
                            </script>

                            <div class='col-sm-4'>
                                <strong class=" pull-left"> Sample returned</strong>
                                <div class="input-group pull-left">
                                    <input type="text" name="sampleReturned" id="sampleReturned" class="form-control" placeholder="DD/MM/YYYY" />    
                                </div>
                            </div>

                        </div> <!--row-->



                        <div class="row" style="margin-bottom: 20px;">

                            <div class="pull-left" style="margin-bottom: 20px;margin-top: 30px;">  
                                <div class="col-sm-2">
                                    <input id="ReadersReport"                                
                                           type="hidden"                                                            
                                           name="ReadersReport"                                
                                           >
                                </div>
                                <a class="btn btn-info" role="button" id="appReadersReport" >
                                    <span class="glyphicon glyphicon-file"></span>
                                    Reader’s Report</a>
                            </div>

                            <div class="col-sm-10">
                                <label for="readerReportSummary" class="control-label pull-left"> Reader’s report summary</label>
                                <textarea id="readerReportSummary" 
                                          class="form-control"                                               
                                          name="readerReportSummary"    
                                          style="height: 98px"
                                          >                 
                                </textarea>
                            </div>
                        </div> <!--row-->
                        <button class="btn btn-default" data-toggle="modal" data-target="#test-modal-4">Launch Modal 4</button>
                    </div>
                    <div class="modal-footer"  style="background-color: #c3bcbc">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <div class="modal fade" id="email" data-modal-index="5">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #c3bcbc">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Email</h4>
                    </div>
                    <div class="modal-body" style="background-color: #d9d1d1">
                        <div id="formWrap">
                            <form id="messageForm" action="#">
                                <fieldset>
                                    <legend>New message form</legend>
                                    <span>New Message</span><br/>
                                    <label id="toLabel">To:</label>
                                    <div id="friends" class="ui-helper-clearfix">
                                        <input id="to" type="text">
                                    </div>
                                    <label>Subject:</label>
                                    <input id="subject" name="subject" type="text"><br/>
                                    <label>Message:</label><br/>
                                    <textarea id="message" name="message" rows="5" cols="50"></textarea><br/>
                                    <button type="button" id="cancel">Cancel</button>
                                    <button type="submit" id="send">Send</button>
                                </fieldset>
                            </form>
                        </div>

                    </div>
                    <div class="modal-footer"  style="background-color: #c3bcbc">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div id="additionalExpertReaderModal"></div>

        <div class="modal fade" id="test-modal-4">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">Modal title 4</h4>
                    </div>
                    <div class="modal-body">
                        <p>One fine body&hellip;</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <div class="modal fade" id="pressCuttingsModal" tabindex="-1" role="dialog" aria-labelledby="pressCuttingsModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #c3bcbc">
                        <button type="button" class="close" data-dismiss="modal"  onclick="backToMisc();"  aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="pressCuttingsModalLabel">See press coverage</h4>
                    </div>


                    <div class="modal-body" style="background-color: #d9d1d1">
                        <div class="row" style="margin-bottom: 10px">

                            <output id="result">Press coverage</output>

                        </div>


                        <div class="row" style="margin-bottom: 10px">
                            <div class='col-sm-12'>
                                <button type="button" id="clear">Clear</button>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer"  style="background-color: #c3bcbc">                      
                        <label class="btn btn-default btn-file">
                            Add press coverage<input type="file" id="files" multiple  accept=".gif,.jpg,.jpeg,.png,.doc,.docx,.pdf">
                        </label>
                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="backToMisc();">Done</button>
                        <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                    </div> <!--modal footer -->
                </div> <!--modal content-->          
            </div> <!--modal dialog-->
        </div> <!--modal fade-->
        <input type="hidden" value="pressCuttings" name="image-file" id="label_pressCuttings"/>
    </body>
</html>
