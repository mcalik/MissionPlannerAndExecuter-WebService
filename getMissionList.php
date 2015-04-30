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
if (isset($_GET["soldier_id"])) {
    $soldier_id= $_GET['soldier_id'];
 
    // get a soldier from products table
    $missionsSQL= mysql_query("select mission.id,mission.name,teamID,latitude,longitude,time,details,leaderID from mission,team where teamID=team.id and teamID in ( select distinct(teamID) from teammember where soldierID=$soldier_id ) and mission.id not in (select missionID from location where status='END')");
 
    if (!empty($missionsSQL)) {
        // check for empty result
        if (mysql_num_rows($missionsSQL) > 0) {
             $response["mission"] = array();

            while ($row= mysql_fetch_array($missionsSQL)){
 
            $mission= array();
            $mission["id"] = $row["id"];
            $mission["name"] = $row["name"];
            $mission["teamID"] = $row["teamID"];
            $mission["latitude"] = $row["latitude"];
            $mission["longitude"] = $row["longitude"];
            $mission["time"] = $row["time"];
            $mission["details"] = $row["details"];
            $mission["leaderID"] = $row["leaderID"];
            
                        array_push($response["mission"], $mission);

            }
            // success
            $response["success"] = 1;
 
            // user node
 
 
            // echoing JSON response
            echo json_encode($response);
        } else {
            // no soldier found
            $response["success"] = 0;
            $response["message"] = "No mission found";
 
            // echo no users JSON
            echo json_encode($response);
        }
    } else {
        // no soldier found
        $response["success"] = 0;
        $response["message"] = "No mission found";
 
        // echo no users JSON
        echo json_encode($response);
    }
} else {
    // required field is missing
    $response["success"] = 0;
    $response["message"] = "required field is missing";
 
    // echoing JSON response
    echo json_encode($response);
}
?>