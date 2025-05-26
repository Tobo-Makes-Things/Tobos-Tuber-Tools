extends Scene
class_name Profile

static func create() -> Profile:
	return load("res://Scenes/Profile.tscn").instantiate()