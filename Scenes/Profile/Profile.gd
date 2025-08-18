extends Scene
class_name Profile

@onready var lbl2_Help:Label = $lbl2_Help

var should_show_help:bool = false

static func create() -> Profile:
	return load("res://Scenes/Profile.tscn").instantiate()

func _physics_process(delta: float) -> void:
	if lbl2_Help:
		lbl2_Help.self_modulate.a = lerp(lbl2_Help.self_modulate.a, 1.0 if should_show_help else 0.0, 1 - exp(-4 * delta))