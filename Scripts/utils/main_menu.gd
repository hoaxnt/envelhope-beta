extends Control

var bgm_sfx = StreamAudio.get_node("Bgm")
var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	bgm_sfx.play()
	SaveLoad.save_game({"user_opened_once":false}, SaveLoad.CONFIG_PATH)

#const CONFIG_PATH = "user://config.json"
#const PLAYER_DATA_PATH = "user://player_data.json" 
#const NPC_DATA_PATH = "user://npc_data.json"
#const INVENTORY_PATH = "user://inventory.json"

func _on_start_button_pressed() -> void:
	SaveLoad.save_game(GameData.PLAYER_STATS, SaveLoad.PLAYER_DATA_PATH)
	SaveLoad.save_game(GameData.INVENTORY, SaveLoad.INVENTORY_PATH)
	SaveLoad.save_game(GameData.NPC_DATA_STATS, SaveLoad.NPC_DATA_PATH)
	
	sfx.play()	
	Transition.transition_to_scene("res://scenes/stories/startup_story.tscn")

func _on_start_button_3_pressed() -> void:
	sfx.play()

func _on_exit_button_pressed() -> void:
	sfx.play()
	get_tree().quit()
