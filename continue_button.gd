@tool
extends TextureButton

@onready var mat := material as ShaderMaterial
@onready var label: Label = $Label
@export var route : PackedScene = preload("res://scenes/main_scene.tscn")
@export var text: String = "Button" :
	set(value):
		_text = value
		if is_instance_valid(label):
			label.text = value
	get:
		return _text

var _text := text  # backing field for the exported variable

func _ready():
	label.text = text

	self.material = (self.material as ShaderMaterial).duplicate()
	mat = self.material

	self.connect("mouse_entered", Callable(self, "_on_hover_entered"))
	self.connect("mouse_exited", Callable(self, "_on_hover_exited"))
	self.connect("button_down", Callable(self, "_on_pressed"))
	self.connect("button_up", Callable(self, "_on_released"))

func _on_hover_entered():
	mat.set_shader_parameter("hovering", 1.0)

func _on_hover_exited():
	mat.set_shader_parameter("hovering", 0.0)

func _on_pressed():
	print("di script awal berhasil")
	mat.set_shader_parameter("pressed", 1.0)

func _on_released():
	mat.set_shader_parameter("pressed", 0.0)
	var instance = route.instantiate()
	get_tree().root.add_child(instance)
	get_tree().current_scene.queue_free()
