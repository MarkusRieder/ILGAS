<%-- 
    Document   : login
    Created on : 26-Feb-2017, 23:41:51
    Author     : markus
--%>


        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/layout.css">
        <link rel="stylesheet" type="text/css" href="css/my-block-ui.css">   
        <link rel="stylesheet" type="text/css" href="css/bootstrap-select.css">
        <link rel="stylesheet" type="text/css" href="css/form.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">

        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>-->

        <!--<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>-->
        <!--<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>-->


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

        <script type="text/javascript">

            function changeFunc() {
                var selectBox = document.getElementById("functionDataset");
                var selectedValue = selectBox.options[selectBox.selectedIndex].value;


                if (selectedValue === 'Publisher') {
                    alert(selectedValue);
                    $('#signupbox').hide();
                    $('#publisherBox').show();
                }
            }

        </script>

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

                    <div class="col-sm-6">
                                                    <!--<select class="selectpicker" title="Select Your Function" style="display: none;">-->
                                                    <select class="selectpicker" 
                                                            title="Select Your Function" 
                                                            style="display: none;" 
                                                            name="function" 
                                                            id="functionDataset" 
                                                            onchange="changeFunc();"
                                                            required
                                                            >

                                                        <option>Literature Ireland Staff</option>
                                                        <option>Publisher</option>
                                                        <option>Expert Reader</option>
                                                    </select>                                        
                                                    <span class="help-block" id="error"></span> 
                                                </div>


<div id="publisherBox" >

</div> <!--publisherBox-->

                <script>
                    $(function () {
                        $('#register-form').validator().on('submit', function (e) {
                            if (e.isDefaultPrevented()) {
                                // handle the invalid form...
                            } else {
                                blockUi();
                                // everything looks good!
                                $.post("RegisterServlet", $("#register-form").serialize(), function (data) {
                                    var jdata = JSON.parse(data);
                                    if (jdata.code === -1) {
                                        $("#errorField .message").text(jdata.message);
                                        $("#errorField").show();
                                        $("#successField").hide();
                                    } else {
                                        $("#successField .message").text(jdata.message);
                                        $("#errorField").hide();
                                        $("#successField").show();
                                        $("#formRegister").hide();
                                    }
                                }).always(function () {
                                    unBlockUi();
                                });
                            }
                            return false;
                        });

                    });

                </script>

                <script>
                    $(function () {
                        $('#methods').click(function () {
                            $('#password').password('toggle');
                        });
                    });
                </script>

                <script type="text/javascript">
                    function loadXMLDoc()
                    {
                        var xmlhttp;
                        var uname = document.getElementById("uname").value;
                        var urls = "checkusername.jsp?uname=" + uname;

                        if (window.XMLHttpRequest)
                        {
                            xmlhttp = new XMLHttpRequest();
                        } else
                        {
                            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        xmlhttp.onreadystatechange = function ()
                        {
                            if (xmlhttp.readyState === 4)
                            {
                                document.getElementById("error").innerHTML = xmlhttp.responseText;
                            }
                        };
                        xmlhttp.open("GET", urls, true);
                        xmlhttp.send();
                    }
                    ;
                </script>

                <script type="text/javascript">
                    window.onload = function () {
                        $('.selectpicker').selectpicker();
                        $('.functionDataset').each(function () {
                            $(this).rules('add', {
                                required: true,
                                messages: {
                                    required: "Choose a function"
                                }
                            });
                            // scrollYou
                            $('.scrollMe .dropdown-menu').scrollyou();
                            prettyPrint();
                        });
                    };
                </script>
---------------------------------------------------------------------------------------------------



<h1 align="center" style="align-content: center">Grant Application System for Literature Ireland</h1>

<div class="container-fluid">

    <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
        <div class="panel panel-info" >
            <div class="panel-heading">
                <div class="panel-title">Sign In</div>
                <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="forgotPassword.jsp">Forgot password ?</a></div>
            </div>     

            <div style="padding-top:30px" class="panel-body" >

                <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>

                <form id="loginform" class="form-horizontal" action="${pageContext.request.contextPath}/login" method="POST"  role="form" >

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="login-username" 
                               type="text" 
                               class="form-control" 
                               name="username" 
                               value="" 
                               placeholder="username"
                               >   

                    </div>

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="lpassword" 
                               type="password" 
                               class="form-control" 
                               name="password" 
                               data-toggle="password"  
                               data-placement="after" 
                               placeholder="password"
                               >

                        <div class="help-block with-errors"></div>
                    </div>

                    <div style="margin-top:10px" class="form-group">
                        <!-- Button -->

                        <div class="col-sm-12 controls">
                            <!--<a type="submit" id="btn-login" href="#"  class="btn btn-success">Login  </a>-->
                            <input type="submit" class="btn btn-success btn-send" value="Login">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-12 control">
                            <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%" >
                                Don't have an account! 
                                <a href="#" onClick="$('#loginbox').hide();
                                        $('#signupbox').show()">
                                    Sign Up Here
                                </a>
                            </div>
                        </div>
                    </div>    
                </form>     
            </div>                     
        </div>  
    </div>

    <!--Signup-->
    <div id="signupbox" style="display:none; margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">

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

        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="panel-title">Sign Up</div>

                <div style="float:right; font-size: 85%; position: relative; top:-10px">
                    <a id="signinlink" 
                       href="#" 
                       onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
            </div>  

            <div class="panel-body">

                <div class="signup-form-container">

                    <form class="form-horizontal" 
                          role="form"  
                          id="register-form" 
                          autocomplete="off"  
                          action="${pageContext.request.contextPath}/RegisterServlet" 
                          method="POST" 
                          name="regF"
                          >

                        <div id="signupalert" style="display:none" class="alert alert-danger">
                            <p>Error:</p>
                            <span></span>
                        </div>

                        <div class="form-body">

                            <div class="alert alert-info" id="message" style="display:none;">
                                submitted
                            </div>

                            <div class="form-group">
                                <!-- <label for="username" class="col-md-3 control-label">Username</label>-->
                                <div class="col-md-9">
                                    <input type="text" 
                                           class="form-control" 
                                           name="uname" 
                                           id="uname" 
                                           placeholder="Username" 
                                           data-toggle="validator"
                                           onblur="loadXMLDoc()"
                                           pattern="[A-Za-z0-9 \-']{1,20}" 
                                           data-error="Username should not be null. It should be less than 20 characters. Use only A-Z, a-z, 0-9 charecters"
                                           required
                                           >     

                                    <span class="help-block" id="error"></span> 
                                </div>
                            </div>

                            <div class="form-group">
                                <!--<label for="firstname" class="col-md-3 control-label">First Name</label>-->
                                <div class="col-md-9">
                                    <input type="text" 
                                           class="form-control" 
                                           name="firstname" 
                                           placeholder="First Name" 
                                           data-toggle="validator"
                                           pattern="[A-Za-z0-9]{1,20}" 
                                           data-error="First name should not be null. It should be less than 20 characters. Use only A-Z, a-z, 0-9 charecters"
                                           required
                                           >              

                                    <span class="help-block" id="error"></span> 
                                </div>
                            </div>

                            <div class="form-group">
                                <!--<label for="lastname" class="col-md-3 control-label">Last Name</label>-->
                                <div class="col-md-9">
                                    <input type="text" 
                                           class="form-control" 
                                           name="lastname" 
                                           placeholder="Last Name"
                                           data-toggle="validator"
                                           pattern="[A-Za-z0-9 \-']{1,20}" 
                                           data-error="Last name should not be null. It should be less than 20 characters. Use only A-Z, a-z, 0-9 charecters"
                                           required
                                           >    

                                    <span class="help-block" id="error"></span> 
                                </div>
                            </div>       

                            <div class="form-group">
                                <!--<label for="email" class="col-md-3 control-label">Email</label>-->
                                <div class="col-md-9">
                                    <input type="text" 
                                           class="form-control" 
                                           name="email" 
                                           placeholder="Email Address"
                                           data-toggle="validator"
                                           pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
                                           data-error="Enter valid Email"
                                           required
                                           >                                            

                                    <span class="help-block" id="error"></span>      
                                </div>
                            </div>

                            <div class="form-group">
                                <!--<label for="password" class="col-md-3 control-label">Password</label>-->
                                <div class="col-md-9">
                                    <input type="password" 
                                           class="form-control" 
                                           id="password"
                                           name="password" 
                                           placeholder="Enter Password"    
                                           pattern="[A-Za-z0-9@#$%!^&*]{6,30}" 
                                           data-error="Password should not be null. It should be greater than 6 and less than 30 characters . 
                                           Use only A-Z, a-z, 0-9, @ # $ % ! ^ & * charecters" 
                                           required                                                                                     
                                           >                                           

                                    <span class="help-block" id="error"></span> 
                                </div>
                            </div>

                            <div class="form-group">
                                <!--<label for="cpassword" class="col-md-3 control-label">Confirm Password</label>-->
                                <div class="col-md-9">
                                    <input type="text" 
                                           class="form-control"  
                                           id="cpassword" 
                                           name="cpassword" 
                                           placeholder="Confirm Password"                                           
                                           data-match="#password"                                                                      
                                           required
                                           >                               

                                    <span class="help-block" id="error"></span> 
                                </div>
                            </div>

                            <div class="form-group">
                                <!--<label for="location" class="col-sm-3 control-label">Select your function</label>-->
                                <div class="col-sm-6">
                                    <!--<select class="selectpicker" title="Select Your Function" style="display: none;">-->
                                    <select class="selectpicker" title="Select Your Function" style="display: none;" name="function" id="functionDataset" required>
                                        <option>Literature Ireland Staff</option>
                                        <option>Publisher</option>
                                        <option>Expert Reader</option>
                                    </select>                                        
                                    <span class="help-block" id="error"></span> 
                                </div>
                            </div> <%--form-group --%>
                        </div><%--form-body --%>

                        <!--<input type="text" name="txtprice" id="txtprice" onClick="checkPrice()">-->
                        <div class="form-footer">
                            <button type="submit" class="btn btn-info">
                                <span class="glyphicon glyphicon-log-in"></span> Sign Me Up !
                            </button>
                        </div>
                    </form>

                    <div id="blockUiDiv">
                        <img src="images/gears.svg" alt="spinner.gif"/>
                    </div>
                    <div id="blockUiBackdrop">
                    </div>
                </div>
            </div>

            <div style="border-top: 1px solid #999; padding-top:20px"  class="form-group"> 
            </div>
        </div>
    </div>  
</div> <!-- /container-fluid -->
<script>
    $(function () {
        $('#register-form').validator().on('submit', function (e) {
            if (e.isDefaultPrevented()) {
                // handle the invalid form...
            } else {
                blockUi();
                // everything looks good!
                $.post("RegisterServlet", $("#register-form").serialize(), function (data) {
                    var jdata = JSON.parse(data);
                    if (jdata.code === -1) {
                        $("#errorField .message").text(jdata.message);
                        $("#errorField").show();
                        $("#successField").hide();
                    } else {
                        $("#successField .message").text(jdata.message);
                        $("#errorField").hide();
                        $("#successField").show();
                        $("#formRegister").hide();
                    }
                }).always(function () {
                    unBlockUi();
                });
            }
            return false;
        });

    });

</script>

<script>
    $(function () {
        $('#methods').click(function () {
            $('#password').password('toggle');
        });
    });
</script>

<script type="text/javascript">
    function loadXMLDoc()
    {
        var xmlhttp;
        var uname = document.getElementById("uname").value;
        var urls = "checkusername.jsp?uname=" + uname;

        if (window.XMLHttpRequest)
        {
            xmlhttp = new XMLHttpRequest();
        } else
        {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4)
            {
                document.getElementById("error").innerHTML = xmlhttp.responseText;
            }
        };
        xmlhttp.open("GET", urls, true);
        xmlhttp.send();
    }
    ;
</script>

<script type="text/javascript">
    window.onload = function () {
        $('.selectpicker').selectpicker();
        $('.functionDataset').each(function () {
            $(this).rules('add', {
                required: true,
                messages: {
                    required: "Choose a function"
                }
            });
            // scrollYou
            $('.scrollMe .dropdown-menu').scrollyou();
            prettyPrint();
        });
    };
</script>



        <script type="text/javascript">

            function changeFunc() {
                var selectBox = document.getElementById("functionDataset");
                var selectedValue = selectBox.options[selectBox.selectedIndex].value;


                if (selectedValue === 'Publisher') {
                    alert(selectedValue);
                    $('#signupbox').hide();
                    $('#publisherBox').show();
                }
            }

        </script>
