extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var day_panel = Hud.get_node("DayPanel")

func _ready() -> void:
	day_panel.hide()
	Hud.show()
	print("in Chapter1 user opened: ", GlobalData.config.get("user_opened_once"))
	if not GlobalData.config.get("user_opened_once"):
		tutorial.show()
	else:
		tutorial.hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
