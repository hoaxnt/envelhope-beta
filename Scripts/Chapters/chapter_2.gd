extends Node2D

@onready var camera : Camera2D = $Player/Camera2D
@onready var objective_label = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel")
@onready var objective_label_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var day_timer = Hud.get_node("DayPanel/DayTimer")
@onready var day_panel = Hud.get_node("DayPanel")
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH) 
@onready var day_label = Hud.get_node("DayPanel/MarginContainer/HBoxContainer/VBoxContainer/DayLabel")
@onready var hunger_bar = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar")
@onready var hunger_bar_timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")
@onready var player = $Player

func _ready() -> void:
	camera.limit_left = 1
	camera.limit_top = 1
	camera.limit_right = 1710
	camera.limit_bottom = 730
	Hud.show()
	day_panel.show()
	day_timer.start()
	
	
	if NPC_DATA["diver_objective"] == "completed":
		player.global_position = GlobalData.load_player_position()
		
		NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
		var day = int(NPC_DATA["day"])
		var survive_day = "survive_day_%s" % str(day)
		day_label.text = "Day %s" % str(day)
		
		objective_label.text = NPC_DATA["list_of_objectives"][survive_day]
		objective_label_anim.play("show_objective")
		
		await objective_label_anim.animation_finished
		if hunger_bar:
			hunger_bar_timer.start()
		
func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		GlobalState.toggle_pause()
