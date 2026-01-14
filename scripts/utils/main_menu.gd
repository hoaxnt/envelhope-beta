extends Control

@onready var hunger_timer : Timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")

var sfx = StreamAudio.get_node("Sfx")
var bgm = StreamAudio.get_node("Bgm")

func _ready() -> void:
	bgm.volume_db = 5
	sfx.volume_db = 10
	bgm.play()
	
	if GlobalData.player_data.get("current_chapter") == "none":
		$VBoxContainer/ContinueButton.disabled = true
		
func _on_continue_button_pressed() -> void:
	if GlobalData.player_data.get("current_chapter") == "Chapter1":
		hunger_timer.start()
		Transition.transition_to_scene("res://scenes/chapters/chapter_1.tscn")
	elif GlobalData.player_data.get("current_chapter") == "Chapter2":
		hunger_timer.start()
		Transition.transition_to_scene("res://scenes/chapters/chapter_2.tscn")		

func _on_start_button_pressed() -> void:
	sfx.play()
	GlobalData.update_config_data("is_new_game", false)
	GlobalData.update_config_data("user_opened_once", false)
	GlobalData.update_config_data("current_chapter", "none")
	GlobalData.npc_data.set("diver_objective", "none")
	GlobalData.npc_data.set("current_objective", "none")
	GlobalData.npc_data.set("day", 1)
	GlobalData.npc_data.set("release_the_kraken", false)
	GlobalData.player_data.set("hunger", 100)
	GlobalData.player_data.set("envelopes", 0)
	GlobalData.player_data.set("has_hat", false)
	GlobalData.player_data.set("has_axe", false)
	SaveLoad.save_game(GameData.PLAYER_STATS, SaveLoad.PLAYER_DATA_PATH)
	SaveLoad.save_game(GameData.INVENTORY, SaveLoad.INVENTORY_PATH)
	SaveLoad.save_game(GameData.NPC_DATA_STATS, SaveLoad.NPC_DATA_PATH)
	SaveLoad.save_game(GameData.CONFIG, SaveLoad.CONFIG_PATH)
	
	Transition.transition_to_scene("res://scenes/stories/startup_story.tscn")

func _on_exit_button_pressed() -> void:
	hunger_timer.stop()
	sfx.play()
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	get_child(1).visible = false
	get_child(2).visible = true
	
func _on_check_button_pressed() -> void:
	var master_bus_index = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_bus_index)
	AudioServer.set_bus_mute(master_bus_index, !is_muted)

func _on_close_button_pressed() -> void:
	get_child(1).visible = true
	get_child(2).visible = false
