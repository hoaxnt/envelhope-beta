extends Node2D

@onready var camera : Camera2D = $Player/Camera2D
@onready var objective_label = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel")

func _ready() -> void:
	camera.limit_left = 1
	camera.limit_top = 1
	camera.limit_right = 1710
	camera.limit_bottom = 730
	Hud.show()
	objective_label.text = "Skree"
	

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		GlobalState.toggle_pause()
