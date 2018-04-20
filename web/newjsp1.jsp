<%-- 
    Document   : newjsp1
    Created on : 17-Apr-2018, 11:58:40
    Author     : markus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                padding-top: 70px;
            }

            .imageupload {
                margin: 20px 0;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">

        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script type="text/javascript"  src="js/moment.js"></script>
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script type="text/javascript"  src="js/bootstrap-datepicker.js"></script>
        <script type="text/javascript"  src="js/jquery-ui.js"></script>
        <script type="text/javascript"  src="js/pdf.js"></script>
        <script type="text/javascript"  src="js/pdf.worker.js"></script>



        <link href="kartik/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="kartik/js/plugins/sortable.js"></script>
        <script type="text/javascript" src="kartik/js/plugins/piexif.js"></script>
        <script type="text/javascript" src="kartik/js/plugins/purify.js"></script>
                        
        <script src="kartik/js/fileinput.js" type="text/javascript"></script>
      
    </head>
    <body>
        <h1>Hello World!</h1>



        <label for="input-25">Planets and Satellites</label>
        <div class="file-loading">
            <input id="input-25" name="input25[]" type="file" multiple>
        </div>
        <script>
            $(document).on('ready', function () {
                var url1 = 'http://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/FullMoon2010.jpg/631px-FullMoon2010.jpg',
                        url2 = 'http://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Earth_Eastern_Hemisphere.jpg/600px-Earth_Eastern_Hemisphere.jpg';
                $("#input-25").fileinput({
                    initialPreview: [url1, url2],
                    initialPreviewAsData: true,
                    initialPreviewConfig: [
                        {caption: "Moon.jpg", filename: "MoonFull.jpg", downloadUrl: url1, size: 930321, width: "120px", key: 1},
                        {caption: "Earth.jpg", filename: "EarthFull.jpg", downloadUrl: url2, size: 1218822, width: "120px", key: 2}
                    ],
                    deleteUrl: "/site/file-delete",
                    uploadUrl: "/~/public_html/test",
                    overwriteInitial: false,
                    initialCaption: "The Moon and the Earth"
                });
            });
        </script>

<hr/>

 <label for="input-26">Tesssssssssssting</label>
        <div class="file-loading">
            <input id="input-26" name="input26" type="file" >
        </div>
        <script>
            $(document).on('ready', function () {
              var url1 = 'http://localhost:8080/ILGAS/images/not-available.jpg';
                $("#input-26").fileinput({
                   initialPreview: [url1],
                    initialPreviewAsData: true,
                    initialPreviewConfig: [
                        {caption: "not-available.jpg", filename: "not-available.jpg", downloadUrl: url1, size: 930321, width: "120px", key: 1}
                    ],
                    deleteUrl: "/site/file-delete",     
                    uploadUrl: '/file-upload-batch/2',
                    overwriteInitial: true,
                    initialCaption: "Testing"
                });
            });
        </script>


    </body>
</html>
