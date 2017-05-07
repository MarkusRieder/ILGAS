<%-- 
    Document   : calendarTest
    Created on : 21-Mar-2017, 14:26:23
    Author     : markus
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Testing</title>
        <meta charset="utf-8">

        <!--  jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

        <script src="js/bootstrap-datepicker.js"></script>

        <link href="css/bootstrap.min.css" rel="stylesheet"/>

        <link href="css/datepicker.css" rel="stylesheet"/>

        <link href="css/bootstrap-iso.css" rel="stylesheet"/>

        <script>
            $(document).ready(function () {
                var date_input = $('input[name="date"]'); //our date input has the name "date"
                var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                var options = {
                    format: 'dd/mm/yyyy',
                    container: container,
                    todayHighlight: true,
                    autoclose: true
                };
                date_input.datepicker(options);
            });
        </script>




    </head>


    <body>


        <button type="button" class="btn btn-xs btn-danger">
            <span class="glyphicon glyphicon-trash"></span>&nbsp;
        </button>

        <div class="well" style="margin-bottom: 60px">
            <button type="button" class="btn btn-default btn-default">Upload
                <span class="glyphicon glyphicon-upload"></span>
            </button>

        </div>
        <%
            String s = request.getParameter("ExpertReader");
            if (s != null) {
                out.println("Selected Color is : " + s);
                System.out.println("You have selected: " + s);
            } else {
                System.out.println("You have selected: " + s);
            }
        %>
        <div class="container-fluid" style="margin-bottom: 60px">
            <div class="col-xs-6 col-md-4" style="background-color: #419641">
                yuioyiyoiyoiyoyoy<br/>
                hjgjkgjhgkjghjkg
            </div>
        </div>

        <!-- Stack the columns on mobile by making one full-width and the other half-width -->
        <div class="row">
            <div class="col-xs-12 col-md-8">.col-xs-12 .col-md-8</div>
            <div class="col-xs-6 col-md-4">.col-xs-6 .col-md-4</div>
        </div>

        <!-- Columns start at 50% wide on mobile and bump up to 33.3% wide on desktop -->
        <div class="row">
            <div class="col-xs-6 col-md-4"></div>
            <div class="col-xs-6 col-md-4" style="background-color: #419641">
                yuioyiyoiyoiyoyoy<br/>
                hjgjkgjhgkjghjkg
            </div>
            <div class="col-xs-6 col-md-4"></div>
        </div>

        <!-- Columns are always 50% wide, on mobile and desktop -->
        <div class="row">
            <div class="col-xs-6">.col-xs-6</div>
            <div class="col-xs-6">.col-xs-6</div>
        </div>

        <div class="container-fluid" style="border: #000000; border-style: solid; border-width: thick">
            <div class="col-md-4" style="box-shadow: 0px 2px 25px rgba(0, 0, 0, .25);">
                <div class="mainbox" style="background-color: #419641">
                    {!! HTML::image('images/sampleImage.png') !!}
                </div>
            </div>
        </div>
    </body>
</html>