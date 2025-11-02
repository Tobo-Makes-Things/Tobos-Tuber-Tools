class_name Serializable

func save() -> void:
	FileHandler.save_file(self, "user://%s%s" % [get_class_name().to_lower(), get_file_extension()])

func serialize() -> String:
	return JSON.stringify(JSON.from_native(self, FileHandler.use_full_objects))

func load_values() -> Serializable:
	push_error("%s: Load values needs to be overwritten in order to function." % get_class_name())
	return null

func get_file_extension() -> String:
	return ".tttfile"

func get_class_name() -> String:
	return "Serializable"