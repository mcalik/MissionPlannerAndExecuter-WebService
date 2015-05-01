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

if (isset($_GET["mission_id"]) && isset($_GET["soldier_id"]) ) {
    $mission_id= $_GET['mission_id'];
    $soldier_id= $_GET['soldier_id'];
	
	
	if(isset($_GET["lat"]) && isset($_GET["lon"]) && isset($_GET["status"]) ) {
				    	$lat= $_GET['lat'];
						$lon= $_GET['lon'];
    					$status= $_GET['status'];
						if(($lat != 0 && $lon!=0)||$status != ""){
							$dd=date('Y-m-d H:i:s',time());
							mysql_query("insert into location(missionID,soldierID,latitude,longitude,time,status) values 			($mission_id,$soldier_id,$lat,$lon,'$dd','$status')");
						}
				}
				
					$resultLocationSQL= mysql_query("select * from location where missionID=$mission_id and id in (select max(id) from location where missionID=$mission_id group by soldierID) group by soldierID;");
				if (mysql_num_rows($resultLocationSQL) > 0) {
					$response["location"] = array();
					while ($row= mysql_fetch_array($resultLocationSQL)){
            					$location= array();
								$location["missionID"] = $row["missionID"];
            					$location["soldierID"] = $row["soldierID"];
            					$location["latitude"] = $row["latitude"];
            					$location["longitude"] = $row["longitude"];
            					$location["time"] = $row["time"];
            					$location["status"] = $row["status"];
                        			array_push($response["location"], $location);
					}
				}		
				
 					$enemySQL= mysql_query("select * from enemy where missionID=$mission_id ");
				if (mysql_num_rows($enemySQL) > 0) {
					$response["enemy"] = array();
					while ($row= mysql_fetch_array($enemySQL)){
            					$enemy= array();
								$enemy["id"] = $row["id"];
								$enemy["missionID"] = $row["missionID"];
            					$enemy["latitude"] = $row["latitude"];
            					$enemy["longitude"] = $row["longitude"];
            					$enemy["time"] = $row["time"];
                        		array_push($response["enemy"], $enemy);
					}
				}
				
				$radioMessageSQL= mysql_query("select missionID,toSoldier,time,name,message from radio_message,soldier s,message_list m where m.id=messageID and missionID=$mission_id and (soldierID=-1 or soldierID=s.id) ORDER BY time DESC LIMIT 10");
				if (mysql_num_rows($radioMessageSQL) > 0) {
					$response["message"] = array();
					while ($row= mysql_fetch_array($radioMessageSQL)){
            					$message= array();
								$message["missionID"] = $row["missionID"];
            					$message["name"] = $row["name"];
            					$message["toSoldier"] = $row["toSoldier"];
            					$message["message"] = $row["message"];
            					$message["time"] = $row["time"];
                        		array_push($response["message"], $message);
					}
				}
				
    $situationSQL= mysql_query("select * from location where missionID=$mission_id");
 
    if (!empty($situationSQL)) {
    //bir girdi olduğunda aktive olduğunu sanıyor sistem sonraki if check i tekrar değiştir
	$response["success"] = 1;
	$response["situation"]="NOTACTIVATED";

        if (mysql_num_rows($situationSQL) > 0) {
        	$situationSQL= mysql_query("select * from location where missionID=$mission_id and status='END'");
		if (mysql_num_rows($situationSQL) > 0) {
			$response["situation"]="END";
        	}else{
     			$situationSQL= mysql_query("select * from location where missionID=$mission_id and status='START'");
			if (mysql_num_rows($situationSQL) > 0) {
				$response["situation"]="STARTED";
				
				

			}else{
		     		$readySQL= mysql_query("select * from location where missionID=$mission_id and status='READY' and soldierID=$soldier_id");
			     	$soldiersReadySQL= mysql_query("select * from location where missionID=$mission_id and status='READY'");
			     	if (mysql_num_rows($readySQL) > 0) {
					$response["situation"]="READY";
					$response["count"]=mysql_num_rows($soldiersReadySQL);
				}else{
					$activateSQL= mysql_query("select * from location where missionID=$mission_id and status='ACTIVATE'");
					if (mysql_num_rows($activateSQL) > 0) {
						$response["situation"]="ACTIVATED";
						$response["count"]=mysql_num_rows($soldiersReadySQL);
					}
				}
			}
        	}
        }
        echo json_encode($response);
    } else {
        $response["success"] = 0;
        $response["message"] = "SQL Problem!";
 
        echo json_encode($response);
    }
} else {
    $response["success"] = 0;
    $response["message"] = "required field is missing";
 
    echo json_encode($response);
}
?>