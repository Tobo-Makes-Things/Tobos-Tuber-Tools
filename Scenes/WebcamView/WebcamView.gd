extends Scene
class_name WebcamView

var camera_feed:CameraFeed
@onready var txr2_Camera:TextureRect = $cvl2_UI/txr2_Camera


func _ready() -> void:
	get_window().close_requested.connect(hide_window)
	camera_feed = WebcamHandler.get_feed(1)
	
	camera_feed.set_format(1, {"copy":true})

	_cam_tex().camera_feed_id = camera_feed.get_id()
	
	camera_feed.feed_is_active = true

func _cam_tex() -> CameraTexture:
	return txr2_Camera.texture as CameraTexture

func hide_window() -> void:
	get_window().visible = false

func _exit_tree() -> void:
	get_window().close_requested.disconnect(hide_window)

static func create() -> WebcamView:
	return load("res://Scenes/WebcamView.tscn").instantiate()
