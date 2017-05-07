<%-- 
    Document   : login
    Created on : 26-Feb-2017, 23:41:51
    Author     : markus
--%>




                <h1 align="center">Grant Application System for Literature Ireland</h1>

                <div class="container-fluid">

                    <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
                        <div class="panel panel-info" >
                            <div class="panel-heading">
                           <div class="alert-danger"  align="center" >Your credentials are wrong!</div>
                        <div class="panel-title" align="center" >Try Again</div>
                        <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot password?</a></div>
                    </div>     

                    <div style="padding-top:30px" class="panel-body" >

                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>

                        <form id="loginform" class="form-horizontal" action="${pageContext.request.contextPath}/login.do" method="POST"  role="form" >

                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input id="login-username" type="text" class="form-control" name="username" value="" placeholder="username">                                        
                            </div>

                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <input id="login-password" type="password" class="form-control" name="password" placeholder="password">
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
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="panel-title">Sign Up</div>
                        <div style="float:right; font-size: 85%; position: relative; top:-10px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
                    </div>  

                    <div class="panel-body" >

                        <div class="signup-form-container">

                            <form class="form-horizontal" role="form"  id="register-form" autocomplete="off"  action="${pageContext.request.contextPath}/register.do" method="POST" name="regF">

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
                                            <input type="text" class="form-control" name="username" id="uname" placeholder="Username" onblur="loadXMLDoc()"/>                                         
                                        </div>
                                        <span class="help-block" id="error"></span> 
                                    </div>
                                    <div class="form-group">
                                        <!--<label for="firstname" class="col-md-3 control-label">First Name</label>-->
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" name="firstname" placeholder="First Name">
                                        </div>
                                        <span class="help-block" id="error"></span> 
                                    </div>
                                    <div class="form-group">
                                        <!--<label for="lastname" class="col-md-3 control-label">Last Name</label>-->
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" name="lastname" placeholder="Last Name">
                                        </div>
                                        <span class="help-block" id="error"></span> 
                                    </div>       
                                    <div class="form-group">
                                        <!--<label for="email" class="col-md-3 control-label">Email</label>-->
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" name="email" placeholder="Email Address">
                                        </div>
                                        <span class="help-block" id="error"></span>      
                                    </div>

                                    <div class="form-group">
                                        <!--<label for="password" class="col-md-3 control-label">Password</label>-->
                                        <div class="col-md-9">
                                            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                        </div>
                                        <span class="help-block" id="error"></span> 
                                    </div>
                                    <div class="form-group">
                                        <!--<label for="cpassword" class="col-md-3 control-label">Confirm Password</label>-->
                                        <div class="col-md-9">
                                            <input type="password" class="form-control"  id="cpassword" name="cpassword" placeholder="Confirm Password">
                                        </div>
                                        <span class="help-block" id="error"></span> 
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
                                        </div>
                                        <span class="help-block" id="error"></span> 
                                    </div> <%--/col-sm-12 --%>
                                </div>
                                <!--<input type="text" name="txtprice" id="txtprice" onClick="checkPrice()">-->
                                <div class="form-footer">
                                    <button type="submit" class="btn btn-info">
                                        <span class="glyphicon glyphicon-log-in"></span> Sign Me Up !
                                    </button>
                                </div>

                            </form>
                        </div>
                    </div>
                    <div style="border-top: 1px solid #999; padding-top:20px"  class="form-group"> 
                    </div>
                </div>
            </div>
        </div> <!-- /container -->
    


