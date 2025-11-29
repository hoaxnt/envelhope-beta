extends Node2D

@onready var camera : Camera2D = $Player/Camera2D
@onready var day_timer = Hud.get_node("DayPanel/DayTimer")
@onready var day_panel = Hud.get_node("DayPanel")
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH)
@onready var police_npc = load("res://scenes/minigames/city/path_finding/police.tscn")

@onready var objective_label = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel")
@onready var objective_label_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var objective_label_kraken = $CanvasLayer/ObjectiveLabelKraken
@onready var objective_label_anim_kraken = $CanvasLayer/ObjectiveLabelKraken/ObjectiveTextKrakenAnimation

@onready var danger_zone = $DangerZone
@onready var player = $Player
@onready var hunger_bar = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar")
@onready var hunger_timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")

func _ready() -> void:
	camera.limit_left = 1
	camera.limit_top = 1
	camera.limit_right = 1710
	camera.limit_bottom = 730
	Hud.show()
	day_panel.show()
	day_timer.start()
	objective_label_kraken.hide()
	
	if GlobalData.npc_data.get("release_the_kraken") == true:
		spawn_police_squad()
		
	if player:
		player.position = GlobalData.load_player_position()
	
	if GlobalData.npc_data.get("diver_objective") == "completed":
		player.global_position = GlobalData.load_player_position()
		
		var day = GlobalData.npc_data.get("day")
		var survive_day = "survive_day_%s" % str(int(day))

		if GlobalData.npc_data.get("release_the_kraken") == true:
			objective_label_kraken.show()
			objective_label_kraken.text = "RUNN!! RUNNN!! RUNNNN!!"
			objective_label_anim_kraken.play("show_objective")
		else:
			objective_label_kraken.hide()
			objective_label.text = GlobalData.npc_data["list_of_objectives"][survive_day]
			objective_label_anim.play("show_objective")
		
		await objective_label_anim.animation_finished
		hunger_timer.start()#htimer
		print(hunger_timer)

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		GlobalState.toggle_pause()

func _on_danger_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if not GlobalData.npc_data.get("release_the_kraken") and GlobalData.npc_data.get("day") == 4:
			if player:
				GlobalData.save_player_position(player.global_position)
			Hud.hide()
			
			Transition.transition_to_scene("res://Scenes/stories/police_noticed_story.tscn")
			
func spawn_police_squad():
	var spawn_positions = [
	Vector2(1467.0,86.0),
	Vector2(797.0,728.0),
	Vector2(1199.0,715.0)
	]
	for pos in spawn_positions:
		var police_instance = police_npc.instantiate()
		police_instance.position = pos
		add_child(police_instance)
