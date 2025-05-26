extends ExternalFile
class_name Preference

var default_clear_color:Color:
	get:
		return ProjectSettings.get("rendering/environment/defaults/default_clear_color")
	set(value):
		ProjectSettings.set("rendering/environment/defaults/default_clear_color", value)
		RenderingServer.set_default_clear_color(value)

var transparent_window:bool:
	get:
		return ProjectSettings.get("display/window/size/transparent")
	set(value):
		ProjectSettings.set("display/window/size/transparent", value)
		Root.instance.window.transparent = value

var window_size:Vector2i:
	get:
		return DisplayServer.window_get_size()
	set(value):
		DisplayServer.window_set_size(value)

func with_clear_color(newcolor:Color) -> Preference:
	default_clear_color = newcolor
	return self

func with_transparent_window(istransparent:bool) -> Preference:
	transparent_window = istransparent
	return self

func with_window_size(size:Vector2i) -> Preference:
	window_size = size
	return self

static func convert(file:ExternalFile) -> Preference:
	return file as Preference

static func load_default(with_transparency:bool = false) -> Preference:
	return Preference.new()\
		.with_clear_color(Color8(127,252,127))\
		.with_transparent_window(with_transparency)\
		.with_window_size(Vector2i(1280, 720))
