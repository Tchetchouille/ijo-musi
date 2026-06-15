extends VBoxContainer

@onready var menu_theme = preload("res://Resources and Assets/Themes/main_menu.tres")

var grid_dim : int

var play_relative_pos : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_dim = $"../GlyphsManager".columns
	# Used to allign the button with the glyphs
	play_relative_pos = $"../GlyphsManager".play_relative_pos
	populate_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func populate_grid():
	var child
	var play_pos = play_relative_pos * grid_dim - 1
	var credits_pos = play_pos + 3
	var quit_pos = credits_pos + 3
	for i in range(grid_dim):
		var row = HBoxContainer.new()
		row.size_flags_horizontal = SIZE_EXPAND_FILL
		row.size_flags_vertical = SIZE_EXPAND_FILL
		for j in range(3):
			match j:
				0:
					child = Control.new()
					child.size_flags_stretch_ratio = (grid_dim / 2.0 - 3.0) / grid_dim
				1:
					if i == play_pos or i == credits_pos or i == quit_pos:
						child = Button.new()
						child.theme = menu_theme
					else:
						child = Control.new()
					child.size_flags_stretch_ratio = 4.0 / grid_dim
				2:
					child = Control.new()
					child.size_flags_stretch_ratio = (grid_dim / 2.0 - 1.0) / grid_dim
			child.size_flags_horizontal = SIZE_EXPAND_FILL
			child.size_flags_vertical = SIZE_EXPAND_FILL
			child.mouse_filter = MOUSE_FILTER_PASS
			row.add_child(child)
		add_child(row)
