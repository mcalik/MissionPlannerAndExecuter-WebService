<?php
 
// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();

if (isset($_GET["mission_id"]) && isset($_GET["soldier_id"]) && isset($_GET["lat"]) && isset($_GET["lon"]) ) {
    $mission_id= $_GET['mission_id'];
    $soldier_id= $_GET['soldier_id'];
    $lat= $_GET['lat'];
    $lon= $_GET['lon'];
    $dd=date('Y-m-d H:i:s',time());
     
    mysql_query("insert into enemy(missionID,soldierID,latitude,longitude,time) values ($mission_id,$soldier_id,$lat,$lon,'$dd')");
    echo "success";
}else{
	echo "required parameters!!";
}

?>