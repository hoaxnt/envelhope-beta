extends CanvasLayer

@onready var data = SaveLoad.load_game(SaveLoad.CONFIG_PATH)

func _ready() -> void:
	hide()
	
func _on_button_pressed() -> void:
	hide()
	SaveLoad.save_game({"user_opened_once" : true}, SaveLoad.CONFIG_PATH)
