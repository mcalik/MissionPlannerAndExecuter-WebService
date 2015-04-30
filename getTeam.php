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
if (isset($_GET["team_id"])) {
    $team_id= $_GET['team_id'];
 
    // get a soldier from products table
    $teamSQL= mysql_query("select * from team where team.id=$team_id");
    
 
    if (!empty($teamSQL)) {
        // check for empty result
        if (mysql_num_rows($teamSQL) > 0) {
 
            $teamSQL= mysql_fetch_array($teamSQL);
 
            $team= array();
            $team["id"] = $teamSQL["id"];
            $team["name"] = $teamSQL["name"];
            $leaderID = $teamSQL["leaderID"];
   
       $leaderSQL= mysql_query("SELECT soldier.id,soldier.name as soldierName,rank.name as rankName,serial FROM soldier,rank WHERE rank.id=rankID and soldier.id = $leaderID");
if (mysql_num_rows($leaderSQL) > 0) {
            $team["leader"]=array();
 $leaderSQL= mysql_fetch_array($leaderSQL);
	    $leader= array();
            $leader["id"] = $leaderSQL["id"];
            $leader["soldierName"] = $leaderSQL["soldierName"];
            $leader["rankName"] = $leaderSQL["rankName"];
            
            array_push($team["leader"], $leader);
}

 
 $soldierSQL= mysql_query("select soldier.id as id,soldier.name as soldierName, rank.name as rankName from teammember,soldier,rank where rank.id= soldier.rankID and soldier.id=teammember.soldierID and teammember.teamID=$team_id");

if (mysql_num_rows($soldierSQL) > 0) {
            $team["soldierList"]=array();

while( $row= mysql_fetch_array($soldierSQL)){
	    $soldierList= array();
            $soldierList["id"] = $row["id"];
            $soldierList["soldierName"] = $row["soldierName"];
            $soldierList["rankName"] = $row["rankName"];
            
            array_push($team["soldierList"], $soldierList);
}
}
            // success
            $response["success"] = 1;
            // user node
            $response["team"] = array();
 
            array_push($response["team"], $team);
 
            // echoing JSON response
            echo json_encode($response);
        } else {
            // no soldier found
            $response["success"] = 0;
            $response["message"] = "No team found";
 
            // echo no users JSON
            echo json_encode($response);
        }
    } else {
        // no soldier found
        $response["success"] = 0;
        $response["message"] = "No team found";
 
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