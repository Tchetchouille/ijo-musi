extends GridContainer

var possible_images = []
@onready var glyph = preload("res://Scenes/UI/Main Menu/main_menu_glyph.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	possible_images = load_folder("res://Assets/ascii_pona/", ".png")
	populate_grid()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Stolen from: https://forum.godotengine.org/t/how-to-preload-a-folders-worth-of-images-and-put-them-into-an-array/20942/2
func load_folder(path : String, format : String):
		var list: Array = []
		var dir = DirAccess.open(path)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			# Stops if no more files
			while file_name != "":
				file_name = dir.get_next()
				# Ignores directories, files staring with "." and files that are not of the desired format
				if !dir.current_is_dir() and !file_name.begins_with(".") and file_name.ends_with(format):
					list.append(load(path + "/" + file_name))
			dir.list_dir_end()
		return list

func populate_grid():
	for n in range(columns ** 2):
		var r = randi() % possible_images.size()
		var child = glyph.instantiate()
		child.texture = possible_images[r]
		add_child(child)
