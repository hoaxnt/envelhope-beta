extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var player = get_node("/root/Chapter1/Player")

@onready var hunger_bar: ProgressBar = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar")
@onready var hunger_timer: Timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")
@onready var day_panel = Hud.get_node("DayPanel")

func _ready() -> void:
	hunger_bar.value = GlobalData.player_data.get("hunger")
	hunger_timer.start()
	
	if not GlobalData.config.get("is_new_game"):
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
		
