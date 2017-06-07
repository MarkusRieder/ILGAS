<%-- 
    Document   : newApplication
    Created on : 19-Mar-2017, 11:27:58
    Author     : markus
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">

        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">

        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>


        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->
        <script src="js/moment.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery-ui.js"></script>

        <script>
            function getNumberPages()
            {
                //Assume form with id="theform"
                var theForm = document.forms["feeCalculationForm"];
                //Get a reference to the TextBox
                var numberPages = document.getElementById("numberOfPages");
                var noPages = 0;
                //If the textbox is not blank
                if (numberPages.value !== "")
                {
                    noPages = parseFloat(numberPages.value);
                }
                return noPages;
            }

            function getFeePerPage()
            {
                //Assume form with id="theform"
                var theForm = document.forms["feeCalculationForm"];
                //Get a reference to the TextBox
                var numberPages = document.getElementById("feePerPage");
                var amountPage = 10;
                //If the textbox is not blank
                if (feePerPage.value !== "")
                {
                    amountPage = parseFloat(feePerPage.value);
                }
                return amountPage;
            }

            function getTotal()
            {
                var feeTotal = getNumberPages() * getFeePerPage();
                document.getElementById("translatorFee").value = feeTotal.toFixed(2).replace(/./g, function (c, i, a) {
                    return i && c !== "." && ((a.length - i) % 3 === 0) ? ',' + c : c;
                });
            }
        </script>

        <!--AutoComplete_Genres-->
        <script type="text/javascript">
            $(function () {
                $("#genre").autocomplete({
                    source: 'ACGenre', // The source of the AJAX results
                    dataType: 'json',
                    contentType: "application/json",
                    data: '',
                    minLength: 3, // The minimum amount of characters that must be typed before the autocomplete is triggered
                    focus: function (event, ui) { // What happens when an autocomplete result is focused on
                        $("#genre").val(ui.item.name);
                        return false;
                    },
                    select: function (event, ui) { // What happens when an autocomplete result is selected
                        $("#genre").val(ui.item.name);
                        $('#idgenres').val(ui.item.id);
                    }
                });
            });
        </script>

        <!--AutoComplete_international_publishers-->
        <script>
            $(function () {
                $("#publisher").autocomplete({
                    source: 'ACintPublishers_test', // The source of the AJAX results
                    dataType: 'json',
                    data: '',
                    minLength: 3, // The minimum amount of characters that must be typed before the autocomplete is triggered
                    focus: function (event, ui) { // What happens when an autocomplete result is focused on
                        $("#publisher").val(ui.item.name);
                        return false;
                    },
                    select: function (event, ui) { // What happens when an autocomplete result is selected
                        $("#publisher").val(ui.item.name);
                        $('#Company_Number').val(ui.item.id);
                        $('#Address1').val(ui.item.Address1);
                        $('#Address2').val(ui.item.Address2);
                        $('#Address3').val(ui.item.Address3);
                        $('#Address4').val(ui.item.Address4);
                        $('#postCode').val(ui.item.postCode);
                        $('#City').val(ui.item.City);
                        $('#country').val(ui.item.Country);
                        $('#countryCode').val(ui.item.CountryCode);
                        $('#Telephone').val(ui.item.Telephone);
                        $('#Fax_Number').val(ui.item.Fax);
                        $('#Web_Address').val(ui.item.WWW);
                        $('#doNotMail').val(ui.item.DoNotMail);
                        $('#Bursaries').val(ui.item.Bursaries);
                        $('#Founded').val(ui.item.Founded);
                        $('#Number_Of_Titles').val(ui.item.NumberOfTitles);
                        $('#Date_modified').val(ui.item.DateModified);
                        $('#note').val(ui.item.Notes);
                    }
                });
            });
        </script>

        <!-- Load mobile menu -->
        <script type="text/javascript" src="js/jquery.mobile-menu.js"></script>

        <!--phonenav-->
        <script type="text/javascript">
            $(function () {
                $("body").mobile_menu({
                    menu: "#phonenav"
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

        <!--icon exclamation-->
        <style>
            .icon-exclamation {
                color: #ff0000;

                ul {
                    margin: 0;
                }
                ul.dashed {
                    list-style-type: none;
                }
                ul.dashed > li {
                    text-indent: -5px;
                }
                ul.dashed > li:before {
                    content: "-";
                    text-indent: -5px;
                }
            }

            /*        <!--Checkboxes with tick mark-->*/

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

            .checkbox label input[type="checkbox"]:disabled + .cr,
            .radio label input[type="radio"]:disabled + .cr {
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

            .nav-tabs.two-lines>li {
                height:62px;
            }
            .nav-tabs.two-lines>li>a, .nav-tabs>li>a>div {
                height:100%;
            }
            input[type="text"]:focus + .glyphicon-search{
                color: #FF8C00;
            }

            /*            .datepicker table tr td.active:active, 
            .datepicker table tr td.active.highlighted:active, 
            .datepicker table tr td.active.active, 
            .datepicker table tr td.active.highlighted.active {
               background-color: green;*/

            .ui-state-highlight, 
            .ui-widget-content .ui-state-highlight, 
            .ui-widget-header .ui-state-highlight {
                border: 1px solid #003399;
                background: #003399 url("css/images/ui-bg_glass_55_fbf9ee_1x400.png") 50% 50% repeat-x;
            }

        </style>

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
                $('div.translator_cv').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("label_translator").value = label;
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
        </script>

        <style>
            .btn-file {
                position: relative;
                overflow: hidden;
            }
            .btn-file input[type=file] {
                position: absolute;
                top: 0;
                right: 0;
                min-width: 100%;
                min-height: 100%;
                font-size: 100px;
                text-align: right;
                filter: alpha(opacity=0);
                opacity: 0;
                outline: none;
                background: white;
                cursor: inherit;
                display: block;
            }
        </style>
        <style>
            .panel {
                background-color: #d9d1d1 ;
                margin-top: 50px;
                box-shadow: 0 0 30px  #b6a6a6;
                padding:0 15px 0 15px;
            }
            .panel-horizontal {
                background-color: #d9d1d1;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .panel-horizontal > .panel-body {
                background-color: #d9d1d1;
                border-radius: 0 4px 4px 0;
                border-left: 1px solid #ddd;
            }

        </style>
    </head>

    <body style="height: 100%">

        <sql:query var="companyQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM international_publishers
            WHERE international_publishers.Company_Number = ?
            <sql:param value="${publisherID}"/>
        </sql:query>
        <c:set var="companyDetails" value="${companyQuery.rows[0]}"/>

        <div id="shadowholder">
            <div class="shadowtop"> </div>
            <div id="container">
                <div id="topspacer"> </div>
                <div id="topbar">
                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" height="80" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>

                    <div class="container-fluid" style="margin-bottom: 20px; width: 100%">
                        <div class="pull-right">
                            <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                        </div>
                    </div> <!--container for welcome/logout-->
                </div> <!--  End of topbar div -->

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
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"  style="background-color: #d9d1d1">
                            <ul class="nav navbar-nav nav-tabs two-lines">
                                <li class="active"><a href="#info" data-toggle="tab">Info</a></li>
                                <li><a href="#Contact" data-toggle="tab">Contact details</a></li>
                                <li><a href="#books" data-toggle="tab">Book<br/> details</a></li>
                                <li><a href="#Rights" data-toggle="tab">Rights<br/>  Agreement</a></li>
                                <li><a href="#Publication" data-toggle="tab">Publication<br/>  Details</a></li>
                                <li><a href="#Translator" data-toggle="tab">Translator’s <br/> Details</a></li>
                                <li><a href="#Original" data-toggle="tab"><span>Original Work &<br/> Sample Translation</span></a></li>
                            </ul>
                        </div><!-- /.navbar-collapse -->

                        <form  method="POST" id="applicationForm" name="applicationForm" action="${pageContext.request.contextPath}/GrantApplicationServlet" enctype="multipart/form-data">

                            <div id="my-tab-content" class="tab-content"  style="background-color: #E8F6FF">
                                <!-- Info -->
                                <div class="tab-pane active" id="info">       
                                    <br/>
                                    <br/>
                                    <img style="margin:0px auto;display:block" src="images/favicon.png" alt="favicon" width="50" height="50"/>
                                    <h1 align="center" style="margin-bottom: 40px; margin-top: 60px"> <span class="glyphicon glyphicon-exclamation-sign icon-exclamation"></span> 
                                        Information - Please read!
                                        <span class="glyphicon glyphicon-exclamation-sign  icon-exclamation"></span> 
                                    </h1>
                                    <p>                               

                                    <h2><strong>Translation Grant Programme Application Checklist</strong></h2>
                                    <br/>
                                    <br/>
                                    <strong>Your application to the Literature Ireland Translation Grant Programme should include the following:</strong>
                                    <br/>
                                    <br/>
                                    <h3> Contact Details</h3>
                                    <ul class="dashed">
                                        <li>The name, address, email and phone number of the applicant</li>
                                    </ul>

                                    <h3> Contracts</h3>
                                    <ul class="dashed">
                                        <li>A copy of the agreement with the translation rights holder (where applicable)<br/>
                                        <li> A copy of the contract with the translator </li>
                                    </ul>

                                    <h3> Publication Details</h3>
                                    <ul class="dashed">
                                        <li>The proposed date of publication<br/>
                                        <li>The proposed print run<br/></li>
                                        <li>The planned page extent of the published translation </li>
                                    </ul>

                                    <h3> Translator’s Details</h3>
                                    <ul class="dashed">
                                        <li>A copy of the translator’s CV, including a list of previous published literary translations</li>
                                        <li>Details of the fee to be paid to the translator (this should include the total sum in Euro and a breakdown of the rate according to which this sum has been calculated)</li>
                                    </ul>

                                    <h3> Original Work & Sample Translation</h3>
                                    <ul class="dashed">
                                        <li>Two copies of the original work* </li>
                                        <li>Two copies of a translation sample** consisting of 10–12 pages of prose or six poems</li>
                                    </ul>

                                    <br/>
                                    <p> <i> * &nbsp; Please contact Literature Ireland if two copies of the original work cannot be obtained.<br/>
                                            ** If more than one translator is involved, a translation sample must be submitted for each translator.
                                        </i> </p>


                                    <!--in Panel-->
                                    <div class = "panel panel-default">
                                        <div class = "panel-body">

                                            <input type="checkbox" name="checkbox" value="check" id="agree" /> I have read and agree to the Terms and Conditions and Privacy Policy
                                            <input type="submit" name="submit" value="submit" />

                                            <h1>Terms and Conditions</h1><br/>


                                            <div class="checkbox">                                                             
                                                <label style="margin-bottom: 30px" for="TC_ACCEPTED">By clicking on the "<i>I accept</i>" button, you are confirming that you have <strong>read</strong> and <strong>accepted</strong> <br/>the terms and conditions of use of this website (including disclaimer).</label>
                                                <br/>
                                                <label style="font-size: 2.0em; " class="checkbox-inline  no_indent">
                                                    <input type="checkbox" 
                                                           name="TC_ACCEPTED" 
                                                           id="TC_ACCEPTED" 
                                                           value="ticked" 
                                                           class="form-control">
                                                    <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
                                                </label>                                                          
                                            </div>
                                            <a href="${pageContext.request.contextPath}/termsConditions.jsp">read Terms and Conditions</a>
                                        </div>  <!-- panel-body-->     
                                    </div>  <!-- panel --> 
                                    <br/>


                                    All queries in relation to the Translation Grant Programme should be addressed to Deputy Director Rita McCann at rita[at]literatureireland[dot]com or Administrator Orla King at orla[at]literatureireland[dot]com.
                                    <br/>
                                    <br/>

                                    <h1>NOTES</h1>

                                    <br/>
                                    <ol>
                                        <li>The <strong>deadlines for application</strong> are available on the Literature Ireland website at <a href="http://www.literatureireland.com/programmes/translation-grant-programme/">http://www.literatureireland.com/programmes/translation-grant-programme/</a>. There are typically three deadlines per year.  </li>

                                        <li>The deadline for application is the <strong>date by which applications should be received</strong> by Literature Ireland and not the date by which they should be posted. Allowance is made for postal delays but submissions received more than one week after the deadline may not be accepted.  </li>

                                        <li><strong>Late applications</strong> may, in rare cases, be accepted at the discretion of Literature Ireland. However, late submission will affect the timeliness with which the applicant publisher can be informed of the outcome of his/her application. </li>

                                        <li>It is recommended that the <strong>translation sample</strong> submitted be a final or near-final version which has been <strong>proofread and edited</strong>. If the sample submitted is an early or unedited draft, the applicant is requested to inform Literature Ireland of this fact.  </li>

                                        <li>Literature Ireland maintains records of the <strong>average/typical rates paid to literary translators</strong> in different countries. If the rate being paid to the translator is substantially different from that which might be usual, the applicant is requested to include an explanation for this in his/her application. </li> 

                                        <li> For each application, the <strong>translation sample is assessed by an independent expert</strong>, who provides a report which is made available to the board of Literature Ireland when it considers the request for funding (see note 7). </li>

                                        <li>All applications are considered by the board of Literature Ireland at meeting held six to <strong>eight weeks after the deadline</strong>. Applications for translations due for publication before the date of the board meeting will be deemed ineligible.  </li>

                                        <li>Applicants are informed of the <strong>outcome of the application</strong> within 10 days of the board meeting. Successful applicants will be issued with formal contracts and a letter of award within six weeks of grant approval.   </li> 
                                    </ol>
                                </div>


                                <!-- Contact details -->

                                <div class="tab-pane" id="Contact">
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
                                                        onblur="CheckboxValue();"
                                                        placeholder="Company Name"
                                                        >
                                                <!--refreshdoNotMailCheckboxValue();refreshCheckboxValue();"-->
                                            </div>

                                            <div class="col-sm-4">        
                                                <input id="Company_Number"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Company_Number"                                
                                                       value="${publisherID}"                                   
                                                       placeholder="internal Company Number"

                                                       >
                                            </div>
                                        </div> <!--row-->

                                        <!--second row-->

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <input id="Address1"
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Address1"                                
                                                       value="${companyDetails.Address1}"                                
                                                       placeholder="Address1"
                                                       >
                                            </div>
                                            <div class="col-sm-2">
                                                <input id="postCode"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="postCode"                                
                                                       value="${companyDetails.postCode}"                                
                                                       placeholder="Post Code"
                                                       >
                                            </div>
                                            <div class="col-sm-3">
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

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <input id="Address2"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Address2"                                
                                                       value="${companyDetails.Address2}"                                
                                                       placeholder="Address2"
                                                       >
                                            </div>

                                            <div class="col-sm-5">
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

                                        <div class="row">
                                            <div class="col-sm-6">
                                                <input id="Address3"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Address3"                                
                                                       value="${companyDetails.Address3}"                                
                                                       placeholder="Address3"
                                                       >
                                            </div>
                                            <div class="col-sm-2">   
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

                                        <div class="row" style="margin-bottom: 5px">
                                            <div class="col-sm-6">       
                                                <input id="Address4"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Address4"                                
                                                       value="${companyDetails.Address4}"                                
                                                       placeholder="Address4"
                                                       >
                                            </div>
                                            <div class="col-sm-3">
                                                <input id="Telephone"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Telephone"                                
                                                       value="${companyDetails.Telephone}"                                
                                                       placeholder="Telephone"
                                                       >
                                            </div>
                                        </div> <!--row-->

                                        <!--sixth row-->

                                        <div class="row" style="margin-bottom: 20px">
                                            <div class="col-sm-6"></div>
                                            <div class="col-sm-3">
                                                <input id="Fax"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Fax"                                
                                                       value="${companyDetails.Fax}"                                
                                                       placeholder="Fax Number"
                                                       >
                                            </div>
                                        </div> <!--row-->
                                    </div> <!--container-->

                                    <!--seventh row-->

                                    <div class="container">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <input id="Email"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Email"                                
                                                       value="${companyDetails.Email}"                                
                                                       placeholder="Main Email"
                                                       >
                                            </div>
                                            <div class="col-sm-4">
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
                                        <div class="row" >
                                            <div class="container">
                                                <div class="col-sm-3">        
                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="doNotMail" 
                                                                   type="checkbox" 
                                                                   name="doNotMail" 
                                                                   value="${companyDetails.doNotMail}"     

                                                                   >  DO NOT MAIL
                                                        </label>
                                                    </div><!--checkbox-->
                                                </div> <!--<div class="col-sm-3">-->   
                                                <div class="col-sm-3">

                                                    <div class="checkbox">
                                                        <label>
                                                            <input id="Bursaries" 
                                                                   type="checkbox"  
                                                                   name="Bursaries" 
                                                                   value="${companyDetails.Bursaries}"

                                                                   > Bursaries 
                                                        </label>                 
                                                    </div><!--checkbox-->
                                                </div><!--<div class="col-sm-3">-->      

                                            </div> <!--container-->
                                        </div> <!--row-->

                                    </div> <!--container-->

                                    <div class="container">

                                        <!--ninth row-->
                                        <div class="row" style="margin-bottom: 10px">
                                            <div class="col-sm-3">    
                                                <input id="Founded"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="Founded"                                
                                                       value="${companyDetails.Founded}"                                                                  
                                                       placeholder="Founded"
                                                       >
                                            </div>
                                            <div class="col-sm-3">    
                                                <input id="NumberOfTitles"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="NumberOfTitles"                                
                                                       value="${companyDetails.NumberOfTitles}"                       
                                                       placeholder="Number of Titles"
                                                       >      
                                            </div>
                                            <div class="col-sm-3">    
                                                <input id="DateModified"                                
                                                       type="text"                                
                                                       class="form-control"                                
                                                       name="DateModified"                                
                                                       value="${companyDetails.DateModified}"    
                                                       readonly
                                                       placeholder="Date modified"
                                                       >
                                            </div>
                                        </div> <!--row-->
                                    </div> <!--container-->

                                    <!--last row-->


                                    <div class="container">
                                        <!--keep in one line otherwise placeholder doesn't show-->
                                        <textarea id="Notes" 
                                                  class="form-control" 
                                                  style="width: 883px; height: 343px;" 
                                                  name="Notes"            
                                                  placeholder="enter optional notes"
                                                  >                 
                                            <c:out value="${companyDetails.Notes}" />
                                        </textarea>
                                    </div> <!--container-->
                                </div>

                                <!-- Book Details -->
                                <div class="tab-pane" id="books">
                                    <h1 style="margin-bottom: 40px">Book Details</h1>
                                    <div class="container-fluid">
                                        <div class="row"  style="display: block;
                                             margin-right: auto;
                                             margin-left: auto;">

                                            <!--First row-->
                                            <!--in Panel-->
                                            <div class = "panel panel-default">
                                                <div class = "panel-body">
                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="form-group">
                                                            <div class="col-sm-4">    
                                                                <label for="bookID" class="pull-left">Book ID</label>
                                                                <input id="bookID"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="bookID"                                
                                                                       value=""                                                                  
                                                                       placeholder="We will fill that in for you"
                                                                       readonly
                                                                       >
                                                            </div>

                                                            <div class="col-sm-4">  
                                                                <label for="referenceNumber" class="pull-left">Reference Number</label>
                                                                <input id="referenceNumber"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="referenceNumber"                                
                                                                       value=""                         
                                                                       placeholder="We will fill that in for you"
                                                                       readonly
                                                                       >      
                                                            </div>
                                                        </div> <!--form-group-->                                                                                                                            
                                                    </div> <!--row-->
                                                </div>  <!-- panel-body-->     
                                            </div>  <!-- panel --> 

                                            <!--Second row-->
                                            <!--in Panel-->
                                            <div class = "panel panel-default">
                                                <div class = "panel-body">

                                                    <div class="row" style="margin-bottom: 10px">
                                                        <div class="col-sm-4">    
                                                            <label for="author" class="pull-left">Author</label>
                                                            <input id="author"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="author"                                
                                                                   value=""    
                                                                   placeholder="Author"
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">    
                                                            <label for="title" class="pull-left">Title</label>
                                                            <input id="title"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="title"                                
                                                                   value=""    
                                                                   placeholder="Title"
                                                                   >
                                                        </div>

                                                    </div> <!--row-->

                                                    <!--Third row-->

                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="col-sm-4">          
                                                            <label for="publisher" class="pull-left">Publisher</label>
                                                            <input id="publisher"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="publisher"                                
                                                                   value="${companyDetails.Company}"    
                                                                   placeholder="Publisher"
                                                                   >                                                     
                                                        </div>


                                                        <div class="col-sm-4">    
                                                            <label for="publicationYear" class="pull-left">Publication Year</label>
                                                            <input id="publicationYear"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="publicationYear"                                
                                                                   value=""    
                                                                   placeholder="Publication Year"
                                                                   >
                                                        </div>
                                                    </div> <!--row-->


                                                    <!--Fourth row-->

                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="col-sm-4">    
                                                            <div class="form-group has-feedback">
                                                                <label for="genre" class="pull-left">Genre</label>
                                                                <input id="genre"                                
                                                                       type="text"                                
                                                                       class="form-control"                                
                                                                       name="genre"                                
                                                                       value=""    
                                                                       placeholder="Genre"
                                                                       >
                                                                <i class="glyphicon glyphicon-search form-control-feedback"></i>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-4">    
                                                            <label for="translationTitle" class="pull-left">Translation Title</label>
                                                            <input id="translationTitle"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="translationTitle"                                
                                                                   value=""    
                                                                   placeholder="Translation Title"
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <!--Fifth row-->

                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="col-sm-4">    
                                                            <label for="translationPublisher" class="pull-left">Translation Publisher</label>
                                                            <input id="translationPublisher"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="translationPublisher"                                
                                                                   value=""    
                                                                   placeholder="Translation Publisher"
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">   
                                                            <label for="translationPublicationYear" class="pull-left">Translation Publication Year</label>
                                                            <input id="translationPublicationYear"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="translationPublicationYear"                                
                                                                   value=""    
                                                                   placeholder="Translation Publication Year"
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">    
                                                            <label for="translatorN" class="pull-left">Translator</label>
                                                            <input id="translatorN"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="translator"                                
                                                                   value=""    
                                                                   placeholder="Translator"
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <!--Sixth row-->

                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="col-sm-4">    
                                                            <label for="language" class="pull-left">Language</label>
                                                            <input id="language"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="language"                                
                                                                   value=""    
                                                                   placeholder="Language"
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4">    
                                                            <label for="physicalDescription" class="pull-left">Physical Description</label>
                                                            <input id="physicalDescription"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="physicalDescription"                                
                                                                   value=""    
                                                                   placeholder="Physical Description"
                                                                   >
                                                        </div>

                                                        <div class="col-sm-4"> 
                                                            <label for="duplicates" class="pull-left">Duplicates</label>
                                                            <input id="duplicates"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="duplicates"                                
                                                                   value=""    
                                                                   placeholder="Duplicates"
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <!--Seventh row-->

                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="col-sm-3">    
                                                            <label for="isbn" class="pull-left">ISBN</label>
                                                            <input id="isbn"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="isbn"                                
                                                                   value=""    
                                                                   placeholder="ISBN"
                                                                   >
                                                        </div>


                                                        <div class="col-sm-3">    
                                                            <label for="isnn" class="pull-left">ISNN</label>
                                                            <input id="isnn"                                
                                                                   type="text"                                
                                                                   class="form-control"                                
                                                                   name="isnn"                                
                                                                   value=""    
                                                                   placeholder="ISNN"
                                                                   >
                                                        </div>
                                                    </div> <!--row-->

                                                    <!--Eigth row-->

                                                    <div class="row" style="margin-bottom: 10px">

                                                        <div class="col-sm-4">   
                                                            <label for="notes" class="pull-left">Notes</label>
                                                            <div class="form-group">
                                                                <textarea class="form-control" id="notes" name="notes" style="width: 800px; height: 215px" placeholder="Notes"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>  <!-- panel-body-->     
                                            </div>  <!-- panel --> 
                                        </div> 
                                    </div>
                                </div> <!-- class="tab-pane" id="books" -->

                                <!-- Rights Agreement -->
                                <div class="tab-pane" id="Rights">
                                    <h1 style="margin-bottom: 40px">Rights Agreement</h1>
                                    <div class="container-fluid">
                                        <div class="row"  style="display: block;
                                             margin-right: auto;
                                             margin-left: auto;">

                                            <!--Upload form for agreement-->

                                            <div class="col-md-12"   style="margin-bottom: 60px">                                                
                                                <strong class="pull-left">Upload a copy of the agreement with the translation rights holder</strong> <br/>(where applicable)
                                                <div class="margin-bottom: 60px"></div>   
                                                <br/>
                                                <div class="input-group agreement"  style="margin-bottom: 40px;">                                      
                                                    <label class="btn btn-default btn-file pull-left">
                                                        Select file <input type="file"  name="file" id="agreement" >
                                                        <span class="glyphicon glyphicon-folder-open"></span>
                                                    </label>

                                                    <input type="hidden" name="userID" value="${userID}">
                                                    <input type="hidden" name="publisherID" value="${publisherID}">
                                                    <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                    <input id="label_agreement" class="pull-left"/>
                                                    <br/>
                                                    <br/>
                                                    <input type="hidden" value="Agreement" name="destination" id="agreement_upload"/>
                                                </div>
                                            </div>


                                            <!--Upload form for contract-->

                                            <div class="col-md-12"   style="margin-bottom: 60px">                          
                                                <strong class="pull-left">Upload a copy of the contract with the translator</strong> <br/>
                                                <div class="margin-bottom: 60px"></div>
                                                <br/>
                                                <div class="input-group contract"  style="margin-bottom: 40px;">
                                                    <label class="btn btn-default btn-file pull-left">
                                                        Select file <input type="file"  name="file" id="contract">
                                                        <span class="glyphicon glyphicon-folder-open"></span>
                                                    </label>

                                                    <input type="hidden" name="userID" value="${userID}">
                                                    <input type="hidden" name="publisherID" value="${publisherID}">
                                                    <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                    <input id="label_contract" class="pull-left"/>
                                                    <br/>
                                                    <br/> 
                                                    <!--<label>Destination:</label>-->
                                                    <input type="hidden" value="Contract" name="destination" id="contract_upload"/>

                                                    ${requestScope.message}
                                                </div>
                                            </div>

                                        </div> <!-- row -->
                                    </div> <!-- container-fluid  -->
                                </div> <!-- class="tab-pane" id="orange" -->

                                <!-- Publication Details -->
                                <div class="tab-pane" id="Publication">
                                    <h1 style="margin-bottom: 60px">Publication Details</h1>

                                    <div class="container-fluid">
                                        <div class="row"  style="display: block;
                                             margin-right: auto;
                                             margin-left: auto;">
                                            <div class="col-xs-12 content">

                                                <div class='col-sm-8'  style="margin-bottom: 40px; margin-top: 20px">
                                                    <strong> The proposed date of publication:</strong>
                                                    <div class="input-group"  style="margin-bottom: 40px;">
                                                        <input type="text" name="proposedDateOfPublication" id="proposed-date-of-publication" class="form-control" placeholder="DD/MM/YYYY" />    
                                                        <label class="input-group-addon" for="proposed-date-of-publication">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </label>
                                                    </div>

                                                    <strong>   The date of proposed print run:</strong> 
                                                    <div class="input-group"  style="margin-bottom: 40px;">
                                                        <input type="text" name="proposedDateOfPrintRun" id="proposed-print-run" class="form-control" placeholder="DD/MM/YYYY" />    
                                                        <label class="input-group-addon" for="proposed-print-run">
                                                            <span class="glyphicon glyphicon-calendar"></span>
                                                        </label>
                                                    </div>

                                                    <strong  style="margin-bottom: 40px;">The planned page extent of the published translation:</strong>
                                                    <div class="input-group input-group-lg">
                                                        <span class="input-group-addon" id="sizing-addon1">  <span class="glyphicon glyphicon-book"></span></span>
                                                        <input type="text" name="plannedPageExtent" class="form-control" placeholder="number of pages" aria-describedby="sizing-addon1">
                                                    </div>
                                                </div>
                                                <script>
                                                    $("#proposed-date-of-publication").datepicker({
                                                        format: "dd/mm/yyyy",
                                                        showWeekDays: true,
                                                        todayHighlight: true,
                                                        autoclose: true
                                                    });
                                                </script>
                                                <script>
                                                    $("#proposed-print-run").datepicker({
                                                        format: "dd/mm/yyyy",
                                                        showWeekDays: true,
                                                        todayHighlight: true,
                                                        autoclose: true
                                                    });
                                                </script>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Translator’s Details -->
                                <div class="tab-pane" id="Translator">                           
                                    <div class="container-fluid">

                                        <div class="col-md-8"   style="margin-bottom: 60px">
                                            <h1 style="margin-top: 50px; margin-bottom: 20px">Upload a copy of the Translator's CV:<br/>
                                                <small>this should include a list of previous published literary translations</small></h1>                                    
                                            <br/>
                                            <div class="input-group translator_cv"  style="margin-bottom: 40px;">
                                                <label class="btn btn-default btn-file pull-left">
                                                    Select file <input type="file"  name="file" id="translator" >
                                                    <span class="glyphicon glyphicon-folder-open"></span>
                                                </label>
                                                <input id="label_translator" class="pull-left"/>
                                                <br/>
                                                <br/>          
                                                <input type="hidden" name="userID" value="${userID}">
                                                <input type="hidden" name="publisherID" value="${publisherID}">
                                                <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                <!--                                                    Destination:-->
                                                <input type="hidden" id="translator_cv_upload" value="Translator_CV" name="destination" />                                          

                                            </div>

                                        </div>

                                        <div class="col-md-4" style="margin-bottom: 20px ;margin-top: 50px;">

                                            Number of pages:<input type="text"  name="numberOfPages" id="numberOfPages"  style="margin-bottom: 30px"/><br/>
                                            Fee per page: 
                                            <input type="text"  name="feePerPage"  id="feePerPage"   style="margin-bottom: 30px"/>
                                            <button type="button" class="btn btn-default"  id='submit' onclick="getTotal()" style="margin-bottom: 10px">Calculate fee</button>

                                            <strong>Translator fee:</strong>                                                                        
                                            <div class="input-group" style="margin-bottom: 40px">
                                                <label class="input-group-addon" for="translatorFee">
                                                    <span class="glyphicon glyphicon-euro"></span>                                     
                                                </label>
                                                <input type="text" class="form-control" name="translatorFee" id="translatorFee" placeholder="fee">    
                                            </div>

                                            <div class="form-group">
                                                <textarea class="form-control" placeholder="Notes" name="Notes"
                                                          style="width: 280px; height: 196px;"></textarea>
                                            </div>
                                        </div> 
                                    </div>              
                                </div>

                                <!-- Original Work & Sample Translation -->
                                <div class="tab-pane" id="Original">
                                    <h1>Original Work & Sample Translation</h1>
                                    <div class="container-fluid">
                                        <div class="row" >
                                            <div class="panel panel-default">
                                                <div class="panel-body">

                                                    <!--copies of the original work-->
                                                    <div class="col-md-9"   style="margin-bottom: 40px; margin-top: 40px">
                                                        <div class="checkbox">                                                             
                                                            <label for="copies" class=" pull-left"><strong>Two copies of the original work<sup>*</sup> sent to Irish Literature by mail</strong></label>
                                                            <label style="font-size: 2.0em; " class="checkbox-inline  no_indent">
                                                                <input type="checkbox" 
                                                                       name="copiesSent" 
                                                                       id="copiesSent" 
                                                                       value="ticked" 
                                                                       class="form-control">
                                                                <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
                                                            </label>
                                                            <!--<input type="text" name="ApplicationNumber" value="${ApplicationNumber}">-->
                                                            <input type="hidden" name="userID" value="${userID}">
                                                            <input type="hidden" name="publisherID" value="${publisherID}">
                                                            <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                        </div>
                                                    </div> <!-- col-md-9 -->

                                                    <!--Date copies were sent:-->
                                                    <div class="col-md-3"   style="margin-top: 30px">
                                                        <strong>Date copies were sent:</strong> 
                                                        <div class="input-group">
                                                            <input type="text" name="dateCopiesWereSent" id="dateCopiesWereSent" class="form-control" placeholder="DD/MM/YYYY" />    
                                                            <label class="input-group-addon" for="dateCopiesWereSent">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </label>
                                                        </div>  <!-- input-group -->
                                                    </div> <!--col-md-3-->

                                                    <!--datepicker  mail-sent-->
                                                    <script>
                                                        $("#dateCopiesWereSent").datepicker({
                                                            format: "dd/mm/yyyy",
                                                            showWeekDays: true,
                                                            todayHighlight: true,
                                                            autoclose: true
                                                        });
                                                    </script>

                                                </div> <!--panel--body-->
                                            </div> <!--panel-default-->
                                        </div> <!-- row -->

                                        <div class="row" >
                                            <div class="panel panel-default">        
                                                <div class="panel-body">
                                                    <div class="col-md-12" style="margin-bottom: 40px; margin-top: 60px">

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

                                                        <strong style="margin-bottom: 20px" class="pull-left">Two copies of a translation sample<sup>**</sup> consisting of 10–12 pages of prose or six poems</strong> 
                                                        <br/>
                                                        <div class="input-group agreement translationSample" >                                      
                                                            <label class="btn btn-default btn-file pull-left">
                                                                Select file <input type="file"  name="file" id="translationSample" >
                                                                <span class="glyphicon glyphicon-folder-open"></span>
                                                            </label>
                                                            <input id="label_translationSample" class="pull-left"/>
                                                            <br/>
                                                            <br/>       
                                                            <input type="hidden" name="userID" value="${userID}">
                                                            <input type="hidden" name="publisherID" value="${publisherID}">
                                                            <input type="hidden" name="Company" value="${companyDetails.Company}">
                                                            <input type="hidden" value="TranslationSample" name="destination"/>
                                                        </div>
                                                        <!-- translationSampleForm -->                                                                                                              
                                                    </div>  <!-- col-md-12 -->
                                                </div>  <!--panel--body-->
                                            </div> <!--panel-default-->
                                        </div> <!-- row -->
                                        <div class="row" >
                                            <div class="panel panel-default">        
                                                <div class="panel-body">
                                                    <!--<div class="col-md-12" style="margin-bottom: 40px; margin-top: 60px">-->

                                                    <div class="col-md-9"   style="margin-bottom: 10px; margin-top: 10px;">
                                                        <div class="input-group input-group-lg">Finally <br/>
                                                            <button type="submit"                                                                          
                                                                    data-toggle="tooltip" 
                                                                    class="btn btn-success"
                                                                    title="Click to save!"
                                                                    style="margin-bottom: 10px"
                                                                    >
                                                                Make the application
                                                                <span class="glyphicon glyphicon-import"></span>
                                                            </button>
                                                        </div><!-- input-group -->
                                                    </div>  <!-- col-md-9 -->
                                                </div>  <!-- panel--body -->
                                            </div>  <!--panel--default-->                                                
                                        </div> <!-- row -->
                                        <hr/>
                                        <div class="col-md-10">
                                            <i class="pull-left"><strong>*</strong> Please contact Literature Ireland if two copies of the original work cannot be obtained.<br/>
                                                &nbsp;  <strong>**</strong> If more than one translator is involved, a translation sample must be submitted for each translator.</i>
                                        </div>    
                                    </div>  <!-- container-fluid -->
                                </div> <!-- tab-pane Original --> 
                            </div> <!-- my-tab-content -->
                        </form> 
                    </div><!-- container-fluid -->
                </nav>

                <form class="form-horizontal" 
                      role="form"  
                      autocomplete="on"  
                      action="${pageContext.request.contextPath}/Application" 
                      method="POST" 
                      name="regF"
                      >

                    <div class="container col-sm-12" style="margin-bottom: 40px">
                        <button type="submit" class = "btn btn-default btn-sm active" name="New Application">
                            New Application
                        </button>

                        <button type = "submit" class = "btn btn-default btn-sm"  name="List New Applications">
                            List New Applications
                        </button>

                        <button type = "submit" class = "btn btn-default btn-sm" name="List Pending Applications">
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
