extends Control

var bgm_sfx = StreamAudio.get_node("Bgm")
var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	bgm_sfx.play()
	SaveLoad.save_game({"user_opened_once":false}, SaveLoad.CONFIG_PATH)

func _on_start_button_pressed() -> void:
	sfx.play()
	
	Transition.transition_to_scene("res://scenes/stories/startup_story.tscn")

func _on_exit_button_pressed() -> void:
	sfx.play()
	get_tree().quit()


func _on_start_button_3_pressed() -> void:
	sfx.play()
