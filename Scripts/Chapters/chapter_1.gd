extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)

func _ready() -> void:
	Hud.show()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
func _on_timer_timeout() -> void:
	if CONFIG.get("user_opened_once") == false:
		Tutorial.show()
	else:
		Tutorial.hide()
		
