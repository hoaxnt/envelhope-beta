extends Control

var bgm_sfx = StreamAudio.get_node("Bgm")
var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	bgm_sfx.play()

func _on_start_button_pressed() -> void:
	sfx.play()
	SaveLoad.save_game(GameData.PLAYER_STATS, SaveLoad.PLAYER_DATA_PATH)
	SaveLoad.save_game(GameData.INVENTORY, SaveLoad.INVENTORY_PATH)
	SaveLoad.save_game(GameData.NPC_DATA_STATS, SaveLoad.NPC_DATA_PATH)
	SaveLoad.save_game(GameData.CONFIG, SaveLoad.CONFIG_PATH)
	GlobalData.update_config_data("is_new_game", false)
	
	Transition.transition_to_scene("res://scenes/stories/startup_story.tscn")
	
func _on_start_button_3_pressed() -> void:
	sfx.play()

func _on_exit_button_pressed() -> void:
	sfx.play()
	get_tree().quit()
