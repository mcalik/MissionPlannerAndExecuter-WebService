<?php
 
$response = array();
 
require_once __DIR__ . '/db_connect.php';
 
$db = new DB_CONNECT();
 

    $SQL= mysql_query("select * from message_list");
 
    if (!empty($SQL)) {
        if (mysql_num_rows($SQL) > 0) {
             $response["message"] = array();

            while ($row= mysql_fetch_array($SQL)){
 
            $message= array();
            $message["id"] = $row["id"];
            $message["message"] = $row["message"];

            array_push($response["message"], $message);

            }
            $response["success"] = 1;
            echo json_encode($response);
}
}

?>