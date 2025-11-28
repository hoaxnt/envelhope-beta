extends CanvasLayer

@onready var objective_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var sfx = StreamAudio.get_node("Sfx")


func _ready() -> void:
	tutorial.hide()
	
func _on_button_pressed() -> void:
	if not GlobalData.config.get("user_opened_once"):
		GlobalData.update_config_data("user_opened_once", true)
	
	sfx.stream = StreamAudio.button_press
	sfx.play()
	tutorial.hide()
	objective_anim.play("show_objective")
