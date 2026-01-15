extends CanvasLayer

@onready var objective_anim : AnimationPlayer = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var CONFIG = SaveLoad.load_game(SaveLoad.CONFIG_PATH)
@onready var tutorial = Hud.get_node("Tutorial")
@onready var sfx = StreamAudio.get_node("Sfx")
@onready var hunger_timer: Timer = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar/HungerTimer")

func _ready() -> void:
	tutorial.hide()
	
func _on_button_pressed() -> void:
	sfx.stream = StreamAudio.button_press
	sfx.play()
	tutorial.hide()
	objective_anim.play("show_objective")
	
	await objective_anim.animation_finished
	
	if not GlobalData.config.get("user_opened_once"):
		GlobalData.update_config_data("user_opened_once", true)
	hunger_timer.start()
