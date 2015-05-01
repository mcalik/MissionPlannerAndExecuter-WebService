<?php
 
// include db connect class
require_once __DIR__ . '/db_connect.php';
 
// connecting to db
$db = new DB_CONNECT();

if (isset($_GET["missionID"]) && isset($_GET["soldierID"]) && isset($_GET["toSoldier"]) && isset($_GET["messageID"]) ) {
    $missionID= $_GET['missionID'];
    $soldierID= $_GET['soldierID'];
    $toSoldier= $_GET['toSoldier'];
    $messageID= $_GET['messageID'];
	$dd=date('Y-m-d H:i:s',time());

    mysql_query("insert into radio_message(missionID,soldierID,toSoldier,messageID,time) values ($missionID,$soldierID,$toSoldier,$messageID,'$dd')");
}else{
	echo "required parameters!!";
}

?>