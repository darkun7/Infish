extends HTTPRequest

export var url = "https://worshipped-courts.000webhostapp.com/"

var server_data

func _ready():
	pass

func handleRequest(method: String, data : String):
	match method:
		"GET":  #Err 400 BAD REQUEST, will fix latter
			var site = url+"infish_request_get.php?query="+data
			var headers = ["User-Agent:Firefox/52.0"]
			print(site)
			request(site, headers, false)
		"POST":
			var query = "query="+data
			var site = url+"infish_request_post.php?"
			var headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: "+str(query.length())]
			request(site, headers, false, HTTPClient.METHOD_POST, query)
	var data_received = yield(self, "request_completed")  #await like function
	var raw_response  = JSON.parse(data_received[3].get_string_from_utf8()).result
	print(raw_response)
