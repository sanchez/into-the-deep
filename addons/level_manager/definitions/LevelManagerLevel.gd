extends LevelManagerDefinition
class_name LevelManagerLevel


export (String) var FILE_PATH

func load_level():
	return load(FILE_PATH)
