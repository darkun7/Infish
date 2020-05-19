extends HTTPRequest

export var url = "https://worshipped-courts.000webhostapp.com/"
var session_path = "user://session.json"

var server_data
var default_data = {
            username = "Tester",
            password = "",
            role = ""
        }
var data = {}

func _ready():
	readSession()
	self.connect("request_completed", self, "_catch_response")
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
	#var data_received = yield(self, "request_completed")  #await like function
	#var raw_response  = JSON.parse(data_received[3].get_string_from_utf8()).result
	#print(raw_response)
	#print("P")

func readSession():
	var data
	var file = File.new()

	if not file.file_exists(session_path):
		print('gaada yg di load bos')
		createSession()

	file.open(session_path, File.READ)
	data = JSON.parse(file.get_as_text())
	file.close()
	return data.result

func pushSession(key : Array, value : Array):
	var data
	var session = readSession()
	for n in range(len(key)):
		session[key[n]] = value[n]
	saveSession(session)
	return true

func saveSession(data):
	var file = File.new()
	
	file.open(session_path, File.WRITE)
	file.store_line(JSON.print(data))
	file.close()
	return true

func createSession():
	data = default_data.duplicate(true)