extends Control

@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer

func _ready() -> void:
	audio_player.play()
