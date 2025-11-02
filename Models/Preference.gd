extends Serializable
class_name Preferences

var default_clear_color:Color:
	get:
		return ProjectSettings.get("rendering/environment/defaults/default_clear_color")
	set(value):
		ProjectSettings.set("rendering/environment/defaults/default_clear_color", value)
		RenderingServer.set_default_clear_color(value)
		s_defClearColor = value

var transparent_window:bool:
	get:
		return ProjectSettings.get("display/window/size/transparent")
	set(value):
		ProjectSettings.set("display/window/size/transparent", value)
		Root.instance.window.transparent = value
		s_transWindow = value

var window_size:Vector2i:
	get:
		return DisplayServer.window_get_size()
	set(value):
		s_windSize = value
		DisplayServer.window_set_size(value)


#region Saves

@export_storage var s_defClearColor:Color
@export_storage var s_transWindow:bool
@export_storage var s_windSize:Vector2i

#endregion

func with_clear_color(newcolor:Color) -> Preferences:
	default_clear_color = newcolor
	return self

func with_transparent_window(istransparent:bool) -> Preferences:
	transparent_window = istransparent
	return self

func with_window_size(size:Vector2i) -> Preferences:
	window_size = size
	return self


func load_values() -> Preferences:
	print(self.serialize())
	return self\
		.with_clear_color(s_defClearColor)\
		.with_transparent_window(s_transWindow)\
		.with_window_size(s_windSize)

static func convert(file:Serializable) -> Preferences:
	return file as Preferences

static func load_default(with_transparency:bool = false) -> Preferences:
	return Preferences.new()\
		.with_clear_color(Color8(127,252,127))\
		.with_transparent_window(with_transparency)\
		.with_window_size(Vector2i(1280, 720))

func get_file_extension() -> String:
	return ".tttpref"

func get_class_name() -> String:
	return "Preferences"