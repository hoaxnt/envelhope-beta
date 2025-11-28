extends Control

@onready var hunger_timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")
var bgm_sfx = StreamAudio.get_node("Bgm")
var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	bgm_sfx.play()

func _on_continue_button_pressed() -> void:
	Transition.transition_to_scene("res://scenes/chapters/chapter_1.tscn")

func _on_start_button_pressed() -> void:
	sfx.play()
	SaveLoad.save_game(GameData.PLAYER_STATS, SaveLoad.PLAYER_DATA_PATH)
	SaveLoad.save_game(GameData.INVENTORY, SaveLoad.INVENTORY_PATH)
	SaveLoad.save_game(GameData.NPC_DATA_STATS, SaveLoad.NPC_DATA_PATH)
	SaveLoad.save_game(GameData.CONFIG, SaveLoad.CONFIG_PATH)
	GlobalData.update_config_data("is_new_game", false)
	GlobalData.update_config_data("user_opened_once", false)
	
	GlobalData.npc_data.set("diver_objective", "none")
	GlobalData.npc_data.set("current_objective", "none")
	GlobalData.npc_data.set("day", 1)
	
	#GlobalData.update_inventory_data("Log", 0)
	#GlobalData.update_npc_data("current_objective", "none")
	#GlobalData.update_npc_data("diver_objective", "none")
	#day diver_objective release_the_kraken
	
	Transition.transition_to_scene("res://scenes/stories/startup_story.tscn")
	
func _on_start_button_3_pressed() -> void:
	sfx.play()

func _on_exit_button_pressed() -> void:
	hunger_timer.stop()
	sfx.play()
	
	get_tree().quit()
