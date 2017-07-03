<%-- 
    Document   : testMultiInputs
    Created on : 11-Jun-2017, 12:04:31
    Author     : markus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>



        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.1.1/css/responsive.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/plug-ins/1.10.15/integration/font-awesome/dataTables.fontAwesome.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">


        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>        
        <script src="js/bootstrap-datepicker.js"></script>
        <!--<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>-->  
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

        <title>Dynamic form processing using jQuery and Java Servlets</title>
        <link rel="stylesheet" href="/resources/themes/master.css" type="text/css" />
        <link
            href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
            rel="stylesheet" type="text/css" />
        <script
            src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js"
        type="text/javascript"></script>
        <script
            src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"
        type="text/javascript"></script>
        <script src="/resources/scripts/mysamplecode.js" type="text/javascript"></script>

        <!--Set whitespace between the generated input fields-->
        <style>

            input.wsp{

                margin-right: 3px;
            }

        </style>
        
        <style>
            
            /**
 * Chunky 3D Web Buttons
 *
 * Inspiration was taken from:
 * - http://www.premiumpixels.com/freebies/chunky-3d-webbuttons-psd/
 */
 
/**
 * Shadow
 */
a.button::before {
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -webkit-box-shadow: #959595 0 2px 5px;
    -moz-box-shadow: #959595 0 2px 5px;
    border-radius: 3px;
    box-shadow: #959595 0 2px 5px;
    content: "";
    display: block;
    height: 100%;
    left: 0;
    padding: 2px 0 0;
    position: absolute;
    top: 0;
    width: 100%; }
    
a.button:active::before { padding: 1px 0 0; }

/**
 * Grey
 */
a.button {
    -moz-box-shadow: inset 0 0 0 1px #63ad0d;
    -webkit-box-shadow: inset 0 0 0 1px #63ad0d;
    -moz-border-radius: 3px;
    -webkit-border-radius: 3px;
    background: #eee;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#eee), to(#e2e2e2));
    background: -moz-linear-gradient(#eee, #e2e2e2);
    background: linear-gradient(#eee, #e2e2e2);
    border: solid 1px #d0d0d0;
    border-bottom: solid 3px #b2b1b1;
    border-radius: 3px;
    box-shadow: inset 0 0 0 1px #f5f5f5;
    color: #555;
    display: inline-block;
    font: bold 12px Arial, Helvetica, Clean, sans-serif;
    margin: 0 25px 25px 0;
    padding: 10px 20px;
    position: relative;
    text-align: center;
    text-decoration: none;
    text-shadow: 0 1px 0 #fafafa; }
    
a.button:hover {
    background: #e4e4e4;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#e4e4e4), to(#ededed));
    background: -moz-linear-gradient(#e4e4e4, #ededed);
    background: linear-gradient(#e4e4e4, #ededed);
    border: solid 1px #c2c2c2;
    border-bottom: solid 3px #b2b1b1;
    box-shadow: inset 0 0 0 1px #efefef; }
    
a.button:active {
    background: #dfdfdf;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#dfdfdf), to(#e3e3e3));
    background: -moz-linear-gradient(#dfdfdf, #e3e3e3);
    background: linear-gradient(#dfdfdf, #e3e3e3);
    border: solid 1px #959595;
    box-shadow: inset 0 10px 15px 0 #c4c4c4;
    top:2px;}

/**
 * Pink
 */
a.button.pink {
    background: #f997b0;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f997b0), to(#f56778));
    background: -moz-linear-gradient(#f997b0, #f56778);
    background: linear-gradient(#f997b0, #f56778);
    border: solid 1px #ee8090;
    border-bottom: solid 3px #cb5462;
    box-shadow: inset 0 0 0 1px #fbc1d0;
    color: #913944;
    text-shadow: 0 1px 0 #f9a0ad; }
    
a.button.pink:hover {
    background: #f57184;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f57184), to(#f78297));
    background: -moz-linear-gradient(#f57184, #f78297);
    background: linear-gradient(#f57184, #f78297);
    border: solid 1px #e26272;
    border-bottom: solid 3px #cb5462;
    box-shadow: inset 0 0 0 1px #f9aab5; }
    
a.button.pink:active {
    background: #f06a7c;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f06a7c), to(#f56c7e));
    background: -moz-linear-gradient(#f06a7c, #f56c7e);
    background: linear-gradient(#f06a7c, #f56c7e);
    border: solid 1px #a14753;
    box-shadow: inset 0 10px 15px 0 #d45d6d; }
    
/**
 * Blue
 */
a.button.blue {
    background: #abe4f8;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#abe4f8), to(#74d0f4));
    background: -moz-linear-gradient(#abe4f8, #74d0f4);
    background: linear-gradient(#abe4f8, #74d0f4);
    border: solid 1px #8cc5d9;
    border-bottom: solid 3px #589cb6;
    box-shadow: inset 0 0 0 1px #cdeffb;
    color: #42788e;
    text-shadow: 0 1px 0 #b6e6f9; }
    
a.button.blue:hover {
    background: #80d4f5;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#80d4f5), to(#92dbf6));
    background: -moz-linear-gradient(#80d4f5, #92dbf6);
    background: linear-gradient(#80d4f5, #92dbf6);
    border: solid 1px #79acbe;
    border-bottom: solid 3px #589cb6;
    box-shadow: inset 0 0 0 1px #b2e6f8; }
    
a.button.blue:active {
    background: #89d2ee;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#89d2ee), to(#84cae6));
    background: -moz-linear-gradient(#89d2ee, #84cae6);
    background: linear-gradient(#89d2ee, #84cae6);
    border: solid 1px #5c8d9f;
    box-shadow: inset 0 10px 15px 0 #79b9d2; }
    
/**
 * Green
 */
a.button.green {
    background: #cae285;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#cae285), to(#a3cd5a));
    background: -moz-linear-gradient(#cae285, #a3cd5a);
    background: linear-gradient(#cae285, #a3cd5a);
    border: solid 1px #aad063;
    border-bottom: solid 3px #799545;
    box-shadow: inset 0 0 0 1px #e0eeb6;
    color: #5d7731;
    text-shadow: 0 1px 0 #d0e5a4; }
    
a.button.green:hover {
    background: #abd164;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#abd164), to(#b9d972));
    background: -moz-linear-gradient(#abd164, #b9d972);
    background: linear-gradient(#abd164, #b9d972);
    border: solid 1px #98b85b;
    border-bottom: solid 3px #799545;
    box-shadow: inset 0 0 0 1px #cce3a1; }
    
a.button.green:active {
    background: #a4cb5d;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#a4cb5d), to(#9ec45a));
    background: -moz-linear-gradient(#a4cb5d, #9ec45a);
    background: linear-gradient(#a4cb5d, #9ec45a);
    border: solid 1px #6e883f;
    box-shadow: inset 0 10px 15px 0 #90b352; }
    
/**
 * Teal
 */
button.teal {
    background: #b7f2f4;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#b7f2f4), to(#81e8eb));
    background: -moz-linear-gradient(#b7f2f4, #81e8eb);
    background: linear-gradient(#b7f2f4, #81e8eb);
    border: solid 1px #87d3d5;
    border-bottom: solid 3px #4fa7aa;
    box-shadow: inset 0 0 0 1px #d4f8f8;
    color: #437b7d;
    text-shadow: 0 1px 0 #bef3f5; }
    
button.teal:hover {
    background: #8deaed;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#8deaed), to(#9fedf0));
    background: -moz-linear-gradient(#8deaed, #9fedf0);
    background: linear-gradient(#8deaed, #9fedf0);
    border: solid 1px #79c5c7;
    border-bottom: solid 3px #4fa7aa;
    box-shadow: inset 0 0 0 1px #b9f2f5; }
    
button.teal:active {
    background: #84e4e7;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#84e4e7), to(#80dcdf));
    background: -moz-linear-gradient(#84e4e7, #80dcdf);
    background: linear-gradient(#84e4e7, #80dcdf);
    border: solid 1px #58999b;
    box-shadow: inset 0 10px 15px 0 #75c9cc; }
    
/**
 * Black
 */
a.button.black {
    background: #656565;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#656565), to(#444));
    background: -moz-linear-gradient(#656565, #444);
    background: linear-gradient(#656565, #444);
    border: solid 1px #535353;
    border-bottom: solid 3px #414141;
    box-shadow: inset 0 0 0 1px #939393;
    color: #fff;
    text-shadow: 0 1px 0 #2f2f2f; }
    
a.button.black:hover {
    background: #4c4c4c;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#4c4c4c), to(#565656));
    background: -moz-linear-gradient(#4c4c4c, #565656);
    background: linear-gradient(#4c4c4c, #565656);
    border: solid 1px #464646;
    border-bottom: solid 3px #414141;
    box-shadow: inset 0 0 0 1px #818181; }
    
a.button.black:active {
    background: #474747;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#474747), to(#444));
    background: -moz-linear-gradient(#474747, #444);
    background: linear-gradient(#474747, #444);
    border: solid 1px #2f2f2f;
    box-shadow: inset 0 10px 15px 0 #3e3e3e; }
    
/**
 * Dark Grey
 */
a.button.dark_grey {
    background: #d1d1d1;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#d1d1d1), to(#afafaf));
    background: -moz-linear-gradient(#d1d1d1, #afafaf);
    background: linear-gradient(#d1d1d1, #afafaf);
    border: solid 1px #b4b4b4;
    border-bottom: solid 3px #878787;
    box-shadow: inset 0 0 0 1px #e3e3e3;
    color: #555;
    text-shadow: 0 1px 0 #d6d6d6; }
    
a.button.dark_grey:hover {
    background: #b7b7b7;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#b7b7b7), to(#c2c2c2));
    background: -moz-linear-gradient(#b7b7b7, #c2c2c2);
    background: linear-gradient(#b7b7b7, #c2c2c2);
    border: solid 1px #a2a2a2;
    border-bottom: solid 3px #878787;
    box-shadow: inset 0 0 0 1px #d4d4d4; }
    
a.button.dark_grey:active {
    background: #afafaf;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#afafaf), to(#a9a9a9));
    background: -moz-linear-gradient(#afafaf, #a9a9a9);
    background: linear-gradient(#afafaf, #a9a9a9);
    border: solid 1px #757575;
    box-shadow: inset 0 10px 15px 0 #9a9a9a; }
    
/**
 * Orange
 */
a.button.orange {
    background: #feda71;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#feda71), to(#febe4d));
    background: -moz-linear-gradient(#feda71, #febe4d);
    background: linear-gradient(#feda71, #febe4d);
    border: solid 1px #eab551;
    border-bottom: solid 3px #b98a37;
    box-shadow: inset 0 0 0 1px #fee9aa;
    color: #996633;
    text-shadow: 0 1px 0 #fedd9b; }
    
a.button.orange:hover {
    background: #fec455;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#fec455), to(#fecd61));
    background: -moz-linear-gradient(#fec455, #fecd61);
    background: linear-gradient(#fec455, #fecd61);
    border: solid 1px #e6a93d;
    border-bottom: solid 3px #b98a37;
    box-shadow: inset 0 0 0 1px #fedb98; }
    
a.button.orange:active {
    background: #f9bd4f;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f9bd4f), to(#f0b64d));
    background: -moz-linear-gradient(#f9bd4f, #f0b64d);
    background: linear-gradient(#f9bd4f, #f0b64d);
    border: solid 1px #a77f35;
    box-shadow: inset 0 10px 15px 0 #dba646; }
    
/**
 * Purple
 */
a.button.purple {
    background: #e8c4e4;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#e8c4e4), to(#d698d0));
    background: -moz-linear-gradient(#e8c4e4, #d698d0);
    background: linear-gradient(#e8c4e4, #d698d0);
    border: solid 1px #da9fd4;
    border-bottom: solid 3px #946890;
    box-shadow: inset 0 0 0 1px #f2dcef;
    color: #7b5777;
    text-shadow: 0 1px 0 #eacae6; }
    
a.button.purple:hover {
    background: #daa2d4;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#daa2d4), to(#e0b1db));
    background: -moz-linear-gradient(#daa2d4, #e0b1db);
    background: linear-gradient(#daa2d4, #e0b1db);
    border: solid 1px #ca91c4;
    border-bottom: solid 3px #946890;
    box-shadow: inset 0 0 0 1px #e9c7e6; }
    
a.button.purple:active {
    background: #d49ace;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#d49ace), to(#cc94c6));
    background: -moz-linear-gradient(#d49ace, #cc94c6);
    background: linear-gradient(#d49ace, #cc94c6);
    border: solid 1px #8e678a;
    box-shadow: inset 0 10px 15px 0 #ba87b5; }
    
/**
 * Blue Alt
 */
a.button.blue_alt {
    background: #becbd6;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#becbd6), to(#8da5b7));
    background: -moz-linear-gradient(#becbd6, #8da5b7);
    background: linear-gradient(#becbd6, #8da5b7);
    border: solid 1px #a1aeb7;
    border-bottom: solid 3px #62727e;
    box-shadow: inset 0 0 0 1px #d8e0e6;
    color: #515f6a;
    text-shadow: 0 1px 0 #c4d0da; }
    
a.button.blue_alt:hover {
    background: #97adbd;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#97adbd), to(#a8bac8));
    background: -moz-linear-gradient(#97adbd, #a8bac8);
    background: linear-gradient(#97adbd, #a8bac8);
    border: solid 1px #96a2ab;
    border-bottom: solid 3px #62727e;
    box-shadow: inset 0 0 0 1px #c0ced7; }
    
a.button.blue_alt:active {
    background: #8fa6b6;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#8fa6b6), to(#8aa0b0));
    background: -moz-linear-gradient(#8fa6b6, #8aa0b0);
    background: linear-gradient(#8fa6b6, #8aa0b0);
    border: solid 1px #606f7a;
    box-shadow: inset 0 10px 15px 0 #7e92a1; }
    
/**
 * Crisp
 */
a.button.crisp {
    background: #c38b66;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#c38b66), to(#9d6741));
    background: -moz-linear-gradient(#c38b66, #9d6741);
    background: linear-gradient(#c38b66, #9d6741);
    border: solid 1px #422213;
    border-bottom: solid 3px #33180d;
    box-shadow: inset 0 0 0 1px #b98c62;
    color: #fff;
    text-shadow: 0 1px 0 #7b502e; }
    
a.button.crisp:hover {
    background: #9d6741;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#9d6741), to(#c38b66));
    background: -moz-linear-gradient(#9d6741, #c38b66);
    background: linear-gradient(#9d6741, #c38b66);
    border: solid 1px #422213;
    border-bottom: solid 3px #33180d;
    box-shadow: inset 0 0 0 1px #b98c62; }
    
a.button.crisp:active {
    background: #9d6741;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#9d6741), to(#c38b66));
    background: -moz-linear-gradient(#9d6741, #c38b66);
    background: linear-gradient(#9d6741, #c38b66);
    border: solid 1px #422213;
    box-shadow: inset 0 10px 15px 0 #7b502e; }
    
/**
 * Forrst - Special Edition
 */
a.button.forrst {
    background: #4a7746;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#4a7746), to(#335d30));
    background: -moz-linear-gradient(#4a7746, #335d30);
    background: linear-gradient(#4a7746, #335d30);
    border: solid 1px #1b3013;
    border-bottom: solid 3px #0a1608;
    box-shadow: inset 0 0 0 1px #53864f;
    color: #142413;
    text-shadow: 0 1px 0 #4b7b47; }
    
a.button.forrst:hover {
    background: #335d30;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#335d30), to(#4a7746));
    background: -moz-linear-gradient(#335d30, #4a7746);
    background: linear-gradient(#335d30, #4a7746);
    border: solid 1px #1b3013;
    border-bottom: solid 3px #0a1608;
    box-shadow: inset 0 0 0 1px #53864f; }
    
a.button.forrst:active {
    background: #335d30;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#335d30), to(#4a7746));
    background: -moz-linear-gradient(#335d30, #4a7746);
    background: linear-gradient(#335d30, #4a7746);
    border: solid 1px #1b3013;
    box-shadow: inset 0 10px 15px 0 #294a16; }
    
/**
 * Dribbble - Special Edition
 */
a.button.dribbble {
    background: #f1a4c1;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f1a4c1), to(#e675a0));
    background: -moz-linear-gradient(#f1a4c1, #e675a0);
    background: linear-gradient(#f1a4c1, #e675a0);
    border: solid 1px #e98eb0;
    border-bottom: solid 3px #cc4a79;
    box-shadow: inset 0 0 0 1px #f6c2d7;
    color: #fff;
    text-shadow: 0 1px 0 #d64570; }
    
a.button.dribbble:hover {
    background: #e675a0;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#e675a0), to(#f1a4c1));
    background: -moz-linear-gradient(#e675a0, #f1a4c1);
    background: linear-gradient(#e675a0, #f1a4c1);
    border: solid 1px #e98eb0;
    border-bottom: solid 3px #cc4a79;
    box-shadow: inset 0 0 0 1px #f6c2d7; }
    
a.button.dribbble:active {
    background: #e675a0;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#e675a0), to(#f1a4c1));
    background: -moz-linear-gradient(#e675a0, #f1a4c1);
    background: linear-gradient(#e675a0, #f1a4c1);
    border: solid 1px #e98eb0;
    box-shadow: inset 0 10px 15px 0 #e05285; }
    
/**
 * Twitter - Special Edition
 */
a.button.twitter {
    background: #9fd6fa;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#9fd6fa), to(#6bb9f7));
    background: -moz-linear-gradient(#9fd6fa, #6bb9f7);
    background: linear-gradient(#9fd6fa, #6bb9f7);
    border: solid 1px #72bdf4;
    border-bottom: solid 3px #4a9de1;
    box-shadow: inset 0 0 0 1px #bfe4fc;
    color: #fff;
    text-shadow: 0 1px 0 #4598f3; }
    
a.button.twitter:hover {
    background: #6bb9f7;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#6bb9f7), to(#9fd6fa));
    background: -moz-linear-gradient(#6bb9f7, #9fd6fa);
    background: linear-gradient(#6bb9f7, #9fd6fa);
    border: solid 1px #72bdf4;
    border-bottom: solid 3px #4a9de1;
    box-shadow: inset 0 0 0 1px #bfe4fc; }
    
a.button.twitter:active {
    background: #6bb9f7;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#6bb9f7), to(#9fd6fa));
    background: -moz-linear-gradient(#6bb9f7, #9fd6fa);
    background: linear-gradient(#6bb9f7, #9fd6fa);
    border: solid 1px #72bdf4;
    box-shadow: inset 0 10px 15px 0 #50aaf3; }
    
/**
 * Facebook - Special Edition
 */
a.button.facebook {
    background: #99b6df;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#99b6df), to(#638ec8));
    background: -moz-linear-gradient(#99b6df, #638ec8);
    background: linear-gradient(#99b6df, #638ec8);
    border: solid 1px #6d94ce;
    border-bottom: solid 3px #3867ac;
    box-shadow: inset 0 0 0 1px #bbcfeb;
    color: #fff;
    text-shadow: 0 1px 0 #3c61ab; }
    
a.button.facebook:hover {
    background: #638ec8;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#638ec8), to(#99b6df));
    background: -moz-linear-gradient(#638ec8, #99b6df);
    background: linear-gradient(#638ec8, #99b6df);
    border: solid 1px #6d94ce;
    border-bottom: solid 3px #3867ac;
    box-shadow: inset 0 0 0 1px #bbcfeb; }
    
a.button.facebook:active {
    background: #638ec8;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#638ec8), to(#99b6df));
    background: -moz-linear-gradient(#638ec8, #99b6df);
    background: linear-gradient(#638ec8, #99b6df);
    border: solid 1px #6d94ce;
    box-shadow: inset 0 10px 15px 0 #4176c4; }
    
/**
 * LoveDSGN - Special Edition
 */
a.button.lovedsgn {
    background: #f3c1e6;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f3c1e6), to(#de66c0));
    background: -moz-linear-gradient(#f3c1e6, #de66c0);
    background: linear-gradient(#f3c1e6, #de66c0);
    border: solid 1px #cd5daf;
    border-bottom: solid 3px #ce5eb0;
    box-shadow: inset 0 0 0 1px #e998d3;
    color: #fff;
    text-shadow: 0 1px 0 #ce5eb0; }
    
a.button.lovedsgn:hover {
    background: #de66c0;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#de66c0), to(#f3c1e6));
    background: -moz-linear-gradient(#de66c0, #f3c1e6);
    background: linear-gradient(#de66c0, #f3c1e6);
    border: solid 1px #cd5daf;
    border-bottom: solid 3px #ce5eb0;
    box-shadow: inset 0 0 0 1px #e998d3; }
    
a.button.lovedsgn:active {
    background: #de66c0;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#de66c0), to(#f3c1e6));
    background: -moz-linear-gradient(#de66c0, #f3c1e6);
    background: linear-gradient(#de66c0, #f3c1e6);
    border: solid 1px #cd5daf;
    box-shadow: inset 0 10px 15px 0 #ce5eb0; }
    
/**
 * XBOX - Special Edition
 */
a.button.xbox {
    background: #c4e125;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#c4e125), to(#88a819));
    background: -moz-linear-gradient(#c4e125, #88a819);
    background: linear-gradient(#c4e125, #88a819);
    border: solid 1px #829c15;
    border-bottom: solid 3px #819d15;
    box-shadow: inset 0 0 0 1px #c6da7b;
    color: #fff;
    text-shadow: 0 1px 0 #819d15; }
    
a.button.xbox:hover {
    background: #88a819;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#88a819), to(#c4e125));
    background: -moz-linear-gradient(#88a819, #c4e125);
    background: linear-gradient(#88a819, #c4e125);
    border: solid 1px #829c15;
    border-bottom: solid 3px #819d15;
    box-shadow: inset 0 0 0 1px #c6da7b; }
    
a.button.xbox:active {
    background: #88a819;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#88a819), to(#c4e125));
    background: -moz-linear-gradient(#88a819, #c4e125);
    background: linear-gradient(#88a819, #c4e125);
    border: solid 1px #829c15;
    box-shadow: inset 0 10px 15px 0 #819d15; }
    
/**
 * devART - Special Edition
 */
a.button.devart {
    background: #729e85;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#729e85), to(#486d5c));
    background: -moz-linear-gradient(#729e85, #486d5c);
    background: linear-gradient(#729e85, #486d5c);
    border: solid 1px #236036;
    border-bottom: solid 3px #225f33;
    box-shadow: inset 0 0 0 1px #90a59c;
    color: #fff;
    text-shadow: 0 1px 0 #225f33; }
    
a.button.devart:hover {
    background: #486d5c;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#486d5c), to(#729e85));
    background: -moz-linear-gradient(#486d5c, #729e85);
    background: linear-gradient(#486d5c, #729e85);
    border: solid 1px #236036;
    border-bottom: solid 3px #225f33;
    box-shadow: inset 0 0 0 1px #90a59c; }
    
a.button.devart:active {
    background: #486d5c;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#486d5c), to(#729e85));
    background: -moz-linear-gradient(#486d5c, #729e85);
    background: linear-gradient(#486d5c, #729e85);
    border: solid 1px #236036;
    box-shadow: inset 0 10px 15px 0 #225f33; }
    
/**
 * Designmoo - Special Edition
 */
a.button.dsgnmoo {
    background: #f97779;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f97779), to(#ce2424));
    background: -moz-linear-gradient(#f97779, #ce2424);
    background: linear-gradient(#f97779, #ce2424);
    border: solid 1px #be2424;
    border-bottom: solid 3px #bd2524;
    box-shadow: inset 0 0 0 1px #e67e7b;
    color: #fff;
    text-shadow: 0 1px 0 #bd2524; }
    
a.button.dsgnmoo:hover {
    background: #ce2424;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#ce2424), to(#f97779));
    background: -moz-linear-gradient(#ce2424, #f97779);
    background: linear-gradient(#ce2424, #f97779);
    border: solid 1px #be2424;
    border-bottom: solid 3px #bd2524;
    box-shadow: inset 0 0 0 1px #e67e7b; }
    
a.button.dsgnmoo:active {
    background: #ce2424;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#ce2424), to(#f97779));
    background: -moz-linear-gradient(#ce2424, #f97779);
    background: linear-gradient(#ce2424, #f97779);
    border: solid 1px #be2424;
    box-shadow: inset 0 10px 15px 0 #bd2524; }
    
/**
 * RSS Feed - Special Edition
 */
a.button.rss {
    background: #f6c696;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f6c696), to(#e9893d));
    background: -moz-linear-gradient(#f6c696, #e9893d);
    background: linear-gradient(#f6c696, #e9893d);
    border: solid 1px #a1681b;
    border-bottom: solid 3px #a1671d;
    box-shadow: inset 0 0 0 1px #f1bb8f;
    color: #fff;
    text-shadow: 0 1px 0 #a1671d; }
    
a.button.rss:hover {
    background: #e9893d;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#e9893d), to(#f6c696));
    background: -moz-linear-gradient(#e9893d, #f6c696);
    background: linear-gradient(#e9893d, #f6c696);
    border: solid 1px #a1681b;
    border-bottom: solid 3px #a1671d;
    box-shadow: inset 0 0 0 1px #f1bb8f; }
    
a.button.rss:active {
    background: #e9893d;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#e9893d), to(#f6c696));
    background: -moz-linear-gradient(#e9893d, #f6c696);
    background: linear-gradient(#e9893d, #f6c696);
    border: solid 1px #a1681b;
    box-shadow: inset 0 10px 15px 0 #a1671d; }
    
/**
 * Yahoo - Special Edition
 */
a.button.yahoo {
    background: #be95b7;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#be95b7), to(#5f396a));
    background: -moz-linear-gradient(#be95b7, #5f396a);
    background: linear-gradient(#be95b7, #5f396a);
    border: solid 1px #4b2a55;
    border-bottom: solid 3px #4d2955;
    box-shadow: inset 0 0 0 1px #9c83a1;
    color: #fff;
    text-shadow: 0 1px 0 #4d2955; }
    
a.button.yahoo:hover {
    background: #5f396a;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#5f396a), to(#be95b7));
    background: -moz-linear-gradient(#5f396a, #be95b7);
    background: linear-gradient(#5f396a, #be95b7);
    border: solid 1px #4b2a55;
    border-bottom: solid 3px #4d2955;
    box-shadow: inset 0 0 0 1px #9c83a1; }
    
a.button.yahoo:active {
    background: #5f396a;
    background: -webkit-gradient(linear, 0 0, 0 bottom, from(#5f396a), to(#be95b7));
    background: -moz-linear-gradient(#5f396a, #be95b7);
    background: linear-gradient(#5f396a, #be95b7);
    border: solid 1px #4b2a55;
    box-shadow: inset 0 10px 15px 0 #4d2955; }
        </style>

        <script type="text/javascript">
            $(document).ready(function () {

                var counter = 1;

                $("#addElement").click(function (event) {

                    counter++;

                    var $newDiv = $("<div class='input-group' style='margin-bottom:2px'>" + counter + ". Translator  </div>");
                    var $newInput = $("<input value='First Name' type='text'>");
                    $newInput
                            .attr("name", "FirstName" + counter)
                            .attr("id", "first" + counter)
                            .addClass("text wsp");
                    $newInput.appendTo($newDiv);

                    var $newInput = $("<input value='Last Name' type='text'> ");
                    $newInput
                            .attr("name", "LastName" + counter)
                            .attr("id", "last" + counter)
                            .addClass("text");
                    $newInput.appendTo($newDiv);

                    $newDiv.appendTo($("#generatedForm"));
                });

            });
        </script>
        <script>
            function  copyFirstRow() {

                var fn = document.getElementById("first");
                var ln = document.getElementById("last");
                document.getElementById("first0").value = fn.value;
                document.getElementById("last0").value = ln.value;
            }
        </script>
        
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
        </style>
        
        
    </head>
    <body>
        <div id="allContent">

            <div id="myContent">

                <!--<form id="samplecode" name="samplecode" method="POST" action="<%= request.getContextPath()%>/DynamicForm">-->                   
<!--                    <div class="row" style="margin-bottom: 10px">
                        <div class='col-sm-2'>
                            <strong style='margin-bottom:2px'>Translator</strong>
                        </div>
                    </div>-->
                    <div class="row" style="margin-bottom: 10px">
                        <div class='col-sm-6'>

                            <div class="input-group" style='margin-bottom:2px'>

                                <input type="text" id="first" value="First Name" style='margin-bottom:2px'> <input type="text" id="last" value="Last Name" style='margin-bottom:2px'>

                                <a href="#" class="btn btn-group-sm btn-success" 
                                   data-toggle="modal" 
                                   data-target="#addTranslatorModal"
                                   onclick="copyFirstRow();"
                                   >add more Translators</a>

                            </div>

                            <div class="modal fade" id="addTranslatorModal" tabindex="-1" role="dialog" aria-labelledby="addTranslatorModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header" style="background-color: lightseagreen">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="addTranslatorModalLabel">add more Translators</h4>
                                        </div>


                                        <div class="modal-body" style="background-color: green">

                                            <div class="row" style="margin-bottom: 10px">
                                                <div class='col-sm-12'>

                                                    <div  id="generatedForm" class="input-group" style='margin-bottom:2px'>
                                                        1. Translator <input type="text" id="first0" value="First Name" style='margin-bottom:2px'> <input type="text" id="last0" value="Last Name" style='margin-bottom:2px'>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal-footer" style="background-color: lightgreen">
                                            <button id="addElement" type="button" value="Add another Translator"  class="btn btn-group-sm  button teal pull-left">Add another Translator</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Done</button>
                                            <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                        </div> <!--modal footer -->
                                    </div> <!--modal content-->          
                                </div> <!--modal dialog-->
                            </div> <!--modal fade-->
                        </div> <!-- col-sm-6 -->
                    </div> <!-- row -->
                <!--</form>-->
            </div>
        </div>
        <div></div>
    </body>
</html>