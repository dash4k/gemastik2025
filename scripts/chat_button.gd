extends DefaultButton

@export var default_icon : String 
@export var second_icon : String

@onready var chat_window: TextureButton = $"../../../ChatWindow"


func new_message() -> void:
	self.texture_normal = load(second_icon)

func reset_icon() -> void:
	self.texture_normal = load(default_icon)
	chat_window.show()

func _ready_addon():
	new_message()


func _on_pressed_do():
	reset_icon()
