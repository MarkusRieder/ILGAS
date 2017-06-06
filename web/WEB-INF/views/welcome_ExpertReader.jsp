<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ page session="true"%>--%>
<!DOCTYPE html>

<!--css for panel-->
<style>
    .panel-body {
        margin-top: 5px;
        box-shadow: 0 0 10px black;
        padding:0 15px 0 15px;
        background: #d9d1d1;
    }
</style>

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
                            <br/>
                            <input type="file" name="file" id="report" /> <br/>
                            Destination:
                            <input type="text" value="/home/markus/test/report" name="destination"/>
                            <br/>
                            <input type="submit" value="Upload" name="upload_agreement" id="upload_report" style="margin-top: 10px"/>
                        </form> 
                    </div>
                    <div class="col-md-4">            
                        <form method="POST" action="upload" enctype="multipart/form-data" >
                            <h3 style="background-color: red">to todo</h3>
                            <h1>Upload your invoice</h1>
                            <br/>
                            <input type="file" name="file" id="invoice" /> <br/>
                            Destination:
                            <input type="text" value="/home/markus/test/invoice" name="destination"/>
                            <br/>
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

