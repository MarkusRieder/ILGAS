<%-- 
    Document   : tabTesting
    Created on : 19-Mar-2017, 11:27:58
    Author     : markus
--%>
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
        <!--        <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">   
                <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">-->
        <!--<link rel="stylesheet" type="text/css" href="css/form.css">-->
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <!--        <script src="js/blockui.js"></script>
                <script src="js/my-block-ui.js"></script>
                <script src="js/bootstrap-select.min.js"></script>
                <script src="js/register.js"></script>
                <script src="js/validator.js"></script>-->
        <!--<script src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>-->



        <!-- Load mobile menu -->
        <script type="text/javascript" src="js/jquery.mobile-menu.js"></script>

        <script type="text/javascript">
            $(function () {
                $("body").mobile_menu({
                    menu: "#phonenav"
                });
            });
        </script>

        <!--        
                <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
                <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
                <link rel="stylesheet" type="text/css" href="css/layout.css">
                <link rel="stylesheet" type="text/css" href="css/home.css" >
                <link rel="stylesheet" type="text/css" href="css/form.css">
                <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
                <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">   
        
                <link type="text/css" rel="stylesheet" href="css/responsive-tabs.css" />
                <link type="text/css" rel="stylesheet" href="css/style.css" />
        
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
                <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>-->

        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.16.0/jquery.validate.js"></script>-->

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

        <script type="text/javascript">
            $(function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    var tab = $(e.target.attributes.href.nodeValue);
                    $(tab).load(tab.data('url'));
                });

                $('.nav-tabs a:first').each(function () {
                    $(this.attributes.href.nodeValue).load($(this.attributes.href.nodeValue).data('url'));
                });
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
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
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
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li class="active"><a href="#info" data-toggle="tab">Info</a></li>
                                <li><a href="#red" data-toggle="tab">Contact details</a></li>
                                <li><a href="#orange" data-toggle="tab">Contracts</a></li>
                                <li><a href="#yellow" data-toggle="tab">Publication Details</a></li>
                                <li><a href="#green" data-toggle="tab">Translator’s Details</a></li>
                                <li><a href="#blue" data-toggle="tab">Original Work & Sample Translation</a></li>

                            </ul>



                        </div><!-- /.navbar-collapse -->
                        <div id="my-tab-content" class="tab-content">
                            <!-- Info -->
                            <div class="tab-pane active" id="info">
                                <h1 align="center" style="margin-bottom: 40px; margin-top: 60px"> <span class="glyphicon glyphicon-exclamation-sign icon-exclamation"></span> 
                                    Information - Please read!
                                    <span class="glyphicon glyphicon-exclamation-sign  icon-exclamation"></span> 
                                </h1>
                                <p>

                                <h2>Translation Grant Programme Application Checklist</h2>

<div id="divUser">
    Welcome ${username} ${name}
    
 
</div>

<% 
String name=(String)session.getAttribute("username"); 
out.print("Hello User: You have entered the name: "+name); 
%> 
                                <ul class="dashed">
                                    <li>Your application to the Literature Ireland Translation Grant Programme should include the following:</li>
                                </ul>
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
                                    <li>         The proposed print run<br/></li>
                                    <li>      The planned page extent of the published translation </li>
                                </ul>



                                <h3> Translator’s Details</h3>
                                <ul class="dashed">
                                    <li>A copy of the translator’s CV, including a list of previous published literary translations</li>
                                    <li>     Details of the fee to be paid to the translator (this should include the total sum in Euro and a breakdown of the rate according to which this sum has been calculated)</li>
                                </ul>





                                <h3> Original Work & Sample Translation</h3>
                                <ul class="dashed">
                                    <li>Two copies of the original work* </li>
                                    <li>   Two copies of a translation sample** consisting of 10–12 pages of prose or six poems</li>
                                </ul>

                                <br/>
                                <p> <i>* Please contact Literature Ireland if two copies of the original work cannot be obtained.<br/>
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
                            <div class="tab-pane" id="red">
                                <h1>Contact details</h1>

                                <form id="Contactdetails" class="form-horizontal" action="${pageContext.request.contextPath}/login.do" method="POST"  role="form" >
                                    <div class="col-md-9">
                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="name">                                        
                                        </div>

                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="address">                                        
                                        </div>
                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="address1">                                        
                                        </div>
                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="addres2">                                        
                                        </div>
                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="City/Town">                                        
                                        </div>
                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="Post Code">                                        
                                        </div>

                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="email">                                        
                                        </div>

                                        <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
                                            <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="phone number ">                                        
                                        </div>

                                        <div class="form-footer">
                                            <button type="submit" class="btn btn-info">
                                                <span class="glyphicon glyphicon-log-in"></span> Sign Me Up !
                                            </button>
                                        </div>      
                                    </div>
                                </form>
                                <p>The name, address, email and phone number of the applicant</p>
                            </div>
                            <!-- Contracts -->
                            <div class="tab-pane" id="orange">
                                <h1>Contracts</h1>

                                <span class="glyphicon glyphicon-file"></span>
                                <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                    Select File to Upload:<input type="file" name="fileName">
                                    <br>
                                    <input type="submit" value="Upload">
                                </form>
                                <br/>

                                <span class="glyphicon glyphicon-file"></span>
                                <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                    Select File to Upload:<input type="file" name="fileName">
                                    <br>
                                    <input type="submit" value="Upload">
                                </form>

                                <p>A copy of the agreement with the translation rights holder (where applicable)
                                    A copy of the contract with the translator</p>
                            </div>
                            <!-- Publication Details -->
                            <div class="tab-pane" id="yellow">
                                <h1>Publication Details</h1>
                                <p>The proposed date of publication
                                    The proposed print run
                                    The planned page extent of the published translation</p>
                            </div>
                            <!-- Translator’s Details -->
                            <div class="tab-pane" id="green">
                                <h1>Translator’s Details</h1>
                                <p>A copy of the translator’s CV, including a list of previous published literary translations
                                    Details of the fee to be paid to the translator (this should include the total sum in Euro and a breakdown of the rate according to which this sum has been calculated)</p>
                            </div>
                            <!-- Original Work & Sample Translation -->
                            <div class="tab-pane" id="blue">
                                <h1>Original Work & Sample Translation</h1>
                                <p>wo copies of the original work* 
                                    Two copies of a translation sample** consisting of 10–12 pages of prose or six poems</p>
                            </div>
                        </div>
                    </div><!-- /.container-fluid -->
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
        </div><!-- end of Shadow container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>

    </body>
</html>