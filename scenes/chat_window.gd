extends TextureButton

var dragged_button : TextureButton

func _ready() -> void:
	self.connect("gui_input", Callable(self, "_on_button_drag").bind(self))

func _on_button_drag(event, button):
	
	## Start dragging if mouse button pressed on the pressed button
	if event is InputEventMouseButton and event.pressed:
		dragged_button = button

	## Move the button as the mouse moves
	elif event is InputEventMouseMotion and dragged_button :
		dragged_button.position += event.relative

	## Drop the button when mouse button released
	elif event is InputEventMouseButton and not event.pressed and dragged_button:
		dragged_button = null
