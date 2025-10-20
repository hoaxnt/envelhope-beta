extends CanvasLayer

var game_stats = {
	"hunger": 100.0,
	"envelopes": 10000,
	"cycle": 10
}
var loaded_data = {}

func _ready() -> void:
	SaveLoad.save_game(game_stats)
	pass

func _on_bag_button_pressed() -> void:
	SaveLoad.load_game()
	print("bug")

func _on_view_quest_button_pressed() -> void:
	print("view quest")
