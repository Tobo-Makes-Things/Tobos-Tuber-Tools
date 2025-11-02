class_name FileHandler

static var use_full_objects:bool = true;

static func file_exists(filePath: String) -> bool:
	if filePath.begins_with("/") || filePath.contains("://"):
		return FileAccess.file_exists(filePath)
	return FileAccess.file_exists("user://" + filePath)

static func file_get_last_error() -> int:
	return FileAccess.get_open_error()

static func load_json_file(filePath: String) -> Serializable:
	return JSON.to_native(JSON.parse_string(FileAccess.get_file_as_string(filePath)))

static func save_json_file(file:Serializable, filePath:String) -> void:
	FileAccess.open(filePath, FileAccess.WRITE).store_string(file.serialize())

static func load_file(filePath: String) -> Serializable:
	return FileAccess.open(filePath, FileAccess.READ).get_var(use_full_objects) as Serializable

static func save_file(file:Serializable, filePath:String) -> void:
	FileAccess.open(filePath, FileAccess.WRITE).store_var(file, use_full_objects)

static func _get_permissions_from_string(filePermissions:String) -> FileAccess.ModeFlags:
	match filePermissions.to_lower():
		"rw":
			return FileAccess.READ_WRITE
		"-w":
			return FileAccess.WRITE
		"wr":
			return FileAccess.WRITE_READ
		_:
			return FileAccess.READ
