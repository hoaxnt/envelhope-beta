extends CanvasLayer
	
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	tutorial.hide()
	
func _on_button_pressed() -> void:
	sfx.stream = StreamAudio.button_press
	sfx.play()
	tutorial.hide()
	SaveLoad.save_game({"user_opened_once" : true}, SaveLoad.CONFIG_PATH)
