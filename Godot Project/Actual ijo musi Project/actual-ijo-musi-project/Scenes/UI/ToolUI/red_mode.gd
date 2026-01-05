extends Control

@export var current_label : Resource
@onready var words_container = $MarginContainer/VBoxContainer/TextArea/Words
@onready var t = preload("res://Resources and Assets/Themes/tool.tres")

func _ready() -> void:
	for w in current_label.base_label:
		var word = RichTextLabel.new()
		word.text = w
		word.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		word.size_flags_vertical = Control.SIZE_EXPAND_FILL
		words_container.add_child(word)
		word.set_theme(t)
	for _i in words_container.get_children():
		print(_i.text)
