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
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>

        <script>
            function getNumberPages()
            {
                //Assume form with id="theform"
                var theForm = document.forms["feeCalculationForm"];
                //Get a reference to the TextBox
                var numberPages = theForm.elements["numberPages"];
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
                var feePerPage = theForm.elements["feePerPage"];
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
                document.getElementById("fee").value = feeTotal.toFixed(2).replace(/./g, function (c, i, a) {
                    return i && c !== "." && ((a.length - i) % 3 === 0) ? ',' + c : c;
                });
            }
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
        </style>

        <!--Checkboxes with tick mark-->
        <style>
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

            .nav-tabs.two-lines>li {
                height:62px;
            }
            .nav-tabs.two-lines>li>a, .nav-tabs>li>a>div {
                height:100%;

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

            <script>
                $(function () {
                    $('div.agreement').on('change', ':file', function () {
                        var input = $(this),
                                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        input.trigger('fileselect', [numFiles, label]);
                        document.getElementById("label_agreement").value = label;

//                        var ttt = $('#agreement_upload').val();
//                        console.log("ttt::  " + ttt);
//                        alert(ttt);
//                        document.getElementById("agreement_upload").value = $('#agreement_upload').val() + label;
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
            </style>
        </head>

        <body style="height: 100%">
                <sql:query var="applicationQuery" dataSource="jdbc/ILGAS">
                    SELECT * FROM GrantApplication
                    WHERE GrantApplication.ApplicationNumber = ? AND GrantApplication.Status = 'new'
                    <sql:param value="${ApplicationNumber}"/>
                </sql:query>
                <c:set var="applicationDetails" value="${applicationQuery.rows[0]}"/>

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
                            <!--container for welcome/logout-->
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
                                        <li><a href="#Rights" data-toggle="tab">Rights Agreement</a></li>
                                        <li><a href="#Publication" data-toggle="tab">Publication Details</a></li>
                                        <li><a href="#Translator" data-toggle="tab">Translator’s Details</a></li>
                                        <li><a href="#Original" data-toggle="tab"><span>Original Work &<br/> Sample Translation</span></a></li>
                                    </ul>
                                </div><!-- /.navbar-collapse -->
                                <div id="my-tab-content" class="tab-content"  style="background-color: #E8F6FF">
                                    <!-- Info -->
                                    <div class="tab-pane active" id="info">       
                                        <br/>
                                        <br/>
                                        <img style="margin:0px auto;display:block" src="images/favicon.jpg" alt="favicon"/>
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


                                        <h1> PLEASE COMPLETE AND PRINT THIS FORM FOR INCLUSION WITH YOUR APPLICATION</h1>
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
                                        <h1 style="margin-bottom: 40px">Update Contact details</h1>
                                        <div class="container-fluid">

                                            <!--Form Contactdetails-->
                                            <form id="Contactdetails" class="form-horizontal" action="${pageContext.request.contextPath}/login.do" 
                                                  method="POST"  role="form" >
                                                <div class="col-md-9" >
                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                        <input id="Company" type="text" class="form-control" name="company" value="${companyDetails.Company}" placeholder="Publishing Company Name">                                        
                                                    </div>

                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                        <input id="firstname" type="text" class="form-control" name="firstname" value="${companyDetails.firstname}" placeholder="${firstname}">                                        
                                                    </div>

                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                        <input id="lastname" type="text" class="form-control" name="lastname" value="${companyDetails.lastname}" placeholder="${lastname}">                                        
                                                    </div>

                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                        <input id="Address1" type="text" class="form-control" name="Address1" value="${companyDetails.Address1}" placeholder="Address1">                                        
                                                    </div>
                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                        <input id="Address2" type="text" class="form-control" name="Address2" value="${companyDetails.Address2}" placeholder="Address2">                                        
                                                    </div>
                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                        <input id="Address3" type="text" class="form-control" name="Address3" value="${companyDetails.Address3}" placeholder="Address3">                                        
                                                    </div>
                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                        <input id="Address4" type="text" class="form-control" name="Address4" value="${companyDetails.Address4}" placeholder="Address4">                                        
                                                    </div>
                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                        <input id="City" type="text" class="form-control" name="City" value="${companyDetails.City}" placeholder="City/Town">                                        
                                                    </div>
                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                        <input id="postCode" type="text" class="form-control" name="postCode" value="${companyDetails.postCode}" placeholder="Post Code">                                        
                                                    </div>

                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                                        <input id="Email" type="text" class="form-control" name="Email" value="${companyDetails.Email}" placeholder="Email address">                                        
                                                    </div>

                                                    <div style="margin-bottom: 25px" class="input-group">
                                                        <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
                                                        <input id="Telephone" type="text" class="form-control" name="Telephone" value="${companyDetails.Telephone}" placeholder="Telephone number ">                                        
                                                    </div>

                                                   
                                                      <div class="input-group input-group-lg" style="margin-top: 40px; margin-bottom: 40px;">

                                                            <button type="submit"  name="save_UpdatedDetails" id="save_UpdatedDetails" 
                                                                    data-toggle="tooltip" title="Click to save!"
                                                                    >
                                                                Save Updated Details
                                                                <span class="glyphicon glyphicon-import"></span>
                                                            </button>
                                                        </div>
                                                </div>
                                            </form>
                                        </div> <!-- container-fluid -->
                                    </div> <!-- class="tab-pane" id="red" -->

                                    <!-- Rights Agreement -->
                                    <div class="tab-pane" id="Rights">
                                        <h1 style="margin-bottom: 40px">Rights Agreement</h1>
                                        <div class="container-fluid">
                                            <div class="row"  style="display: block;
                                            margin-right: auto;
                                            margin-left: auto;">

                                            <!--Upload form for agreement-->
                                            <form method="POST" action="upload" enctype="multipart/form-data">
                                                <div class="col-md-12"   style="margin-bottom: 60px">                                                
                                                        <strong class="pull-left">Upload a copy of the agreement with the translation rights holder</strong> <br/>(where applicable)
                                                        <div class="margin-bottom: 60px"></div>   
                                                        <br/>
                                                        <div class="input-group agreement"  style="margin-bottom: 40px;">                                      
                                                        <label class="btn btn-default btn-file pull-left">
                                                            Select file <input type="file"  name="file" id="agreement" >
                                                            <span class="glyphicon glyphicon-folder-open"></span>
                                                        </label>
                                                        <input id="label_agreement" class="pull-left"/>
                                                        <br/>
                                                        <br/>  
                                                        <label>Destination:</label>                                              
                                                        <input type="text" value="/home/markus/test/" name="destination" id="agreement_upload"/>
                                                        <button type="submit"  name="upload_agreement" id="upload_agreement" 
                                                                data-toggle="tooltip" title="Click to UPLOAD!">
                                                            Upload
                                                            <span class="glyphicon glyphicon-import"></span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </form> 

                                            <!--Upload form for contract-->
                                            <form method="POST" action="upload" enctype="multipart/form-data" >
                                                <div class="col-md-12"   style="margin-bottom: 60px">                          
                                                        <strong class="pull-left">Upload a copy of the contract with the translator</strong> <br/>
                                                        <div class="margin-bottom: 60px"></div>
                                                        <br/>
                                                        <div class="input-group contract"  style="margin-bottom: 40px;">
                                                        <label class="btn btn-default btn-file pull-left">
                                                            Select file <input type="file" style="display: none;" name="file" id="contract">
                                                            <span class="glyphicon glyphicon-folder-open"></span>
                                                        </label>
                                                        <input id="label_contract" class="pull-left"/>
                                                        <br/>
                                                        <br/> 
                                                        <label>Destination:</label>
                                                        <input type="text" value="/home/markus/test/" name="destination" id="contract_upload"/>
                                                        <button type="submit"  name="contract_upload" id="upload_contract" 
                                                                data-toggle="tooltip" title="Click to UPLOAD!">
                                                            Upload
                                                            <span class="glyphicon glyphicon-import"></span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>  
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
                                                <form id="publicationDetailsForm" 
                                                      class="form-horizontal" 
                                                      action="${pageContext.request.contextPath}/Application" 
                                                      method="POST"  
                                                      role="form" 
                                                      >
                                                    <div class='col-sm-8'  style="margin-bottom: 40px; margin-top: 20px">
                                                            <strong> The proposed date of publication:</strong>
                                                            <div class="input-group"  style="margin-bottom: 40px;">
                                                            <input type="text" id="proposed-date-of-publication" class="form-control" placeholder="DD/MM/YYYY" />    
                                                            <label class="input-group-addon" for="proposed-date-of-publication">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </label>
                                                        </div>

                                                        <strong>   The date of proposed print run:</strong> 
                                                        <div class="input-group"  style="margin-bottom: 40px;">
                                                            <input type="text" id="proposed-print-run" class="form-control" placeholder="DD/MM/YYYY" />    
                                                            <label class="input-group-addon" for="proposed-print-run">
                                                                <span class="glyphicon glyphicon-calendar"></span>
                                                            </label>
                                                        </div>

                                                        <strong  style="margin-bottom: 40px;">The planned page extent of the published translation:</strong>
                                                        <div class="input-group input-group-lg">
                                                            <span class="input-group-addon" id="sizing-addon1">  <span class="glyphicon glyphicon-book"></span></span>
                                                            <input type="text" class="form-control" placeholder="number of pages" aria-describedby="sizing-addon1">
                                                        </div>
                                                        <!--</div>-->
                                                        <div class="input-group input-group-lg" style="margin-top: 40px;">

                                                            <button type="submit"  name="save_PublicationDetails" id="save_PublicationDetails" 
                                                                    data-toggle="tooltip" title="Click to save!"
                                                                    >
                                                                Save
                                                                <span class="glyphicon glyphicon-import"></span>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <script>
                                                        $("#proposed-date-of-publication").datepicker({
                                                            format: "D dd/mm/yyyy",
                                                            showWeekDays: true,
                                                            todayHighlight: true,
                                                            autoclose: true
                                                        });
                                                    </script>
                                                    <script>
                                                        $("#proposed-print-run").datepicker({
                                                            format: "D dd/mm/yyyy",
                                                            showWeekDays: true,
                                                            todayHighlight: true,
                                                            autoclose: true
                                                        });
                                                    </script>
                                                </form>
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
                                                <form method="POST" action="upload" enctype="multipart/form-data" >                                      
                                                    <br/>
                                                    <!--<input type="file" name="file" id="translator_cv" /> <br/>-->
                                                    <div class="input-group translator_cv"  style="margin-bottom: 40px;">
                                                    <label class="btn btn-default btn-file pull-left">
                                                        Select file <input type="file" style="display: none;" name="file" id="translator" >
                                                        <span class="glyphicon glyphicon-folder-open"></span>
                                                    </label>
                                                    <input id="label_translator" class="pull-left"/>
                                                    <br/>
                                                    <br/>                                               
                                                    Destination:
                                                    <input type="text" id="translator_cv_upload" value="/home/markus/test/" name="destination" />                                          
                                                    <button type="submit"  name="upload_translator_cv" id="upload_translator_cv" 
                                                            data-toggle="tooltip" title="Click to UPLOAD!">
                                                        Upload
                                                        <span class="glyphicon glyphicon-import"></span>
                                                    </button>
                                                </div>
                                            </form> 
                                        </div>

                                        <div class="col-md-4" style="margin-bottom: 20px ;margin-top: 50px;">
                                            <form action="" id="feeCalculationForm"  onsubmit="return false;">
                                                Number of pages:<input type="text"  name="numberPages" id="numberPages"  style="margin-bottom: 30px"/><br/>
                                                    Fee per page: 
                                                    <input type="text"  name="feePerPage"  id="feePerPage"   style="margin-bottom: 30px"/>
                                                    <button type="submit" class="btn btn-default"  id='submit' onclick="getTotal()" style="margin-bottom: 10px">Calculate fee</button>
                                                </form>

                                                <form  method="POST" id="feeForm" action="${pageContext.request.contextPath}/Application" >
                                                    <!--<div class="col-md-4" style="margin-bottom: 60px">-->
                                                    <strong>Translator fee:</strong>                                                                        
                                                    <div class="input-group" style="margin-bottom: 40px">
                                                        <label class="input-group-addon" for="fee">
                                                            <span class="glyphicon glyphicon-euro"></span>                                     
                                                        </label>
                                                        <input type="text" class="form-control" id="fee" placeholder="fee">    
                                                    </div>

                                                    <div class="form-group">
                                                        <textarea class="form-control" placeholder="Notes" 
                                                                  style="width: 280px; height: 196px;"></textarea>
                                                </div>
                                                <!--</div>-->
                                            </form>                               

                                            <div class="input-group input-group-lg" style="margin-top: 40px;">
                                                <button type="submit"  name="save_feeForm" id="save_feeForm" 
                                                        data-toggle="tooltip" title="Click to save!"
                                                        >
                                                    Save
                                                    <span class="glyphicon glyphicon-import"></span>
                                                </button>
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
                                                                <!--<strong class="pull-left">Two copies of the original work<sup>*</sup> sent to Irish Literature by mail</strong>-->
                                                                <label for="copies" class=" pull-left"><strong>Two copies of the original work<sup>*</sup> sent to Irish Literature by mail</strong></label>
                                                                <label style="font-size: 2.0em; " class="checkbox-inline  no_indent">
                                                                <input type="checkbox" name="copies" id="copies" value=""  class="form-control">
                                                                <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
                                                            </label>
                                                        </div>
                                                    </div> <!-- col-md-9 -->

                                                    <!--Date copies were sent:-->
                                                    <div class="col-md-3"   style="margin-top: 30px">
                                                            <strong>Date copies were sent:</strong> 
                                                            <div class="input-group">
                                                                <input type="text" id="mail-sent" class="form-control" placeholder="DD/MM/YYYY" />    
                                                                <label class="input-group-addon" for="mail-sent">
                                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                                </label>
                                                            </div>  <!-- input-group -->
                                                        </div> <!--col-md-3-->

                                                        <!--datepicker  mail-sent-->
                                                        <script>
                                                            $("#mail-sent").datepicker({
                                                                format: "D dd/mm/yyyy",
                                                                showWeekDays: true,
                                                                todayHighlight: true,
                                                                autoclose: true
                                                            });
                                                        </script>
                                                        
                                                        
                                                        <div class="col-md-9"   style="margin-bottom: 40px;">
                                                        <div class="input-group input-group-lg">
                                                            <button type="submit"  
                                                                    name="save_originalwork" 
                                                                    id="save_originalwork" 
                                                                    data-toggle="tooltip" 
                                                                    title="Click to save!"
                                                                    >
                                                                Save
                                                                <span class="glyphicon glyphicon-import"></span>
                                                            </button>
                                                        </div><!-- input-group -->
                                                    </div>  <!-- col-md-12 -->
                                                </div> <!--panel--body-->
                                            </div> <!--panel-default-->
                                        </div> <!-- row -->

                                        <div class="row" >
                                            <div class="panel panel-default">        
                                                <div class="panel-body">
                                                    <div class="col-md-12" style="margin-bottom: 40px; margin-top: 60px">
                                                            <form method="POST" id="translationSampleForm" name="translationSampleForm" action="upload" enctype="multipart/form-data" >
                                                                <strong style="margin-bottom: 20px" class="pull-left">Two copies of a translation sample<sup>**</sup> consisting of 10–12 pages of prose or six poems</strong>
                                                                <div class="margin-bottom: 60px"></div>   
                                                                <br/>
                                                                <div class="input-group agreement translationSample"  style="margin-bottom: 40px;">                                      
                                                                <label class="btn btn-default btn-file pull-left">
                                                                    Select file <input type="file"  name="file" id="translationSample" >
                                                                    <span class="glyphicon glyphicon-folder-open"></span>
                                                                </label>
                                                                <input id="label_translationSample" class="pull-left"/>
                                                                <br/>
                                                                <br/>  
                                                                Destination:
                                                                <input type="text" value="/home/markus/test" name="destination"/>
                                                                <button type="submit"  name="upload_translationSample" id="upload_translationSample" 
                                                                        data-toggle="tooltip" title="Click to UPLOAD!">
                                                                    Upload
                                                                    <span class="glyphicon glyphicon-import"></span>
                                                                </button>
                                                            </div>
                                                        </form> <!-- translationSampleForm -->                                                                                                              
                                                    </div>  <!-- col-md-12 -->
                                                </div>  <!--panel--body-->
                                            </div> <!--panel-default-->
                                        </div> <!-- row -->
                                        <hr/>
                                        <div class="col-md-10">
                                            <i class="pull-left"><strong>*</strong> Please contact Literature Ireland if two copies of the original work cannot be obtained.<br/>
                                                <strong>**</strong> If more than one translator is involved, a translation sample must be submitted for each translator.</i>
                                        </div>    
                                    </div>  <!-- container-fluid -->
                                </div> <!-- tab-pane Original -->

                                <!--  ========================================================================================== -->

                            </div> <!-- tab-content -->
                        </div> <!-- /.container-fluid -->
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

                </div><!-- end of container div -->
                <div class="shadowbase"> </div>
            </div><!-- end of Shadowholder container div -->


            <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
                &copy; 2017 mgr Software
            </div>

        </body>
    </html>
