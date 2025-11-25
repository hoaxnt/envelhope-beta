extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var hud : CanvasLayer = $Hud
@onready var camera : Camera2D = $Player/Camera2D

func _ready() -> void:
	camera.limit_left = 1
	camera.limit_top = 1
	camera.limit_right = 1710
	camera.limit_bottom = 730
	hud.show()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
