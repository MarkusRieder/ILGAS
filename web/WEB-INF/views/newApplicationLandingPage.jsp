<%-- 
    Document   : newApplicationLandingPage
    Created on : 06-Feb-2018, 07:36:25
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

        <title>Translation Grant Application System</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <!--<link rel="stylesheet" type="text/css" href="css/font-awesome.css">-->

        <script src="js/jquery-1.11.3.min.js"></script>


        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>-->
        <script src="js/moment.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
        <script src="js/bootstrap-datepicker.js"></script>

        <!--<script src="js/bootstrap-select.min.js"></script>-->

        <script>

            function showtcACCEPTED(a)
            {
                if (a === true)
                {
                    var s1 = document.getElementById("nxtBtn");
                    s1.style.visibility = "visible";
                } else
                {
                    var s1 = document.getElementById("nxtBtn");
                    s1.style.visibility = "hidden";
                }
            }
        </script>

        <style>
            .header1 {
                display: block;
                font-size: 2em;
                margin-top: 0.67em;
                margin-bottom: 0.67em;
                margin-left: 0;
                margin-right: 0;
                font-weight: bold;
                text-align: center;
            }
            div.background {
                background: url(images/background/IMG_6318.JPG) no-repeat center center fixed; 
                border: 2px solid black;
            }

            div.transbox {
                margin: 30px;
                background-color: #ffffff;
                border: 1px solid black;
                opacity: 0.7;
                filter: alpha(opacity=60); /* For IE8 and earlier */
            }

            div.transbox p {
                margin: 5%;
                font-weight: bold;
                color: #000000;
            }

            /* <!--Checkboxes with tick mark--> */

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

                <div class="container-fluid" style="margin-top: 10px; margin-bottom: 60px">

                    <p class="header1" style="margin-bottom: 10px">
                        Eligibility & Terms and Conditions
                    </p>


                    <form id="tcForm" 
                          class="form-horizontal" 
                          action="${pageContext.request.contextPath}/Application" 
                          method="POST"  
                          role="form" 
                          >
                        <input type="hidden" name="task" value="NewApplicationTCconfirmed"> 
                        <div class="background">
                            <div class="transbox">
                                <!--<div class="form-group">-->
                                <!--in Panel-->
                                <div class = "panel panel-default">
                                    <div class = "panel-body">
                                        <p>Am I eligible? - Check  
                                            <a data-target="#eligibilityModal" data-toggle="modal" class="MainNavText" id="MainNavHelp" 
                                               href="#eligibilityModal">HERE</a>
                                        </p>

                                        <p style="margin-bottom: 1px">
                                            Terms and Conditions
                                        </p>

                                        <div class="checkbox">                                                             
                                            <label style="margin-bottom: 10px; margin-left: 20px" for="tcACCEPTED">
                                                By clicking on the "<i>I accept</i>" 
                                                button, you are confirming that you have 
                                                <strong>read</strong> and <strong>accepted</strong> 
                                                <br/>the terms and conditions of use of this website 
                                                (including disclaimer).</label>
                                            <br/>
                                            <label style="font-size: 2.0em; margin-left: 20px " class="checkbox-inline  no_indent">
                                                <input type="checkbox" 
                                                       name="tcACCEPTED" 
                                                       id="tcACCEPTED" 
                                                       value="" 
                                                       onclick="showtcACCEPTED(this.checked);"
                                                       class="form-control">
                                                <span class="cr"><i class="cr-icon glyphicon glyphicon-ok"></i></span>
                                            </label>                                                          
                                        </div>

                                        <div style="margin-left: 40px " >   
                                             <a data-target="#tcModal" data-toggle="modal" href="#tcModal">read Terms and Conditions</a>                                            
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-4">
                                            </div>
                                            <div class="col-xs-4">
                                            </div>
                                            <div class="col-xs-2 pull-left" style="margin-top:3px;">
                                                <button type="submit"  name="task" class="btn btn-success" id="nxtBtn" style="visibility:hidden" >                           
                                                    <span class="glyphicon glyphicon-thumbs-up"></span> Continue...
                                                </button>
                                            </div>
                                        </div> <!-- form-group-->    
                                    </div>  <!-- panel-body-->     
                                </div>  <!-- panel --> 
                            </div>
                        </div>
                    </form>
                </div> 

                <div class="modal fade" id="eligibilityModal" tabindex="-1" role="dialog" aria-labelledby="eligibilityModalLabel">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #c3bcbc">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="eligibilityModalLabel">Application Eligibility Requirements and Criteria</h4>
                            </div>


                            <div class="modal-body" style="background-color: #d9d1d1">

                                <div class="row" style="margin-bottom: 10px">



                                    <p  align="center"  style="margin-bottom: 0cm; line-height: 0.64cm"><a name="__DdeLink__127_852613866"></a>
                                        <font color="#000000"><font size="5" style="font-size: 21pt;"><span style="letter-spacing: 0.3pt">Application
                                            Eligibility  <br/> Requirements and Criteria</span></font></font></p>
                                    <p style="margin-bottom: 0.35cm; line-height: 115%"><br/>
                                        <br/>

                                    </p>
                                    <ol>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">The translation grant programme is designed to
                                                support the translation of works of Irish literature</span><span lang="en-IE"><b>.
                                                    The maximum grant that may be applied for is the total fee being
                                                    paid to the translator(s).</b></span><span lang="en-IE"> The
                                                translation grants are considered a contribution towards the cost of
                                                the translation and may not cover the full cost incurred by the
                                                publisher. Other costs such as production, printing, publicity,
                                                etc., are not covered. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="2">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>The board of Literature Ireland meets three
                                                    times a year to consider translation grant applications.</b></span><span lang="en-IE">
                                                The meeting will typically take place six to eight weeks </span><span lang="en-IE"><u>after</u></span><span lang="en-IE">
                                                the application deadline.  </span><span lang="en-IE"><b>Deadlines
                                                </b></span><span lang="en-IE">are advertised on Literature Ireland’s
                                                website at
                                                <a href="http://www.literatureireland.com/programmes/translation-grant-programme/">http://www.literatureireland.com/programmes/translation-grant-programme/</a>.
                                            </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="3">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">The online </span><span lang="en-IE"><b>application
                                                    system opens one month prior to the deadline</b></span><span lang="en-IE">.
                                                Once an application has been commenced, the applicant will receive a
                                                reference number which, together with a temporary password, will be
                                                emailed to the address provided. Applicants may save their
                                                application at any stage and return to complete and submit it later.
                                                Please note that incomplete applications cannot be submitted by the
                                                system – please see point 5 below to make sure you have all the
                                                information and documentation required in order to apply. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="4">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">A </span><span lang="en-IE"><b>grace period of
                                                    one week</b></span><span lang="en-IE"> is given after the deadline
                                                to allow for unforeseen delays. After this period, the application
                                                system will be closed. Extraordinary appeals for inclusion after
                                                this period may be made to <a href="mailto:info@literatureireland.com">info@literatureireland.com</a>
                                                and will be considered at the discretion of the director and/or
                                                deputy director. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="5">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">The following will be required during the
                                                application process:</span></p>
                                    </ol>
                                    <ol type="i">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Source Text:</b></span><span lang="en-IE">
                                                Author, title and publication details for the original work; a copy
                                                of the original work (e.g. a PDF). One print copy of the original
                                                work should also be sent, with the application reference number, by
                                                post to Literature Ireland, Trinity Centre for Literary Translation,
                                                36 Fenian Street, Trinity College Dublin, Dublin D02 FK54, Ireland. 
                                            </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Target Text:</b></span><span lang="en-IE">
                                                Translator, publisher and publication details for the translation; a
                                                translation sample in WORD/RTF format (</span><span lang="en-IE"><u>not</u></span><span lang="en-IE">
                                                PDF) consisting of 10–12 pages of prose or six poems. </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Rights Details:</b></span><span lang="en-IE">
                                                Name and contact details for the translation rights holder and a
                                                signed copy of the rights agreement, where applicable. </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Translator Details:</b></span><span lang="en-IE">
                                                Name and curriculum vitae of the translator; details of the fee to
                                                be paid to the translator (in Euro), including how this fee was
                                                calculated (i.e. the rate per word/page/etc.); a signed copy of the
                                                agreement between the translator and the publisher.</span></p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Publisher Details:</b></span><span lang="en-IE">
                                                Name and contact details for the applicant and the publishing house,
                                                details of any previous awards from Literature Ireland/Ireland
                                                Literature Exchange, sales information for previously awarded
                                                titles, and the distribution and promotion plan for the work for
                                                which funding is currently being sought. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="6">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Basic eligibility requirements:</b></span></p>
                                    </ol>
                                    <ol type="i">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">The author of the work of literature for which
                                                funding is sought </span><span lang="en-IE"><b>must be Irish
                                                </b></span><span lang="en-IE">(meaning from the Republic of Ireland
                                                or Northern Ireland) or have lived and worked in Ireland for a
                                                considerable length of time. </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">The genres for which funding is available are:</span></p>
                                    </ol>
                                    <p lang="en-US" style="margin-left: 3.81cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <span lang="en-IE"><b>Literary Fiction</b></span></p>
                                    <p lang="en-US" style="margin-left: 3.81cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <span lang="en-IE"><b>Poetry</b></span></p>
                                    <p lang="en-US" style="margin-left: 3.81cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <span lang="en-IE"><b>Drama</b></span><span lang="en-IE"> (for
                                            publication)</span></p>
                                    <p lang="en-US" style="margin-left: 3.81cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <span lang="en-IE"><b>Children’s literature </b></span>
                                    </p>
                                    <p lang="en-US" style="margin-left: 3.81cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <span lang="en-IE"><b>Certain works of non-fiction</b></span><span lang="en-IE">
                                            that relate to Irish writers/literature (e.g. acclaimed biographies,
                                            critical works aimed at a general readership).</span></p>
                                    <ol type="i" start="3">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Applications for translations to be
                                                self-published or published only as e-books or audio books will </span><span lang="en-IE"><u><b>not</b></u></span><span lang="en-IE">
                                                be accepted.</span></p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Applications will only be accepted from a member
                                                of staff at the publishing house planning to publish the
                                                translation. The publishing house must be a registered company of
                                                established reputation. </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Translations which have </span><span lang="en-IE"><b>already
                                                    been published or which are due to go to print</b></span><span lang="en-IE">
                                                or be published before the meeting of the board of Literature
                                                Ireland will be deemed </span><span lang="en-IE"><u><b>ineligible</b></u></span><span lang="en-IE">.
                                            </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">A translation which may be considered an
                                            </span><span lang="en-IE"><b>adaptation or abridgement</b></span><span lang="en-IE">
                                                may </span><span lang="en-IE"><u><b>not</b></u></span><span lang="en-IE">
                                                be considered eligible – in such cases, the applicant is requested
                                                to contact <a href="mailto:info@literatureireland.com">info@literatureireland.com</a>
                                                for clarification in advance of applying. </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Applications for the publication of a
                                                    translation for which appropriate translation rights have not been
                                                    secured </b></span><span lang="en-IE"><u><b>will not</b></u></span><span lang="en-IE"><b>
                                                    be accepted</b></span><span lang="en-IE">. </span>
                                        </p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Publishers may submit a </span><span lang="en-IE"><u>maximum
                                                    of two applications per round</u></span><span lang="en-IE">. A given
                                                publishing house may receive a </span><span lang="en-IE"><u>maximum
                                                    of three translation grants per annum</u></span><span lang="en-IE">.
                                                A given publishing house may receive a maximum of five grants
                                                overall for works by the same author in the same genre. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 2.54cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="7">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">The translation sample submitted with the
                                                application will be sent by Literature Ireland to an independent
                                                expert reader for assessment. The reader will submit a report on the
                                                quality of the translation which will be made available to the board
                                                of directors in its consideration of the application. </span><span lang="en-IE"><b>It
                                                    is therefore recommended that the sample be from a final or near
                                                    final version of the translation which has been proofread and/or
                                                    edited. </b></span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 2.54cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="8">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Applicants will receive an email within 10
                                                    working days of the meeting to inform them of the outcome of their
                                                    application.</b></span><span lang="en-IE"> Successful applicants
                                                will also receive a formal grant agreement. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-bottom: 0.35cm; line-height: 115%"><a name="_GoBack"></a>
                                        <font color="#00b050"><font size="3" style="font-size: 12pt"><b>If
                                            you are applying for the first time or if you have any questions or
                                            concerns about your application, you are encouraged to contact a
                                            member of Literature Ireland staff. </b></font></font>
                                    </p>
                                    <p style="margin-bottom: 0.35cm; line-height: 115%">Contact email
                                        addresses are available on the website at:
                                        <a href="http://www.literatureireland.com/contact-us/">http://www.literatureireland.com/contact-us/</a>.
                                    </p>
                                </div>


                            </div><!--modal body--> 

                            <div class="modal-footer"  style="background-color: #c3bcbc">                           
                                <button type="button" class="btn btn-default" data-dismiss="modal">Done</button>
                            </div> <!--modal footer -->
                        </div> <!--modal content-->          
                    </div> <!--modal dialog-->
                </div> <!-- eligibilityModal -->

                <div class="modal fade" id="tcModal" tabindex="-1" role="dialog" aria-labelledby="tcModalLabel">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #c3bcbc">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="tcModalLabel">Terms and Conditions</h4>
                            </div>


                            <div class="modal-body" style="background-color: #d9d1d1">

                                <div class="row" style="margin-bottom: 10px">


                                    <p align="center" style="margin-bottom: 0.35cm;  line-height: 115%"><font size="5" style="font-size: 21pt">Terms
                                        and Conditions</font></p>
                                    <ol>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">It is the </span><span lang="en-IE"><u><b>responsibility
                                                        of the applicant</b></u></span><span lang="en-IE"> to ensure that
                                                all data, documentation and legal agreements submitted with the
                                                application are </span><span lang="en-IE"><b>correct and accurate</b></span><span lang="en-IE">.
                                                Where certain documentation, e.g. the agreement between the
                                                publisher and the translator, is in a language other than English or
                                                Irish, an English or Irish translation should also be made
                                                available. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="2">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Literature Ireland keeps records of standard
                                                    pay rate ranges for literary translators in various territories
                                                    around the world.</b></span><span lang="en-IE"> Where the fee stated
                                                in an application deviates significantly from the standard range
                                                paid to translators in a given country, Literature Ireland reserves
                                                the right to query the reason for this and to instruct its board of
                                                directors accordingly. Where a fee appears to be inflated or is
                                                greater than expected and sufficient justification for this has not
                                                been forthcoming, an award may be made but will be in line with the
                                                standard rates kept on file. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="3">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Applications are judged on a competitive basis
                                                    and all funding decisions are made by the board of Literature
                                                    Ireland.</b></span><span lang="en-IE"> The following are the
                                                possible decisions:</span></p>
                                    </ol>
                                    <ol type="i">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Refusal of funding</b></span><span lang="en-IE">
                                                (there are a number of possible reasons for this, including the
                                                findings of the reader’s report, nature of the original work,
                                                budgetary restrictions).</span></p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Request for a resubmission</b></span><span lang="en-IE">
                                                (this request is made when the expert reader finds that the
                                                translation overall is acceptable but that there are certain
                                                unacceptable errors or issues and the board may wish for the
                                                applicant to revise the translation and submit a new sample for
                                                assessment before making an award).</span></p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Award of funding with report copied</b></span><span lang="en-IE">
                                                (a copy of the expert reader’s report may be copied to the
                                                applicant in cases where some of its notes or suggestions may be of
                                                use to the translator or editor).</span></p>
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Award of funding</b></span><span lang="en-IE">.</span></p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        Where an applicant disputes the outcome of their application, notably
                                        in relation to the findings of the expert reader’s report, an
                                        appeals process may be pursued. This may be initiated by email to
                                        <a href="mailto:info@literatureireland.com">info@literatureireland.com</a>.
                                    </p>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="4">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>The grant agreement is valid for a period of
                                                    12 months. </b></span><span lang="en-IE">Should drawdown of the
                                                grant not be requested within this period, the agreement will be
                                                voided.  </span><span lang="en-IE"><b>Successful applicants will
                                                    need to upload a signed copy of the agreement to this system. </b></span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="5">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Successful applicants are required to print a
                                                copy of </span><span lang="en-IE"><b>the Literature Ireland logo and
                                                    the text ‘This book was published with the support of Literature
                                                    Ireland’</b></span><span lang="en-IE"> (translated into the target
                                                language) on the colophon/copyright page of the published
                                                translation. A proof copy of this page must be emailed to a
                                                Literature Ireland staff member for approval </span><span lang="en-IE"><u><b>before</b></u></span><span lang="en-IE">
                                                it goes to print. Where this requirement is not met, the
                                                organisation retains the right to issue a penalty of 10% of the
                                                value of the grant. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="6">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Successful applicants are required to post </span><span lang="en-IE"><b>eight
                                                    copies</b></span><span lang="en-IE"> of the published work (gratis)
                                                to Literature Ireland, Trinity Centre for Literary Translation, 36
                                                Fenian Street, Trinity College Dublin, Dublin D02 FK54, Ireland.
                                                [</span><span lang="en-IE"><b>French publishers</b></span><span lang="en-IE">
                                                are requested to send seven copies of the work to this address and
                                                one copy to: Libraries and Archives Officer, Centre Culturel
                                                Irlandais, 5, rue des Irlandais, 75005 Paris, France.] </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="7">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Successful applicants are requested to upload </span><span lang="en-IE"><b>a
                                                    copy of the book jacket</b></span><span lang="en-IE"> to the system,
                                                as well as some other information (e.g. ISBN number, title in the
                                                target language), after publication. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="8">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE"><b>Proof of payment to the translator</b></span><span lang="en-IE">
                                                will also be sought before a grant is paid. This must state the full
                                                amount, in Euro, paid to the translator. This proof of payment
                                                document may take the form of a bank transfer confirmation or a
                                                statement signed and dated by both parties (i.e. the translator and
                                                a representative of the publishing house). It should be uploaded to
                                                the system at the same time the books are posted to Literature
                                                Ireland. Such proof of payment should be provided for every
                                                translator involved in the project. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="9">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Successful applicants will need to provide </span><span lang="en-IE"><b>bank
                                                    account details</b></span><span lang="en-IE"> for each award,
                                                regardless of whether these have been provided previously. It is the
                                                responsibility of the applicant to ensure that the bank details
                                                provided are accurate. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="10">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">Successful applicants are required to provide
                                            </span><span lang="en-IE"><b>sales figures and any press coverage
                                                    for previous titles</b></span><span lang="en-IE"> published with the
                                                support of Literature Ireland/Ireland Literature Exchange. </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <ol start="11">
                                        <li/>
                                        <p lang="en-US" style="margin-bottom: 0.35cm; line-height: 115%">
                                            <span lang="en-IE">In the case of successful applications, once all
                                                necessary documentation and information has been received and
                                                approved by Literature Ireland, </span><span lang="en-IE"><b>the
                                                    translation grant is payable within three months</b></span><span lang="en-IE">.
                                            </span>
                                        </p>
                                    </ol>
                                    <p style="margin-left: 1.27cm; margin-bottom: 0.35cm; line-height: 115%">
                                        <br/>
                                        <br/>

                                    </p>
                                    <p style="margin-bottom: 0.35cm; line-height: 115%"><font size="4" style="font-size: 14pt"><b>NOTE:</b></font><font size="4" style="font-size: 14pt">
                                        </font><font size="4" style="font-size: 14pt"><b>By choosing to enter
                                            and submit an application, the user acknowledges and agrees to the
                                            terms and conditions described above.  </b></font>
                                    </p>



                                </div><!--modal body--> 

                                <div class="modal-footer"  style="background-color: #c3bcbc">                           
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Done</button>
                                </div> <!--modal footer -->
                            </div> <!--modal content-->          
                        </div> <!--modal dialog-->
                    </div> <!-- tcModal -->

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
