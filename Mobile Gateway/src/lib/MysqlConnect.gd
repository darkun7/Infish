extends Node

var client = HTTPRequest.new()
var _error = ""
var _response
var url = "https://worshipped-courts.000webhostapp.com/infish_request_get.php?query="

signal connection_finished

func _ready():
	#self.connect("connection_finished", self, "_catch_response")
	#var query = "SELECT * FROM `users`"
	#print(_api_request(query))
	#var query = 
	"INSERT INTO `users`(`nama_depan`, `nama_belakang`, `notelp`, `email`, `password`, `role`) VALUES ('Josheph','Doe','08116013106','john.doel@infish.com','johndoe','pengusaha')"
	INSERT INTO `users`(`nama_depan`,`nama_belakang`,`notelp`,`email`,`password`) VALUES ('asd','asd','asd','asd','asd')

	
	#print(get("response"))
	#talkToServer("https://worshipped-courts.000webhostapp.com/infish_request_get.php?", query)
	#print(_on_httpPOST_request_completed())
	#print(_get_response())
	pass





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
	while(_response == null):
		yield(get_tree().create_timer(1.0), "timeout")
	#queue_free()
	var data = parse_json(_response)
	#return "a"
	return data
	
func GetResponse(data):
	var dict = JSON.parse(data.get_string_from_utf8())
	data =  dict.result


func _on_httpGET_request_completed(result, response_code, headers, body):
	var response = body.get_string_from_utf8()
	emit_signal("connection_finished", response)
	pass
	#var dict = JSON.parse(body.get_string_from_utf8())
	#data =  dict.result

func _on_httpPOST_request_completed(result, response_code, headers, body):
	var response = body.get_string_from_utf8()
	emit_signal("connection_finished", response)
	pass
	#var data = {}
	#data = parse_json(body.get_string_from_utf8())

func _catch_response(response):
	_response = response
	#print(_response)
	pass