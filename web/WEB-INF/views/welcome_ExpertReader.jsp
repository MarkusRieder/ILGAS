<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true"%>
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

            .panel-body {
                margin-top: 5px;
                box-shadow: 0 0 10px black;
                padding:0 15px 0 15px;
                background: #d9d1d1;
            }
        </style>

    </head>

    <body style="height: 100%">
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

                </div> <!--  End of topbar div -->


                <!--<h1 align="center">Expert Reader Submit Page</h1>-->

                <!--container for welcome/logout-->
                <div class="container-fluid" style="margin-bottom: 20px; width: 100%">
                    <div class="pull-right">
                        <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                    </div>
                </div> <!--container for welcome/logout-->

                <h1 align="center"  style="margin-top: 20px; margin-bottom: 10px" >Expert Reader Submit Page</h1>

                <div class="container-fluid" style="margin-bottom: 20px; width: 100%">

                    <div class="panel panel-default">

                        <div class="panel-body">

                            <div class="row" style="margin-left: 10px">

                                <!--<form method="POST" action="upload">-->
                                <div class="row" style="margin-top: 40px">
                                    <div class="col-md-8">
                                        <input type="text" value="Reference Number" name="referenceNumber" />
                                    </div>
                                    <div class="col-md-3">        
                                        Submission Date:
                                        <input type="text" class="form-control" id="date" value="" disabled> </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">            
                                        <form method="POST" action="upload" enctype="multipart/form-data" >
                                            <h1>Upload your report</h1>
                                            <!--<br/>-->
                                            <input type="file" name="file" id="report" /> <br/>
<!--                                            Destination:
                                            <input type="text" value="/home/markus/test/report" name="destination"/>
                                            <br/>-->
                                            <input type="submit" value="Upload" name="upload_agreement" id="upload_report" style="margin-top: 10px"/>
                                        </form> 
                                    </div>

                                    <div class="col-md-4">            
                                        <form method="POST" action="upload" enctype="multipart/form-data" >
<!--                                            <h3 style="background-color: red">to todo</h3>-->
                                            <h1>Upload your invoice</h1>
                                            <!--<br/>-->
                                            <input type="file" name="file" id="invoice" /> <br/>
<!--                                            Destination:
                                            <input type="text" value="/home/markus/test/invoice" name="destination"/>
                                            <br/>-->
                                            <input type="submit" value="Upload" name="upload_invoice" id="upload_invoice" style="margin-top: 10px"/>
                                        </form> 
                                    </div>
                                </div>

                                <div class="row">  
                                    <div class="col-md-12" style="margin-top: 50px;">
                                        <div class="form-group">
                                            <textarea class="form-control" placeholder="Summary of report" 
                                                      style="width: 580px; height: 430px;"></textarea>
                                        </div>
                                    </div>

                                    <div class="col-md-6"></div>
                                </div>
                                <button type="submit" class="btn btn-default"  style="margin-top: 50px; margin-left: 10px; margin-bottom: 30px">
                                    <i class="icon-user icon-white"></i> Submit 
                                </button>
                                <!--</form>--> 
                                <script>
                                    n = new Date();
                                    y = n.getFullYear();
                                    m = n.getMonth() + 1;
                                    d = n.getDate();
                                    $("#date").attr("value", d + "/" + m + "/" + y);
                                </script>
                            </div><!--row-->
                        </div> <!--panel-body-->      
                    </div>  <!--panel--> 
                </div><!--container-fluid-->



                <!--Script to call Logout.java-->
                <script type="text/javascript">
                    $('a#logout').click(function () {
                        $.post('/Logout');
                        window.location.href = "../login.jsp";
                    });
                </script>

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