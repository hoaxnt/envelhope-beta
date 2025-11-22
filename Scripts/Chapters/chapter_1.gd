extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")

func _ready() -> void:
	Hud.show()

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
func _on_timer_timeout() -> void:
	if CONFIG.get("user_opened_once") == false:
		tutorial.show()
	else:
		tutorial.hide()
		
