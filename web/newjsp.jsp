<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : newjsp
    Created on : 25-Mar-2017, 15:55:36
    Author     : markus
--%>


<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${companyDetails.Company}</title>



    </head>
    <body>
        <sql:query var="companyQuery" dataSource="jdbc/ILGAS">
            SELECT * FROM international_publishers
            WHERE international_publishers.Company_Number = ?
            <sql:param value="${param.Company_Number}"/>
        </sql:query>

        <c:set var="companyDetails" value="${companyQuery.rows[0]}"/>
        <table>
            <tr>
                <th colspan="2">${companyDetails.Company}</th>
            </tr>
            <tr>
                <td><strong>Description: </strong></td>
                <td><span style="font-size:smaller; font-style:italic;">${companyDetails.description}</span></td>
            </tr>
            <tr>
                <td><strong>Company </strong></td>
                <td><strong>${companyDetails.First_Name} ${companyDetails.job_description} ${companyDetails.Surname}</strong>
                    <br><span style="font-size:smaller; font-style:italic;">
                        <em>member since: ${companyDetails.Date_modified}</em></span></td>
            </tr>
            <tr>
                <td><strong>Contact Details: </strong></td>
                <td><strong>email: </strong>
                    <a href="mailto:${companyDetails.Email}">${companyDetails.Email}</a>
                    <br><strong>phone: </strong>${companyDetails.Telephone}</td>
            </tr>
        </table>

        <hr/>

        <div class="container">

            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li class="active">
                    <a href="#home" role="tab" data-toggle="tab">
                        <i class="fa fa-home"></i> Home
                    </a>
                </li>
                <li><a href="#profile" role="tab" data-toggle="tab">
                        <i class="fa fa-user"></i> Profile
                    </a>
                </li>
                <li>
                    <a href="#messages" role="tab" data-toggle="tab">
                        <i class="fa fa-envelope"></i> Messages
                    </a>
                </li>
                <li>
                    <a href="#settings" role="tab" data-toggle="tab">
                        <i class="fa fa-cog"></i> Settings
                    </a>
                </li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane fade active in" id="home">
                    <h2>Home Content Goes Here</h2>
                    <img src="http://lorempixel.com/400/400/cats/1" alt="Cats"/>
                </div>
                <div class="tab-pane fade" id="profile">
                    <h2>Profile Content Goes Here</h2>
                    <img src="http://lorempixel.com/400/400/cats/2" alt="Cats"/>
                </div>
                <div class="tab-pane fade" id="messages">
                    <h2>Messages Content Goes Here</h2>
                    <img src="http://lorempixel.com/400/400/cats/3" alt="Cats"/>
                </div>
                <div class="tab-pane fade" id="settings">
                    <h2>Settings Content Goes Here</h2>
                    <img src="http://lorempixel.com/400/400/cats/4" alt="Cats"/>
                </div>
            </div>

        </div>







        <!-- Post Info -->
        <div style='position:fixed;bottom:0;left:0;    
             background:lightgray;width:100%;'>
            About this SO Question: <a href='http://stackoverflow.com/q/24553105/1366033'>How to create Tabbed Panel in Bootstrap</a><br/>
            Fork This Skeleton Here: <a href='http://jsfiddle.net/KyleMit/kcpma/'>Bootstrap 3.0 Skeleton</a><br/>
            Styled after this (better) template: <a href='http://wrapbootstrap.com/preview/WB066F8J6'>Responsive Tabbed Form</a><br/>                
            </div>

                </body>
                </html>
