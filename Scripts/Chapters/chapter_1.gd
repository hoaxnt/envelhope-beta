extends Node2D

@onready var global_state = get_node("/root/GlobalState")

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
