
<?php

include('../session.php');

if (isset($_GET['id'])) {
    $id = $_GET["id"];
    $delete = "delete from product where id=$id";
    mysql_query($delete, $connection);
}
header("location:products.php");
?>
