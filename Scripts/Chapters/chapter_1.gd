extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var day_panel = Hud.get_node("DayPanel")
@onready var player = get_node("/root/Chapter1/Player")

func _ready() -> void:
	
	if GlobalData.config.get("is_new_game"):
		print("CHAPTER 1 new game is ", GlobalData.config.get("is_new_game"), " so position reset to default")
		pass
	else:
		player.position = GlobalData.load_player_position()
		
	day_panel.hide()
	Hud.show()
	
	
	if not GlobalData.config.get("user_opened_once"):
		tutorial.show()
	else:
		tutorial.hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
