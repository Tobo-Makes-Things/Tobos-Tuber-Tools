extends Object
class_name ExternalFile

var filePath:String = "user://"

#region Statics

static func load_file(filepath:String) -> ExternalFile:
	return ExternalFile.new()\
		.with_file_path(filepath)

#endregion

#region Builder

func with_file_path(newfilepath:String = "user://") -> ExternalFile:
	filePath = newfilepath
	return self

#endregion