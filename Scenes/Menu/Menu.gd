extends Control
class_name Menu

@onready var btn2_View_Webcam:Button = $vbc2_Menu/hbc2_Title_Bar/btn2_View_Webcam

var webcam_window:Window = Window.new()

func _init() -> void:
	webcam_window.visible = false
	webcam_window.min_size = Vector2i(1280, 720)

func _ready() -> void:
	webcam_window.add_child(WebcamView.create())
	add_child(webcam_window)
	get_window().close_requested.connect(hide_webcam)
	btn2_View_Webcam.button_up.connect(view_webcam)

func view_webcam() -> void:
	webcam_window.visible = true

func hide_webcam() -> void:
	webcam_window.visible = false

func _exit_tree() -> void:
	get_window().close_requested.disconnect(hide_webcam)
	btn2_View_Webcam.button_up.disconnect(view_webcam)

	webcam_window.queue_free()

static func create() -> Menu:
	return load("res://Scenes/Menu.tscn").instantiate()
