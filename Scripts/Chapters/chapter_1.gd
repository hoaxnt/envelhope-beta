extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var day_panel = Hud.get_node("DayPanel")

# TASK: FIX CONNECTIONS OF SIGNALS

func _ready() -> void:
	GlobalData.config_updated.connect(_on_user_open)
	print("User open connected")
	day_panel.hide()
	Hud.show()
		
func _on_user_open(key) -> void:
	print("USER OPENED")
	if GlobalData.config.get(key) == false:
		tutorial.show()
		GlobalData.update_config_data("user_opened_once", true)
	else:
		tutorial.hide()

#func _on_timer_timeout() -> void:
	#if not GlobalData.config.get("user_opened_once"):
		#tutorial.show()
		#GlobalData.update_config_data("user_opened_once", true)
	#else:
		#tutorial.hide()
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
