<%-- 
    Document   : resetPassword
    Created on : 14-Mar-2017, 09:33:35
    Author     : markus
--%>

<body>

    <div id="shadowholder">

        <div class="shadowtop"> </div>

        <div id="container">
            <div id="topspacer"> </div>

            <div id="topbar">
                <div class="animateddiv">
                    <a href="/the-translation-grant-programme"><img src="images/flashtext-animated2.gif" alt="Promoting Irish Literature Abroad" /></a>
                </div>
                <a href="/" class="logo"><span class="hidden">Literature Ireland</span></a>
            </div><!-- End of topbar div -->

            <div class="container-fluid"> 


                <div style="max-width:400px;padding:10px 20px;margin:auto;margin-top:30px;">
                    <h3 style="text-align:center">Change Password 1212</h3>
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
                    <div id="loginUser" style="display:none">
                        Now you can verify your password by <a href="index.jsp">Login</a>
                    </div>
                    <form class="form-horizontal" id="formChangePassword" data-toggle="validator" role="form">
                        <div class="form-group">
                            <label for="inputPassword" class="control-label">New Password</label>
                            <input type="password" pattern="[A-Za-z0-9@#$%!^&*]{6,30}" name="inputPassword" class="form-control" id="inputPassword" placeholder="Enter New Password" data-error="Password should not be null. It should be greater than 6 and less than 30 characters . Use only A-Z, a-z, 0-9, @ # $ % ! ^ & * charecters" required>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="control-label">Confirm New Password</label>
                            <input type="password" name="inputPassword1" class="form-control" id="inputPassword1" data-match="#inputPassword" placeholder="Enter New Password Again" data-error="It should not be null and should match with above password" required>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <button style="width:100%" type="submit" class="btn btn-default btn-primary">Login</button>
                        </div>
                    </form>
                </div>
                <div id="blockUiDiv">
                    <img src="images/gears.svg"  alt="spinner"/>
                </div>
                <div id="blockUiBackdrop">
                </div>

            </div> <!-- /container-fluid -->

    <script>
        $(function () {
            $('#formChangePassword').validator().on('submit', function (e) {
                if (e.isDefaultPrevented()) {
                    // handle the invalid form...
                } else {
                    blockUi();
                    // everything looks good!
                    $.post("ChangePassword", $("#formChangePassword").serialize(), function (data) {
                        var jdata = JSON.parse(data);
                        if (jdata.code === -1) {
                            $("#errorField .message").text(jdata.message);
                            $("#errorField").show();
                            $("#successField").hide();
                            $("#loginUser").hide();
                        } else {
                            $("#successField .message").text(jdata.message);
                            $("#errorField").hide();
                            $("#successField").show();
                            $("#loginUser").show();
                            $("#formChangePassword").hide();
                        }
                    }).always(function () {
                        unBlockUi();
                    });
                }
                return false;
            });
        });
    </script>

    
         <!--footer start-->
         
         