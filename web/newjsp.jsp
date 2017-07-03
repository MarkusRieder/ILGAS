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
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">

        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">

        <link href="css/bootstrap-imgupload.css" rel="stylesheet">


        <script src="http://code.jquery.com/jquery-1.12.2.min.js"></script>

        <!--<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>-->


        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script> -->
        <script src="js/moment.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>-->
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery-ui.js"></script>


        <script>

            $(function () {
                $('div.cover').on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                    document.getElementById("cover_upload").value = label;
                    console.log("label  ", label);
                    console.log("numFiles  ", numFiles);
                });
            });
        </script>

        <style>

            .container-bg { 
                background: url(images/background/IMG_6318.JPG) no-repeat center center fixed; 
                -webkit-background-size: cover;
                -moz-background-size:  cover;
                -o-background-size: cover;
                background-size: 100% ;
                padding-right: 15px;
                padding-left: 15px;
                margin-right: auto;
                margin-left: auto;
                max-width: 1000px;
                overflow:hidden;

            }

            .tst {
                background-image: url('images/background/IMG_6318.JPG');
                background-size: contain;
                background-repeat: no-repeat;
                width: 100%;
                height: 0;
                padding-top: 51.4056%; /* (img-height / img-width * container-width) */
                /* (853 / 1280 * 100) */
            }

            div.row { 
                border: 1px solid;
                border-bottom: 0px;
            }
            .container div.row:last-child {
                border-bottom: 1px solid;
            }
        </style>
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

            .imageupload {
                margin: 20px 0;
            }
        </style>

    </head>
    <body>
        <div id="shadowholder">
            <div class="shadowtop"> </div>
            <div id="container">
                <div id="topspacer"> </div>
                <div id="topbar">
                    <div class="animateddiv">
                        <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" height="70" alt="Promoting Irish Literature Abroad" /></a>
                    </div>
                    <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>

                    <!--container for welcome/logout-->
                    <div class="container-fluid" >
                        <div class="pull-right">
                            <h6> <small>Welcome <strong>${name}</strong> - <strong>not ${name}</strong>? <a href="${pageContext.request.contextPath}/Logout">Click here to log out </a></small></h6>
                        </div>
                    </div> <!--container for welcome/logout-->
                </div> <!--  End of topbar div -->
                <div class="jquery-script-clear"></div>

                <div class="container">

                    <!-- bootstrap-imageupload. -->
                    <div class="imageupload panel panel-default">
                        <div class="panel-heading clearfix">
                        </div>
                        <div class="file-tab panel-body cover">
                            <label class="btn btn-default btn-file">
                                <span></span>
                                <!-- The file is stored here. -->
                                <input type="file" name="image-file">
                                <i class="glyphicon glyphicon-picture"></i>
                            </label>
                            <button type="button" class="btn btn-default">Remove</button>
                        </div>


                        <!--<input id="label_agreement" class="pull-left"/>-->
                        <br/>
                        <br/>
                        <input type="hidden" value="Cover" name="image-file" id="cover_upload"/>
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

            </div> <!--  end of container div -->
            <div class="shadowbase"> </div>
        </div><!-- end of Shadowholder container div -->


        <div id="credit"> <a><img src="images/paw.gif" alt="The Cat" height="30" /></a>
            &copy; 2017 mgr Software
        </div>
        <script src="js/bootstrap-imageupload.js"></script>

        <script>
            var $imageupload = $('.imageupload');
            $imageupload.imageupload();

            $('#imageupload-disable').on('click', function () {
                $imageupload.imageupload('disable');
                $(this).blur();
            })

            $('#imageupload-enable').on('click', function () {
                $imageupload.imageupload('enable');
                $(this).blur();
            })

            $('#imageupload-reset').on('click', function () {
                $imageupload.imageupload('reset');
                $(this).blur();
            });
        </script>
    </body>
</html>
