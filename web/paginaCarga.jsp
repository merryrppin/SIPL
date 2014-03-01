<%-- 
    Document   : paginaCarga
    Created on : 01-mar-2014, 18:26:39
    Author     : WM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css" />
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="jquery/jquery-1.10.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script type="text/javascript">
            var counter = 0;
            setTimeout(function() {
                if(counter!==0){
                    $('.progress .progress-bar').each(function() {
                    var me = $(this);
                    var perc = me.attr("data-percentage");
                    var current_perc = 0;
                    var progress = setInterval(function() {
                        if (current_perc >= perc) {
                            clearInterval(progress);
                        } else {
                            current_perc += 1;
                            me.css('width', (current_perc) + '%');
                        }
                        me.text((current_perc) + '%');
                    }, 100);
                });
                }
            }, 300);
            function showDiv()
            {
                ('.div_bar').style.visibility='hidden';
            }
            function onCharge(){
                document.getElementById("div_bar").style.visibility = "hidden";
            }
        </script>
        <title>JSP Page</title>
    </head>
    <body onload="onCharge">
        <div class="row">
            <div class="col-xs-12 col-sm-3" align="center">

            </div>
            <div class="col-xs-12 col-sm-6" align="center">
                <div class="progress">
                    <div id="div_bar" class="progress-bar" style="float: left; width: 0%; " data-percentage="100"></div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-3" align="center">

            </div>
        </div>
    </body>
</html>
