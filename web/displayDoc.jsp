<%-- 
    Document   : displayDoc
    Created on : 17-May-2017, 23:21:37
    Author     : markus
--%>

<%@ page import="java.io.*,java.io.*,org.apache.poi.hwpf.HWPFDocument,org.apache.poi.hwpf.extractor.WordExtractor" %>



<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="/fancybox/jquery.fancybox-1.3.4.pack.js"></script>

        <script>
            $(document).ready(function () {
                $(".word").fancybox({
                    'width': 600, // or whatever
                    'height': 320,
                    'type': 'iframe'
                });
            }); //  ready 

        </script>
    </head>

    <body style="height: 100%">

        <%
            File file = null;
            WordExtractor extractor = null;
            String res = null;

            try {

                file = new File("/home/markus/test/2017/Discworld Publishers/15/TranslationSample/TranslationSample.doc");
                FileInputStream fis = new FileInputStream(file.getAbsolutePath());
                HWPFDocument document = new HWPFDocument(fis);
                extractor = new WordExtractor(document);
                String[] fileData = extractor.getParagraphText();
                for (int i = 0; i < fileData.length; i++) {
                    if (fileData[i] != null) {
                        res += fileData[i];
                    }

                }
        %>
        <form>

            <textarea >
                <%out.println(res);%>
            </textarea>
            <input type="submit" value="submit"/>
        </form>
        <%

            } catch (Exception exep) {

                out.println(exep.getMessage());
            }
        %>

        
        <a class="word" href="http://docs.google.com/gview?url=file://///goofy4/home/markus/test/2017/Discworld Publishers/15/TranslationSample/TranslationSample.doc&embedded=true">open a word document in fancybox</a>
        

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
