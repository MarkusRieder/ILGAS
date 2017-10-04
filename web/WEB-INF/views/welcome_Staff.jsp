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

        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>


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
        <script src="//cdn.datatables.net/plug-ins/1.10.12/sorting/datetime-moment.js"></script>
        <script type="text/javascript" language="javascript" src="//cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/pdfmake.min.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.27/build/vfs_fonts.js"></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/buttons/1.3.1/js/buttons.html5.min.js "></script>
        <script type="text/javascript" language="javascript" src="//cdn.datatables.net/plug-ins/1.10.15/dataRender/datetime.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery-ui.js"></script>

        <!--http://jschr.github.io/bootstrap-modal/bs3.html-->

        <!--        <script src="js/bootstrap-modalmanager.js"></script>
                <script src="js/bootstrap-modal.js"></script>-->


        <script>

            $.datepicker.setDefaults({dateFormat: 'dd/mm/yy'});
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
                        {"data": "physicalDescription"},
                        {"data": "Duplicates"},
                        {"data": "Copies"},
                        {"data": "Notes"},
                        {"data": "ISBN"},
                        {"data": "ISSN"},
//                        {"data": "Copies"},
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
                        {"data": "ApplicationNumber"},
                        {"data": "ApplicationYear"},
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
                        {"data": "translatorTitles"},
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
                    $("#appReferenceNumber").val($(this).closest('tr').children()[3].textContent);
                    $("#appCompany").val($(this).closest('tr').children()[4].textContent);
//                    $("#appAgreement").val($(this).closest('tr').children()[5].textContent);

                    var appReferenceNumber = rowdata.ReferenceNumber;
                    //                 console.log("appReferenceNumber " + appReferenceNumber);
                    $("#unassignedERRefNo").val(appReferenceNumber);
                    var TranslName = rowdata.TranslatorName;
                    $("#TranslatorName").val(TranslName);
                    var bookTitles = rowdata.Titles;
                    $("#currentItem").val(bookTitles.join(""));
                    //console.log("bookTitles: " + bookTitles);

                    // Generate table translatorTrackTable
                    var TranslTitles = rowdata.translatorTitles;
                    //console.log("TranslTitles: " + TranslTitles);

                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#translTrackDiv').empty(); // empty the div before fetching and adding new data

                    var myTableDiv = document.getElementById("translTrackDiv");
                    var tble = document.createElement('TABLE');
                    tble.id = 'translatorTrackTable';
                    tble.border = '1';
                    tble.title = 'translatorTrackTable';
                    tble.className = "table table-striped table-condensed small";
                    tble.style = 'overflow-x: auto';
                    var tableBody = document.createElement('TBODY');
                    var translatorTrack = [];
                    for (var i = 0; i < TranslTitles.length; ++i) {
                        for (var j = 0; j < TranslTitles[i].length; ++j) {
                            // skip undefined values to preserve sparse array
                            if (TranslTitles[i][j] === undefined)
                                continue;
                            // create row if it doesn't exist yet
                            if (translatorTrack[j] === undefined)
                                translatorTrack[j] = [];
                            // swap the x and y coords for the copy
                            translatorTrack[j][i] = TranslTitles[i][j];
                        }
                    }

                    //TABLE ROWS
                    for (i = 0; i < translatorTrack.length; i++) {
                        var tr = document.createElement('TR');
                        for (j = 0; j < translatorTrack[i].length; j++) {
                            var td = document.createElement('TD');
                            if (i === 0) {
                                td.className = 'someClass';
                            }
                            // remove "undefined" cells
                            if (typeof (translatorTrack[i][j]) === "undefined") {
                                translatorTrack[i][j] = '';
                            }
                            td.appendChild(document.createTextNode(translatorTrack[i][j]));
                            tr.appendChild(td);
                        }
                        tableBody.appendChild(tr);
                    }

                    tble.appendChild(tableBody);
                    myTableDiv.appendChild(tble);
//                    for (i = 0; i < translatorTrack.length; i++) {
//                        for (j = 0; j < translatorTrack[i].length; j++) {
//
//                            // get translators
//                            if (i === 0) {
//                                var newdiv = $('<div>', {class: 'text-left', text: translatorTrack[i][j]});
//                                var a = document.createElement('a');
//                                var linkText = document.createTextNode("  see Trackrecord");
//                                //       console.log("translators:  " + translatorTrack[i][j]);
//                                a.appendChild(linkText);
//                                a.title = "see Trackrecord";
//                                a.class = "button";
//                                a.href = "#stack2";
//                                newdiv.append(a);
//                            }
//                            $('#testcontainer').find('a').attr('data-toggle', 'modal');
//                            $('#testcontainer').append(newdiv);
//                            //print track record
//                            if (i !== 0) {
//                                //    console.log("translatorTrack[i][j]:  " + translatorTrack[i][j]);
//                            }
//                        }
//                    }

                    var expertReaderName = rowdata.expertReaderList;
//                    console.log("expertReaderName:  " + expertReaderName);
//                    console.log("expertReaderName length:  " + expertReaderName.length);

                    document.getElementById("unassignedERRefNo").value = appReferenceNumber;
                    document.getElementById("NewAssignedERRefNo").value = appReferenceNumber;
                    /*
                     * get the whole List with the arrays  
                     * no of arrays = expertReaderName.length
                     */
                    //          alert(cntr);

                    //https://stackoverflow.com/questions/20293680/how-to-empty-div-before-append                    
                    $('#additionalExpertReader').empty(); // empty the div before fetching and adding new data

//                    if (expertReaderName.length !== 0) {
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
                            //     console.log(addExpertReaderModal);

                            $(addExpertReaderModal).appendTo('#additionalExpertReaderModal');
                            /* 
                             * get the data from the array
                             */

                            for (var j = 0; j <= 6; ++j) {
                                //         console.log("expertReaderName[" + i + "]  [" + j + "]   " + expertReaderName[i][j]);

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
//                    }


                    //Get all Expert Readers that are not assigned at the moment
                    var unassignedExpertReaderList = rowdata.unassignedExpertReaderList;
                    //           console.log(unassignedExpertReaderList.length);


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
                    $("#appproposedDateOfPublication").val($(this).closest('tr').children()[7].textContent);
                    $("#appproposedPrintRun").val($(this).closest('tr').children()[8].textContent);
                    $("#appplannedPageExtent").val($(this).closest('tr').children()[9].textContent);
                    $("#appnumberOfPages").val($(this).closest('tr').children()[11].textContent);
                    $("#appfeePerPage").val($(this).closest('tr').children()[12].textContent);
                    $("#apptranslatorFee").val($(this).closest('tr').children()[13].textContent);
                    $("#appNotes").val($(this).closest('tr').children()[14].textContent);
                    $("#appStatus").val($(this).closest('tr').children()[15].textContent);
                    $("#appcopiesSent").val($(this).closest('tr').children()[16].textContent);
                    $("#appdateCopiesWereSent").val($(this).closest('tr').children()[17].textContent);
                    $("#appTC_ACCEPTED").val($(this).closest('tr').children()[19].textContent);
                    $("#appAPPROVED").val($(this).closest('tr').children()[20].textContent);
                    $("#appGenre").val($(this).closest('tr').children()[21].textContent);
                    $("#appExpertReader").val($(this).closest('tr').children()[23].textContent);
                    $("#appBookTitle").val($(this).closest('tr').children()[24].textContent);
                    $("#expertReaderName").val($(this).closest('tr').children()[22].textContent);
                    $("#sampleSentOut").val($(this).closest('tr').children()[29].textContent);
                    $("#sampleReturned").val($(this).closest('tr').children()[30].textContent);
                    $("#appReadersReport").val($(this).closest('tr').children()[31].textContent);
//                    $("#readerReportSummary").val($(this).closest('tr').children()[32].textContent);

                    $("#appDateOfPublicationOriginal").val($(this).closest('tr').children()[35].textContent);
                    $("#appLanguageOriginal").val($(this).closest('tr').children()[36].textContent);
                    $("#appPageExtentOriginal").val($(this).closest('tr').children()[37].textContent);
                    $("#appCountryOfPublication").val($(this).closest('tr').children()[38].textContent);
                    $("#appForeignPublisher").val($(this).closest('tr').children()[39].textContent);
                    $("#appForeignCountry").val($(this).closest('tr').children()[40].textContent);
                    $("#appTargetLanguage").val($(this).closest('tr').children()[41].textContent);
                    $("#amountRequested").val($(this).closest('tr').children()[43].textContent);
                    $("#award").val($(this).closest('tr').children()[62].textContent);
                    $("#salesFigures").val($(this).closest('tr').children()[63].textContent);

                    console.log(table.row(this).data());
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
                z-index: 2000 !important;
            }

            .someClass {
                background:yellow;
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
                                <li role="tab" ><a href="#Misc" data-toggle="tab">Genre</a></li>
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
                                                    <th class="all">Proposed<br/> Print Run</th>
                                                    <th class="all">Planned Page <br/>  Extent</th>
                                                    <th class="all">Translator<br/> CV</th>
                                                    <th class="all">Number<br/> Pages</th>
                                                    <th class="all">Break-down of <br/> Translator fee</th>
                                                    <th class="all">Translator  <br/> Fee</th>
                                                    <th class="all">Notes</th>
                                                    <th class="all select-filter">Status</th>
                                                    <th class="all">Copies <br/> Sent</th>
                                                    <th class="all">Date Copies  <br/> Were Sent</th>
                                                    <th class="all">Copies of  <br/> Translation Sample</th>
                                                    <th class="all">T&C has been <br/> Accepted</th>
                                                    <th class="all">Approved</th> 
                                                    <th class="all">Genre</th>   
                                                    <th class="all"></th>
                                                    <th class="all">Expert Reader</th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>    
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>    
                                                    <th class="all"></th>

                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>    
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>    
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>    
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>    
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                    <th class="all"></th>
                                                </tr>
                                            </thead>

                                            <tfoot>
                                                <tr>
                                                    <th class="details-control"></th>   
                                                    <th class="all">1<br/>  Nr</th>
                                                    <th class="all">2<br/>  Year</th>
                                                    <th class="all">3<br/>  Nr</th>
                                                    <th class="all">4</th>              

                                                    <!--<th class="all">PublisherID</th>-->
                                                    <!--<th class="all">userID</th>-->
                                                    <th class="all">4</th>
                                                    <th class="all">5</th>
                                                    <th class="all">6<br/> Date of <br/> Publication</th>
                                                    <th class="all">7<br/> Print Run</th>
                                                    <th class="all">8 Page <br/>  Extent</th>
                                                    <th class="all">9 <br/> Translator<br/> CV</th>
                                                    <th class="all">Number<br/> Pages</th>
                                                    <th class="all">Break-down of <br/> Translator fee</th>
                                                    <th class="all">Translator  <br/> Fee</th>
                                                    <th class="all">Notes</th>
                                                    <th class="all select-filter">Status</th>
                                                    <th class="all">15 <br/> Sent</th>
                                                    <th class="all">16 Copies  <br/> Were Sent</th>
                                                    <th class="all">17 of  <br/> Translation Sample</th>
                                                    <th class="all">18 has been <br/> Accepted</th>
                                                    <th class="all">Approved</th>
                                                    <th class="all">20 Genre</th>    
                                                    <th class="all">TranslatorName</th>
                                                    <th class="all">expertReaderName</th>
                                                    <th class="all">bookTitle</th>
                                                    <th class="all">translatorTitles</th>
                                                    <th class="all">Titles</th>
                                                    <th class="all">translatorCVDocName</th>
                                                    <th class="all">cover</th>
                                                    <th class="all">sampleSentOut</th>
                                                    <th class="all">sampleReturned</th>
                                                    <th class="all">readerReport</th>
                                                    <th class="all">expertReaderList</th>
                                                    <th class="all">unassignedExpertReaderList</th>    
                                                    <th class="all">idTranslator</th>
                                                    <th class="all">originalDateOfPublication</th>
                                                    <th class="all">?originalLanguage?</th>
                                                    <th class="all">Page Extent <br/>(of the original)</th>
                                                    <th class="all">countryOfPublication</th>    
                                                    <th class="all">Foreign Publisher</th>
                                                    <th class="all">foreignCountry</th>
                                                    <th class="all">targetLanguage</th>
                                                    <th class="all">?boardMeeting?</th>
                                                    <th class="all">amountRequested</th>
                                                    <th class="all">amountApproved</th>
                                                    <th class="all">publisherInformedOfMeeting</th>
                                                    <th class="all">?boardComments_Instructions?</th>
                                                    <th class="all">contractSentToPublisher</th>
                                                    <th class="all">acknowledgementApproved</th>
                                                    <th class="all">datePublishedBooksReceived</th>    
                                                    <th class="all">datePaymentMadeToPublisher</th>
                                                    <th class="all">paymentReferenceNumber</th>
                                                    <th class="all">Addendum</th>
                                                    <th class="all">Addendum Name</th>
                                                    <th class="all">Proof of Payment</th>    
                                                    <th class="all">Proof of Payment Name</th>
                                                    <th class="all">Bank Details</th>
                                                    <th class="all">Bank Details Name</th>    
                                                    <th class="all">SignedLIContract</th>
                                                    <th class="all">SignedLIContractName</th>
                                                    <th class="all">paymentStatus</th>
                                                    <th class="all">previousGrantAid</th>
                                                    <th class="all">62 - award</th>    
                                                    <th class="all">63 - salesFigures</th>
                                                    <th class="all">Original</th>
                                                    <th class="all">OriginalName</th>
                                                    <th class="all">64 - dummy</th>
                                                </tr>
                                            </tfoot>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>                   
                                </div> <!-- container-fluid -->  


                                <!--userModal-->
                                <!--                                <div id="applicationsModal" class="modal fade" tabindex="-1" data-focus-on="input:first" style="display: none;">
                                                                    <div class="modal fade" id="applicationsModal" tabindex="-1" role="dialog" aria-labelledby="applicationsModalLabel"  data-focus-on="input:first" style="display: none;">
                                                                    <div class="modal-dialog" role="document">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header" style="background-color: #c3bcbc">
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                                <h4 class="modal-title" id="applicationsModalLabel">Applications</h4>
                                                                            </div>-->
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
                                                            <div class="col-sm-3">
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

                                                        <!--second row-->
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-1"></div>
                                                            <div class="col-sm-8">        
                                                                <label class="control-label">Book Cover</label>                                                               
                                                                <img id="cover" src="" alt="Book Cover" class="img ImageBorder form-control" title="Book Cover"/>
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
                                                                <label for="appDateOfPublicationOriginal" class="control-label pull-left">Date of Publication <br/>(of the original)</label>
                                                                <input id="appDateOfPublicationOriginal"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appDateOfPublicationOriginal"                                
                                                                       >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="appPageExtentOriginal" class="control-label pull-left">Page Extent <br/>(of the original)</label>
                                                                <input  id="appPageExtentOriginal" 
                                                                        name="appPageExtentOriginal" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>
                                                        </div> <!--row-->


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-3">        
                                                                <label for="appCountryOfPublication" class="control-label pull-left">Country of Publication</label>
                                                                <input id="appCountryOfPublication"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appCountryOfPublication"                                
                                                                       >
                                                            </div>

                                                            <div class="col-sm-4">
                                                                <label for="appLanguageOriginal" class="control-label pull-left">Language <br/>(of the original)</label>
                                                                <input  id="appLanguageOriginal" 
                                                                        name="appLanguageOriginal" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>


                                                            <div class="col-sm-4">        
                                                                <label for="appGenre" class="control-label pull-left">&nbsp;<br/> Genre</label>
                                                                <input id="appGenre"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appGenre"                                
                                                                       >
                                                            </div>

                                                        </div> <!--row-->

                                                        <!--                                                        We’ll need the following fields:
                                                                                                                1. Foreign Publisher
                                                                                                                2. Foreign Country 
                                                                                                                3. Target Language
                                                                                                                4. Translator’s name
                                                                                                                5. Translator’s track record
                                                                                                                6. Translation Sample (as is!)
                                                                                                                7. Original (Like the attachment one for translation sample)
                                                                                                                8. T&Cs Accepted (great!)
                                                                                                                9. Application Approved (also great!)
                                                        
                                                                                                                1. Expert Reader
                                                                                                                2. Sample Sent Out
                                                                                                                3. Sample Returned
                                                                                                                4. Reader’s Report
                                                                                                                5. Reader’s Report Summary (this goes into the document for the board – staff can add this)
                                                        
                                                                                                                1. Board Meeting
                                                                                                                2. Amount Requested 
                                                                                                                3. Fee Calculation (see below)
                                                                                                                4. Proposed Publication Date
                                                                                                                5. Planned Page Extent
                                                                                                                6. Planned Print Run
                                                                                                                7. Award (checkbox)
                                                                                                                8. Amount Approved 
                                                                                                                9. Publisher Informed of Outcome 
                                                                                                                10. Board Comments/Instructions
                                                        
                                                                                                                ###############################
                                                                                                                We should have fields for ‘Date of Publication’ (of the original) and ‘Page Extent’ (of the original), as well as ‘Country of Publication’, ‘Language’ (i.e. the language of the original) and ‘Genre’.
                                                                                                                Notes about Application-->



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


                                                        <!--                                                        1. Foreign Publisher
                                                                                                                2. Foreign Country 
                                                                                                                3. Target Language
                                                        
                                                                                                                4. Translator’s name
                                                                                                                5. Translator’s track record
                                                                                                                6. Translation Sample (as is!)
                                                        
                                                                                                                7. Original (Like the attachment one for translation sample)
                                                        
                                                                                                                8. T&Cs Accepted (great!)
                                                                                                                9. Application Approved (also great!)-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label for="appForeignPublisher" class="control-label pull-left">Foreign Publisher</label>
                                                                <input id="appForeignPublisher"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appForeignPublisher"                                
                                                                       >
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="appForeignCountry" class="control-label pull-left">Foreign Country </label>
                                                                <input  id="appForeignCountry" 
                                                                        name="appForeignCountry" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>

                                                            <div class="col-sm-4">        
                                                                <label for="appTargetLanguage" class="control-label pull-left"> Target Language</label>
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

                                                        <div id="testcontainer">

                                                        </div>

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-8">
                                                                <label for="appfeePerPage" class="control-label pull-left">Break-down of translator fee:</label>
                                                                <!--<div class="input-group" style="margin-bottom: 40px">-->
                                                                <textarea id="appfeePerPage"  class="form-control" name="appfeePerPage" style="height: 98px"></textarea>
                                                                <!--</div>-->
                                                            </div>


                                                            <div class="col-sm-4">
                                                                <label for="apptranslatorFee" class="control-label pull-left">Translator Fee</label>
                                                                <div class="input-group" style="margin-bottom: 40px">                                                               
                                                                    <label class="input-group-addon" for="apptranslatorFee">                                                           
                                                                        <span class="glyphicon glyphicon-euro"></span>                                     
                                                                    </label>
                                                                    <input type="text" class="form-control" name="apptranslatorFee" id="apptranslatorFee" placeholder="fee">    
                                                                </div>
                                                            </div>
                                                        </div> <!--row-->

                                                    </div> <!--tab-pane" id="page 2" -->


                                                    <div class="tab-pane" id="page3">

                                                        <!-- Reader’s  Report -->

                                                        <!--
                                                                                                                I think the Reader info should be in a separate tab called ‘Reader’s Report’, with the following fields:
                                                                                                                1. Expert Reader
                                                                                                                2. Sample Sent Out
                                                                                                                3. Sample Returned
                                                                                                                4. Reader’s Report
                                                                                                                5. Reader’s Report Summary (this goes into the document for the board – staff can add this)-->


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 20px"> 

                                                            <div class='col-sm-6'>
                                                                <button class="btn btn-success btn-xs" style="margin-bottom: 20px;" onclick="getTodaysDate()" data-toggle="modal" data-target="#assignEReadermodal">
                                                                    Assign Expert Reader to Reference Number
                                                                </button>
                                                                <!--<a class="btn" data-toggle="modal" href="#stack2">Launch modal</a>-->
                                                            </div>

                                                        </div> <!--row-->          

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 

                                                            <!--                                                            <div class='col-sm-6'>
                                                            
                                                                                                                            <button class="btn btn-success btn-xs pull-left" style="margin-bottom: 20px;" data-toggle="modal" data-target="#listAssignedEReadermodal">
                                                                                                                                List assigned Expert Reader
                                                                                                                            </button>
                                                            
                                                                                                                        </div>-->

                                                            <div id="additionalExpertReader"></div>
                                                        </div> <!--row-->          

                                                        <!--                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 
                                                                                                                    
                                                                                                                    <div class='col-sm-6'>
                                                                                                                        <strong class=" pull-left">Expert Reader</strong>
                                                                                                                        <div class="input-group pull-left">
                                                                                                                            <input type="text" name="appExpertReader" 
                                                                                                                                   id="appExpertReader" 
                                                                                                                                   class="form-control" 
                                                                                                                                   />    
                                                                                                                        </div>
                                                                                                                    </div>
                                                        
                                                                                                                </div> row                                                      
                                                        
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
                                                        
                                                                                                                </div> row
                                                        
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
                                                                                                                        <label for="readerReport" class="control-label pull-left"> Reader’s Report Summary</label>
                                                                                                                        <textarea id="readerReport" 
                                                                                                                                  class="form-control"                                               
                                                                                                                                  name="readerReport"    
                                                                                                                                  style="height: 98px"
                                                                                                                                  >                 
                                                                                                                        </textarea>
                                                                                                                    </div>
                                                                                                                </div> row-->

                                                    </div> <!--tab-pane" id="page 3" -->


                                                    <div class="tab-pane" id="page4">

                                                        <!--Board  Meeting-->

                                                        <!--                                                  
                                                        Let’s call this one ‘Board Meeting’. The tabs should be:
                                                        1. Board Meeting
                                                        2. Amount Requested 
                                                        3. Fee Calculation (see below)
                                                        4. Proposed Publication Date
                                                        5. Planned Page Extent
                                                        6. Planned Print Run
                                                        7. Award (checkbox)
                                                        8. Amount Approved 
                                                        9. Publisher Informed of Outcome 
                                                        10. Board Comments/Instructions-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px">   

                                                            <div class='col-sm-4'>
                                                                <strong class="pull-left">Board meeting<br/>&nbsp;</strong>
                                                                <div class="input-group date datepicker" >
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
                                                                <label for="directorChairDecision" class="control-label">Director/Chair Decision</label>
                                                                <br/> <br/> 
                                                                <input id="directorChairDecision"
                                                                       type="checkbox"                                
                                                                       class="form-control"                                
                                                                       name="directorChairDecision"  
                                                                       >
                                                            </div>
                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">   

                                                            <div class="col-sm-6">
                                                                <strong class="pull-left">Amount Requested</strong> 
                                                                <div class="input-group pull-left">
                                                                    <label class="input-group-addon" for="amountRequested">
                                                                        <span class="glyphicon glyphicon-euro"></span>                                     
                                                                    </label>
                                                                    <input type="text" class="form-control" name="amountRequested" id="amountRequested" placeholder="Amount Requested">    
                                                                </div>
                                                            </div>

                                                            <div class='col-sm-6'>
                                                                <strong class="pull-left">Proposed  Publication Date &nbsp;&nbsp;&nbsp; </strong>
                                                                <div class="input-group pull-left" >
                                                                    <input type="text" name="proposedPublicationDate" id="proposedPublicationDate" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                </div> 
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-3">        
                                                                <label for="appplannedPageExtent" class="control-label pull-left">Planned Page<br/> Extend</label>
                                                                <input id="appplannedPageExtent"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="appplannedPageExtent"                                
                                                                       >
                                                            </div>

                                                            <div class="col-sm-3">
                                                                <label for="appproposedPrintRun" class="control-label pull-left">Proposed Print Run</label>
                                                                <input  id="appproposedPrintRun" 
                                                                        name="appproposedPrintRun" 
                                                                        type="text"                                                                
                                                                        class="form-control"     
                                                                        >
                                                            </div>

                                                            <div class="col-sm-4">
                                                                <label for="award" class="control-label">Award &nbsp; &nbsp; &nbsp;</label>
                                                                <br/> <br/> 
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
                                                                <strong class="pull-left">Amount Approved</strong> 
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
                                                                <label for="commentsAboutMeeting" class="control-label pull-left">Board Comments/Instructions </label>
                                                                <textarea id="commentsAboutMeeting" 
                                                                          class="form-control"                                               
                                                                          name="commentsAboutMeeting"    
                                                                          style="height: 98px"
                                                                          >                 
                                                                </textarea>
                                                            </div>

                                                            <div class="row"> 
                                                                <div class="btn-group" style="margin-bottom: 20px;margin-top: 60px"> 
                                                                    <button id="approve" type="button" class="btn btn-success">Approve</button>
                                                                    <button  id="withdrawn" type="button" class="btn btn-warning">Withdrawn</button>
                                                                    <button  id="reject" type="button" class="btn btn-danger">Reject</button>                                                        
                                                                </div>
                                                            </div> <!--row-->
                                                        </div>
                                                    </div> <!--tab-pane" id="page 4" -->


                                                    <div class="tab-pane" id="page5">

                                                        <!--Contract -->


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 


                                                            <div class='col-sm-6'>
                                                                <strong class=" pull-left">Contract Sent to Publisher</strong>
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
                                                                <strong class=" pull-left">Acknowledgement Approved</strong>
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
                                                                <strong class=" pull-left"> Date Published Books Received</strong>
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
                                                                <label for="paymentReferenceNumber" class="control-label pull-left">Payment Reference Number</label>
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

                                                                <a class="btn btn-info" role="button" id="signedLIContract" >
                                                                    <span class="glyphicon glyphicon-file"></span>
                                                                    Signed Literature <br/> Ireland contract</a>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">  

                                                            <div class="form-group">
                                                                <label for="paymentStatus" >Payment Status</label>
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

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 

                                                            <div class="col-sm-12">
                                                                <label for="previousGrantAid" class="control-label pull-left"> Previous Grant Aid</label>
                                                                <textarea id="previousGrantAid" class="form-control" name="previousGrantAid" style="height: 183px" placeholder="author name, title, application year, amount awarded. " ></textarea>
                                                            </div>

                                                        </div> <!--row-->

                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">   

                                                            <div class="col-md-5"   style="margin-top: 25px; margin-bottom: 40px">
                                                                <strong class="pull-left">&nbsp;</strong>                                                 
                                                                <label class="btn btn-default pull-left" onclick = "pressCuttingsModal();">
                                                                    <img src="images/Press_Cutting.png" width="20" alt="Press_Cutting" /> 
                                                                    Show Press cuttings                     
                                                                </label>
                                                            </div>

                                                            <div class="col-sm-4">
                                                                <label for="salesFigures" class="control-label pull-left">Sales Figures</label>
                                                                <input id="salesFigures"
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="salesFigures"  
                                                                       data-toggle="tooltip" 
                                                                       title="Number of copies of the book that have been sold"
                                                                       >
                                                            </div>
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
                                                            <label for="userUname" class="control-label pull-left">Username:</label>
                                                            <input  id="userUname" 
                                                                    type="text"                                                  
                                                                    class="form-control"    
                                                                    name="userUname"    
                                                                    >
                                                        </div>
                                                    </div> <!--row-->

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-4">
                                                            <label for="userFirstName" class="control-label pull-left">First Name:</label>
                                                            <input id="userFirstName"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userFirstName"                                
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">
                                                            <label for="userLastName" class="control-label pull-left">Last Name:</label>
                                                            <input id="userLastName"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userLastName"                                
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                        <div class="col-sm-4">
                                                            <label for="userFunction" class="control-label pull-left">Function: </label>
                                                            <input id="userFunction"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="userFunction"                                
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">
                                                            <label for="userRole" class="control-label pull-left">Role:</label>
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

                                                <div class="modal-header" style="background-color: #c3bcbc">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="expReaderModalLabel">Display Expert Readers</h4>
                                                </div>

                                                <div class="modal-body" style="background-color: #d9d1d1">

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                        <div class="col-sm-4">
                                                            <label for="FirstNameExpReader" class="control-label pull-left">First Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
                                                            <label for="LastNameExpReader" class="control-label pull-left"> Last Name: </label>
                                                            <input type="text" class="input-sm" id="LastNameExpReader"/>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                        <div class="col-sm-4">
                                                            <label for="EmailExpReader" class="control-label pull-left">  Email: </label>
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
                                                        <!-- <th class="all">Publisher</th>-->
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
                                                        <th class="all">Author(s)</th>
                                                        <th class="all">Title</th>
                                                        <!--<th class="all">Publisher</th>-->
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
                                                                <label class="control-label">Book Cover</label>                                                               
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
                                                                <label class="pull-left" for="Title"> Title: </label>
                                                                <p><input type="text" class="input-sm" id="Title"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Genre: </label>
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
                                                        <h4 class="modal-title" id="editBooksModalLabel">Edit Books</h4>
                                                    </div>
                                                    <div class="modal-body">


                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">

                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> referenceNumber </label>
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
                                                                <label class="pull-left" for="Title2"> Title: </label>
                                                                <p><input type="text" class="input-sm" id="Title2"/></p>
                                                            </div>
                                                        </div>
                                                        <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                                            <div class="col-sm-4">
                                                                <label class="pull-left"> Genre: </label>
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
                                <div class="tab-pane fade" id="Misc">
                                    <h2>Misc Content Goes Here</h2>
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
                            <h4 class="modal-title">Assign Expert Reader to Reference Number</h4>
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
                            <button type="submit" class="btn btn-primary" >Assign Expert Reader</button>
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
                        <h4 class="modal-title">List assigned Expert Reader</h4>
                    </div>
                    <div class="modal-body" style="background-color: #d9d1d1">
                        <div class="row" style="margin-bottom: 20px;margin-top: 5px"> 

                            <div class='col-sm-6'>
                                <strong class=" pull-left">Expert Reader</strong>
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
                                <label for="readerReportSummary" class="control-label pull-left"> Reader’s Report Summary</label>
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
                        <h4 class="modal-title" id="pressCuttingsModalLabel">See Press Cuttings</h4>
                    </div>


                    <div class="modal-body" style="background-color: #d9d1d1">
                        <div class="row" style="margin-bottom: 10px">

                            <output id="result">Press Cuttings</output>

                        </div>


                        <div class="row" style="margin-bottom: 10px">
                            <div class='col-sm-12'>
                                <button type="button" id="clear">Clear</button>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer"  style="background-color: #c3bcbc">                      
                        <label class="btn btn-default btn-file">
                            Add Press Cuttings<input type="file" id="files" multiple  accept=".gif,.jpg,.jpeg,.png,.doc,.docx,.pdf">
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
