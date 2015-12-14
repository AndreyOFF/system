<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="style.css" />
        <script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="jquery-1.7.2.js"></script>
        <link rel="stylesheet"  type="text/css" href="windowstyle.css" />
        <title>Лаб20</title>
        <script type="text/javascript">
            $(document).ready(function() {

                $("#virus").click(function() {
   
                        
                        $.ajax({
                            type: "POST",
                            url: "info.php",
                            dataType: 'json',
                            data: 'virus=1'
                        });
                });  
                $("#anti").click(function() {
   
                        
                        $.ajax({
                            type: "POST",
                            url: "info.php",
                            dataType: 'json',
                            data: 'anti=1'
                        });
                });
            });
        </script>
    </head>
    <body>
        <div class="info">
            <h1>Вирус-Анитивирус</h1>
            <div class="form">
                <input type="button" value="Вирус" class="button_out" id="virus"/><br/>
                <input type="button" value="Антивирус" class="button_out" id="anti"/><br/>
            </div>
          
    </body>
</html><?php include("Z:\home\lab20.bs\www\info.php"); ?>