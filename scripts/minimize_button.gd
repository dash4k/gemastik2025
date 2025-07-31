extends DefaultButton

@export var window_name = "Window"

var window_node : TextureButton

func _ready_addon():
	var current = get_parent()
	while current:
		if current.name == window_name:
			window_node = current
			return current
		current = current.get_parent()

func _on_pressed_do():
	if window_node:
		window_node.hide()
