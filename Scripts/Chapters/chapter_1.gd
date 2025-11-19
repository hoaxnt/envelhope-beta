extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var hud : CanvasLayer = $Hud
@onready var data = SaveLoad.load_game(SaveLoad.CONFIG_PATH)

#func _ready() -> void:
	#if data.get("user_opened_once") == false:
		#Tutorial.show()
	#else:
		#Tutorial.hide()
	#
	#ObjectiveLabel.display()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
func _on_timer_timeout() -> void:
	if data.get("user_opened_once") == false:
		hud.hide()
		Tutorial.show()
	else:
		Tutorial.hide()
		
	get_tree().paused = true
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
