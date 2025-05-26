extends Node2D
class_name Scene

static func create() -> Scene:
	return load("res://Scenes/Scene.tscn").instantiate()