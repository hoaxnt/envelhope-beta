extends CanvasLayer

@onready var chop_button = Hud.get_node("ActionButton")
signal action_button_pressed_signal 

var is_action_pressed = false 

func _ready() -> void:
	hide()

func _on_action_button_pressed() -> void:
		action_button_pressed_signal.emit()
		print("is action pressedxxxxxxxxx: ", is_action_pressed)
