extends CanvasLayer
	
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
	
func _ready() -> void:
	tutorial.hide()
	
func _on_button_pressed() -> void:
	tutorial.hide()
	SaveLoad.save_game({"user_opened_once" : true}, SaveLoad.CONFIG_PATH)
