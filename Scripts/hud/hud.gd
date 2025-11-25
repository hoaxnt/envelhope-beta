extends CanvasLayer

@onready var chop_button = Hud.get_node("ActionButton")
@onready var sfx = StreamAudio.get_node("Sfx")

signal action_button_pressed_signal 

var is_action_pressed = false 

func _ready() -> void:
	hide()

func _on_action_button_pressed() -> void:
	sfx.stream = StreamAudio.chop
	sfx.play()
	action_button_pressed_signal.emit()
