<?php
require_once("conection.php");
header('Content-type: application/json');

$result = array();

if(isset($_POST["query"])){
	//For INSERT or DELETE QUERIES
	$query = $_POST["query"];
	if ($r = $db->query($query) === TRUE) {
		echo json_encode($r);
	} else {
		//For SELECT QUERIES
		$data = mysqli_query($db, $query);
		while($row = mysqli_fetch_array($data, MYSQLI_ASSOC)){
			$result[] = $row;
		}
		echo json_encode($result);
	}
}else{
	echo "Data is not exist";
}
