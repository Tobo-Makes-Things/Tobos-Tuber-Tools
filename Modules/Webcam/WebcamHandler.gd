class_name WebcamHandler

static var cameras:Array[String]

static func _static_init() -> void:
	CameraServer.set_monitoring_feeds(true)
	get_feed_names()

static func get_feed_names() -> Array[String]:
	if cameras != null:
		return cameras

	if CameraServer.feeds().size() < 1:
		push_error("No Cameras Connected")
		return []

	cameras = []

	for feed:CameraFeed in CameraServer.feeds():
		cameras.append(feed.get_name())
	
	return cameras

static func get_feed(index:int) -> CameraFeed:
	if CameraServer.feeds().size() < 1:
		push_error("No Cameras Connected")
		return null
	
	return CameraServer.get_feed(index)

static func print_feeds() -> void:
	print("Cameras: ")
	for feed:CameraFeed in CameraServer.feeds():
		print(feed.get_name())