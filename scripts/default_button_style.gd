extends TextureButton
class_name DefaultButton

@onready var mat := material as ShaderMaterial

func _ready():
	_ready_addon()
	
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
	mat.set_shader_parameter("pressed", 1.0)
	await get_tree().create_timer(0.3).timeout
	_on_pressed_do()

func _on_released():
	mat.set_shader_parameter("pressed", 0.0)

func _on_pressed_do():
	pass

func _ready_addon():
	pass
