<?php
 
/*
 * Following code will get single soldier details
 * A soldier is identified by soldier id (pid)
 */
 
// array for JSON response
$response = array();
 
// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();
 
// check for post data
if (isset($_GET["serial"])) {
    $serial = $_GET['serial'];
 
    // get a soldier from products table
    $result = mysql_query("SELECT soldier.id,soldier.name,rank.name as rankID,serial FROM soldier,rank WHERE rank.id=rankID and serial = '$serial'");
 
    if (!empty($result)) {
        // check for empty result
        if (mysql_num_rows($result) > 0) {
 
            $result = mysql_fetch_array($result);
 
            $soldier = array();
            $soldier["serial"] = $result["serial"];
            $soldier["id"] = $result["id"];
            $soldier["name"] = $result["name"];
            $soldier["rankID"] = $result["rankID"];
            // success
            $response["success"] = 1;
 
            // user node
            $response["soldier"] = array();
 
            array_push($response["soldier"], $soldier);
 
            // echoing JSON response
            echo json_encode($response);
        } else {
            // no soldier found
            $response["success"] = -99;
            $response["message"] = "No soldier found";
			
			$dd=date('Y-m-d H:m:s',time());
     		mysql_query("insert into mobile_login_attempts(serial,time) values ('$serial','$dd')");

            // echo no users JSON
            echo json_encode($response);
        }
    } else {
        // no soldier found
        $response["success"] = 0;
        $response["message"] = "No soldier found";
 
 $dd=date('Y-m-d H:m:s',time());
     		mysql_query("insert into mobile_login_attempts(serial,time) values ('$serial','$dd')");

        // echo no users JSON
        echo json_encode($response);
    }
} else {
    // required field is missing
    $response["success"] = 0;
    $response["message"] = "serial=".$serial;
 
    // echoing JSON response
    echo json_encode($response);
}
?>