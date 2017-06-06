<%-- 
    Document   : publisherRegistration
    Created on : 14-Apr-2017, 02:32:24
    Author     : markus
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html style="height: 100%" >
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Grant Application System</title>

        <!-- Bootstrap -->
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>-->


        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">   
        <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
        <link rel="stylesheet" type="text/css" href="css/form.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">

        <script src="js/jquery-1.11.3.min.js"></script>

        <script src="js/bootstrap.js"></script>
        <script src="js/blockui.js"></script>
        <script src="js/my-block-ui.js"></script>
        <script src="js/bootstrap-select.min.js"></script>
        <script src="js/register.js"></script>
        <script src="js/bootstrap-validator.js"></script>
        <script src="js/jquery.validate.js"></script>
        <script src="js/bootstrap-show-password.js"></script>
        <script src="js/jquery-ui.js"></script>

        <style>
            .form-horizontal .control-label {
                margin-bottom: 5px;
            }
            .form-horizontal .form-group {
                margin-bottom: 5px;
                margin-left:0px;
                margin-right:0px;
            }
            body {
                background: #d9d1d1;
            }
            input[type="text"]:focus + .glyphicon-search{
                color: #FF8C00;
            }
        </style>  


        <!--autocomplete-->
        <!--AutoComplete_international_publishers-->
        <script>
            $(function () {
                $("#company").autocomplete({
                    source: 'ACintPublishers_test', // The source of the AJAX results
                    dataType: 'json',
                    data: '',
                    minLength: 3, // The minimum amount of characters that must be typed before the autocomplete is triggered
                    focus: function (event, ui) { // What happens when an autocomplete result is focused on
                        $("#company").val(ui.item.name);
                        return false;
                    },
                    select: function (event, ui) { // What happens when an autocomplete result is selected
                        $("#company").val(ui.item.name);
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


        <!--AutoComplete_country-->
        <script>
            $(function () {
                $("#country").autocomplete({
                    source: 'AutoComplete_country', // The source of the AJAX results
                    dataType: 'json',
                    data: '',
                    minLength: 3, // The minimum amount of characters that must be typed before the autocomplete is triggered
                    focus: function (event, ui) { // What happens when an autocomplete result is focused on
                        $("#country").val(ui.item.name);
                        return false;
                    },
                    select: function (event, ui) { // What happens when an autocomplete result is selected
                        $("#country").val(ui.item.name);
                        $('#countryCode').val(ui.item.id);
                    }
                });
            });
        </script>

        <!--Tooltips-->
        <script>
            $('input[type=text][name=Company]').tooltip({
                placement: "top",
                trigger: "hover"
            });
        </script>

        <!--setting checkboxes if value is true = 1 -->
        <script type="text/javascript">
            function CheckboxValue() {
                $(":checkbox").filter(function () {
                    return this.value === '1';
                }).prop("checked", "true");
            }
        </script>

        <!--clear all checkboxes onload-->
        <script type="text/javascript">
            function deCheckboxValue() {
                var w = document.getElementsByTagName('input');
                for (var i = 0; i < w.length; i++) {
                    if (w[i].type === 'checkbox') {
                        w[i].checked = false;
                    }
                }
            }
        </script>

    </head>

    <body style="height: 100%" onload="deCheckboxValue();">
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

                <div class="container-fluid" style="margin-bottom: 20px; width: 100%;">

                    <form id="newPublisherForm" 
                          class="form-horizontal" 
                          action="${pageContext.request.contextPath}/newPublisher" 
                          method="POST"  
                          role="form" 
                          >

                        <div class="container">

                            <!--first row-->

                            <div class="row" style="margin-bottom: 20px;margin-top: 30px">
                                <div class="col-sm-6">
                                    <input  id="company" 
                                            name="Company" 
                                            type="text" 
                                            value="${publisherName}"
                                            data-toggle="tooltip"
                                            title="Please Enter your Company's Name - if it does not show up please fill in the form"
                                            class="form-control"     
                                            onblur="CheckboxValue();"
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

                            <div class="row">
                                <div class="col-sm-6">
                                    <input id="Address1"
                                           type="text"                                
                                           class="form-control"                                
                                           name="Address1"                                
                                           value=""                                
                                           placeholder="Address1"
                                           >
                                </div>
                                <div class="col-sm-2">
                                    <input id="postCode"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="postCode"                                
                                           value=""                                
                                           placeholder="Post Code"
                                           >
                                </div>
                                <div class="col-sm-3">
                                    <input id="City"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="City"                                
                                           value=""                                
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
                                           value=""                                
                                           placeholder="Address2"
                                           >
                                </div>

                                <!--get Country via autocomplete set Country Code automatically -->
                                <div class="col-sm-5">
                                    <div class="form-group has-feedback">
                                        <input id="country"                                
                                               type="text"                                
                                               class="form-control"                                
                                               name="Country"                                
                                               value=""                                
                                               placeholder="Country"
                                               >
                                        <i class="glyphicon glyphicon-search form-control-feedback"></i>
                                    </div>
                                </div>
                            </div> <!--row-->

                            <!--fourth row-->

                            <div class="row">
                                <div class="col-sm-6">
                                    <input id="Address3"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="Address3"                                
                                           value=""                                
                                           placeholder="Address3"
                                           >
                                </div>
                                <div class="col-sm-2">   
                                    <input id="countryCode"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="Country_Code"                                
                                           value=""                               
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
                                           value=""                                
                                           placeholder="Address4"
                                           >
                                </div>
                                <div class="col-sm-3">
                                    <input id="Telephone"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="Telephone"                                
                                           value=""                                
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
                                           value=""                                
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
                                           value=""                                
                                           placeholder="Main Email"
                                           >
                                </div>
                                <div class="col-sm-4">
                                    <input id="WWW"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="WWW"                                
                                           value=""                                
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
                                                       value="ticked"     

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
                                                       value="ticked"

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
                                           value=""                                
                                           placeholder="Founded"
                                           >
                                </div>
                                <div class="col-sm-3">    
                                    <input id="NumberOfTitles"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="NumberOfTitles"                                
                                           value=""                                
                                           placeholder="Number of Titles"
                                           >      
                                </div>
                                <div class="col-sm-3">    
                                    <input id="DateModified"                                
                                           type="text"                                
                                           class="form-control"                                
                                           name="DateModified"                                
                                           value=""                                
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
                            </textarea>
                        </div> <!--container-->

                        <div style="margin-top:10px" class="form-group">
                            <!-- Button -->
                            <div class="col-sm-12 controls">
                                <input type="submit" class="btn btn-success btn-send" value="Save Details">
                            </div> <!-- col-md-12 control -->
                        </div> <!-- form-group -->
                    </form>  <!--newPublisherForm-->
                </div> <!--container-fluid-->

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
