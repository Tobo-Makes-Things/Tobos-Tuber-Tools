extends Node2D
class_name Root

static var app_name:String:
	get:
		return ProjectSettings.get("application/config/name")

static var instance:Root
@onready var viewport:Viewport = instance.get_viewport()
@onready var window:Window = instance.get_window()

var activePreference:Preferences

var activeScene:Scene
var activeAvatar:Avatar
var activeSubwindow:SceneWindow

var _handled_input:bool = false

func _init() -> void:
	instance = self
	WebcamHandler.print_feeds()

func _ready() -> void:
	# activePreference = Preferences.load_default(false)
	if FileHandler.file_exists("preferences.tttpref"):
		activePreference = FileHandler.load_file("user://preferences.tttpref")
		activePreference.load_values()
	
	if FileHandler.file_exists("preferences.tttpref") && FileHandler.file_get_last_error() == 0:
		with_scene(Profile.create())
		return

	activePreference = Preferences.load_default()
	activePreference.save()
	with_scene(Profile.create())

func _input(event: InputEvent) -> void:
	_handled_input = false
	if Input.is_action_just_pressed("ui_cancel"):
		_handled_input = true
		if activeSubwindow != null:
			if activeSubwindow.is_inside_tree():
				activeSubwindow.visible = true
			else:
				add_child(activeSubwindow)
		else:
			with_second_window_scene(Menu.create())\
				.activeSubwindow\
					.with_name("Menu")\
					.with_minimum_size(Vector2i(640, 360))
	
	if !_handled_input && event is InputEventKey:
		if activeScene is Profile:
			activeScene.should_show_help = true
			await get_tree().create_timer(4.0).timeout
			activeScene.should_show_help = false

func _physics_process(_delta: float) -> void:
	print(1)

func with_scene(newscene:Scene) -> Root:
	if activeScene != null:
		if activeScene.is_inside_tree():
			activeScene.queue_free()
		activeScene = null
	activeScene = newscene
	add_child(activeScene)
	return self

func with_avatar(newavatar:Avatar) -> Root:
	if activeAvatar != null:
		if activeAvatar.is_inside_tree():
			activeAvatar.queue_free()
		activeAvatar = null
	activeAvatar = newavatar
	add_child(activeAvatar)
	return self

func with_second_window_scene(newscene:Node) -> Root:
	if activeSubwindow != null:
		if activeSubwindow.is_inside_tree():
			activeSubwindow.queue_free()
		activeSubwindow = null
	activeSubwindow = SceneWindow.new()\
		.with_scene(newscene)\
		.with_minimum_size()
	add_child(activeSubwindow)
	return self
