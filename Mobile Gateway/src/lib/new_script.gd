func talkToServer(url, data):
	# Connect to host/port
	var HTTP = HTTPClient.new()
	var RESPONSE = HTTP.connect_to_host("url", -1, true)
	# Wait until resolved and connected
	while HTTP.get_status() == HTTPClient.STATUS_CONNECTING or HTTP.get_status() == HTTPClient.STATUS_RESOLVING:
		HTTP.poll()
		OS.delay_msec(300)
	# Error catch: Could not connect
	##assert(HTTP.get_status() == HTTPClient.STATUS_CONNECTED)
	# Check for a GET or POST command
	if data == "":
		var HEADERS =["User-Agent: Pirulo/1.0 (Godot)", "Accept: */*"]
		RESPONSE = HTTP.request(HTTPClient.METHOD_GET, url, HEADERS)
	else:
		var fields = {"query": data}
		var QUERY = HTTP.query_string_from_dict(fields)
		print(QUERY)
		var HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: ", "Content-Length: " + str(QUERY.length())]
		RESPONSE = HTTP.request(HTTPClient.METHOD_POST, url, HEADERS, QUERY)
	# Make sure all is OK
	##assert(RESPONSE == 0)
	# Keep polling until the request is going on
	var result = HTTP.has_response()
	print(result)
	while (HTTP.get_status() == HTTPClient.STATUS_REQUESTING):
		HTTP.poll()
		OS.delay_msec(300)
	# Make sure request finished
	##assert(HTTP.get_status() == HTTPClient.STATUS_BODY or HTTP.get_status() == HTTPClient.STATUS_CONNECTED)
	# Set up some variables
	var RB = []
	var CHUNK = 0
	var RESULT = 0
	# Raw data array
	if HTTP.has_response():
		result = HTTP.read_response_body_chunk()
		print(result)
		# Get response headers
		#var headers = HTTP.get_response_headers_as_dictionary()
		#while HTTP.get_status() == HTTPClient.STATUS_BODY:
		#	HTTP.poll()
		#	CHUNK = HTTP.read_response_body_chunk()
		#	if(CHUNK.size() == 0):
		#		OS.delay_usec(100)
		#	else:
		#		RB = RB + CHUNK
		#	HTTP.close()
		#	RESULT = RB.get_string_from_ascii()
	
