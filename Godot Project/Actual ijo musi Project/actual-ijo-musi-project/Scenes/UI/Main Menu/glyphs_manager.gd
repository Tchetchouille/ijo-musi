extends GridContainer

var possible_images = []
@onready var basic_glyph = preload("res://Scenes/UI/Main Menu/basic_glyph.tscn")
@onready var title_glyph = preload("res://Scenes/UI/Main Menu/title_glyph.tscn")
@onready var command_glyph = preload("res://Scenes/UI/Main Menu/command_glyph.tscn")

var title_relative_pos = 0.25
var play_relative_pos = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	possible_images = load_folder("res://Assets/ascii_pona/", ".png")
	populate_grid()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Stolen from: https://forum.godotengine.org/t/how-to-preload-a-folders-worth-of-images-and-put-them-into-an-array/20942/2
func load_folder(path : String, format : String):
		var file_names: Array = []
		var files: Array = []
		var dir = DirAccess.open(path)
		if dir:
			dir.list_dir_begin()
			var file_name = "_start"
			# Stops if no more files
			while file_name != "":
				file_name = dir.get_next()
				# Ignores directories, files staring with "." and files that are not of the desired format
				if !dir.current_is_dir() and !file_name.begins_with(".") and file_name.ends_with(format):
					file_names.append(file_name)
			dir.list_dir_end()
			file_names.sort()
			for name in file_names:
				files.append(load(path + "/" + name))
		return files

func populate_grid():
	var title_coordinates = columns ** 2 * title_relative_pos - 0.5 * columns
	var play_coordinates = columns ** 2 * play_relative_pos - 0.5 * columns - 2
	var credits_coordinates = play_coordinates + columns * 3
	var quit_coordinates = play_coordinates + columns * 6
	for n in range(columns ** 2):
		var child
		var i = 0
		# This is a horrible way of doing it but well...
		if n ==  title_coordinates - 1:
			child = title_glyph.instantiate()
			i = 0
		elif n == title_coordinates:
			child = title_glyph.instantiate()
			i = 3
		elif n == play_coordinates + 1 or n == quit_coordinates + 1 or n == credits_coordinates + 1:
			child = command_glyph.instantiate()
			i = 0
		elif n == play_coordinates + 2 or n == quit_coordinates + 2 or n == credits_coordinates + 2:
			child = command_glyph.instantiate()
			i = 3
		elif n == play_coordinates - 1:
			child = command_glyph.instantiate()
			i = 5
		elif n == play_coordinates or n == quit_coordinates:
			child = command_glyph.instantiate()
			i = 0
		elif n == quit_coordinates - 1:
			child = command_glyph.instantiate()
			i = 7
		elif n == credits_coordinates:
			child = command_glyph.instantiate()
			i = 6
		elif n == credits_coordinates - 1:
			child = command_glyph.instantiate()
			i = 2
		else:
			child = basic_glyph.instantiate()
			i = randi() % possible_images.size()
		if (n + columns / 2) % columns == 0:
			i = 3
		if (n + columns / 2 + 1) % columns == 0:
			i = 1
		child.texture = possible_images[i]
		add_child(child)
