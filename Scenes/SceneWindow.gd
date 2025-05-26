extends Window
class_name SceneWindow

var activeScene:CanvasItem

func _init() -> void:
	transparent = false

func _ready() -> void:
	close_requested.connect(_close)

func _exit_tree() -> void:
	close_requested.disconnect(_close)

func _close() -> void:
	visible = false

func with_scene(newscene:CanvasItem) -> SceneWindow:
	if activeScene != null:
		if activeScene.is_inside_tree():
			activeScene.queue_free()
		activeScene = null
	activeScene = newscene
	add_child(activeScene)
	return self

func with_minimum_size(minimumsize:Vector2i = Vector2i(640, 360)) -> SceneWindow:
	min_size = minimumsize
	if activeScene != null && activeScene is Control:
		(activeScene as Control).custom_minimum_size = minimumsize
	return self

func with_name(newname:String) -> SceneWindow:
	name = "%s Sub-Window" % newname
	title = "%s %s" % [Root.app_name, newname]
	return self