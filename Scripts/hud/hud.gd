extends CanvasLayer

var game_stats = {
	"hunger": 100.0,
	"envelopes": 10000,
	"cycle": 10
}

func _ready() -> void:
	show()
	SaveLoad.save_game(game_stats, SaveLoad.SAVE_PATH)
	
func _on_bag_button_pressed() -> void:
	get_tree().current_scene.call_deferred("queue_free")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/minigames/island/pearl_diving.tscn")
	print("bug")

func _on_view_quest_button_pressed() -> void:
	print("view quest")
