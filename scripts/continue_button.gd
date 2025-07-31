@tool
extends DefaultButton

@onready var label: Label = $Label
@export var route : PackedScene = preload("res://scenes/main_menu.tscn")
@export var text: String = "Button" :
	set(value):
		_text = value
		if is_instance_valid(label):
			label.text = value
	get:
		return _text

var _text := text  # backing field for the exported variable

func _ready_addon():
	label.text = text

func _on_pressed_do():
	var instance = route.instantiate()
	get_tree().root.add_child(instance)
	get_tree().current_scene.queue_free()
