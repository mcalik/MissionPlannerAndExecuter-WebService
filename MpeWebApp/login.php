<?php

session_start(); // Starting Session
$error = ''; // Variable To Store Error Message
if (isset($_POST['submit'])) {
    if (empty($_POST['username']) || empty($_POST['password'])) {
        $error = "Kullanıcı adı veya şifre hatalı";
    } else {
// Define $username and $password
        $username = $_POST['username'];
        $password = $_POST['password'];
// Establishing Connection with Server by passing server_name, user_id and password as a parameter
$connection = @mysql_connect("localhost", "mustafc_mpe", "Team8");
// Selecting Database
        $db = mysql_select_db("mustafc_mpe", $connection);
// SQL query to fetch information of registerd users and finds user match.
        $query = mysql_query("select * from commander where password='$password' AND username='$username'", $connection);
        $rows = mysql_num_rows($query);
        if ($rows == 1) {
            $_SESSION['login_user'] = $username; // Initializing Session
            $user = mysql_fetch_array($query);
                header("location: admin/index.php"); // Redirecting To Other Page
        } else {
            $error = "Kullanıcı adı veya şifre hatalı";
        }
        mysql_close($connection); // Closing Connection
    }
}
?>