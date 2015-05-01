<?php
include('login.php'); // Includes Login Script
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Maya Ön Kayıt Login</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div id="main">
            <h1>Maya Ön Kayıt  Login</h1>
            <div id="login">
                <h2>Login</h2>
                <form action="" method="post">
                    <label>Kullanıcı Adı :</label>
                    <input id="name" name="username" type="text">
                    <label>Şifre :</label>
                    <input id="password" name="password" type="password">
                    <input name="submit" type="submit" value=" Login ">
                    <span><?php echo $error; ?></span>
                </form>
            </div>
        </div>
    </body>
</html>