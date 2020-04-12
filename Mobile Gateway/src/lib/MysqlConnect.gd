extends Node

var response

func _ready():
	var query = "SELECT * FROM `users`"
	#var query = "INSERT INTO `users`(`nama_depan`, `nama_belakang`, `notelp`, `email`, `password`, `role`) VALUES ('Josheph','Doe','08116013106','john.doel@infish.com','johndoe','pengusaha')"
	RequestPOST(query)
	print(_get_response())
	pass

func _set_response(value):
	response = value
	pass

func _get_response():
	while(response == null):
		wait(2)
	return parse_json(response)

func RequestGET(query):
	var site    = "https://worshipped-courts.000webhostapp.com/infish_request_get.php?query="
	var headers = ["User-Agent:Firefox/52.0"]
	site += query
	$httpPOST.request(site, headers, false)

func RequestPOST(query):
	query = "query="+query
	var site    = "https://worshipped-courts.000webhostapp.com/infish_request_post.php?"
	var headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: "+str(query.length())]
	$httpPOST.request(site, headers, false, HTTPClient.METHOD_POST, query)

func _on_httpGET_request_completed(result, response_code, headers, body):
	var data = body.get_string_from_utf8()
	print(data) #for queries debugging
	_set_response(data)
	pass
	#var dict = JSON.parse(body.get_string_from_utf8())
	#data =  dict.result

func _on_httpPOST_request_completed(result, response_code, headers, body):
	var data = body.get_string_from_utf8()
	_set_response(data)
	pass
	#var data = {}
	#data = parse_json(body.get_string_from_utf8())

func wait(time):
    $timer.set_wait_time(time)
    $timer.set_timer_process_mode(0)
    $timer.start()
    yield($timer, "timeout")
    print("Timer is done!")
