extends Node2D

@onready var camera : Camera2D = $Player/Camera2D
@onready var objective_label = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel")
@onready var NPC_DATA = SaveLoad.load_game(SaveLoad.NPC_DATA_PATH) 
@onready var objective_label_anim = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
var sfx = StreamAudio.get_node("Sfx")

func _ready() -> void:
	camera.limit_left = 1
	camera.limit_top = 1
	camera.limit_right = 1710
	camera.limit_bottom = 730
	Hud.show()
	
	if NPC_DATA["diver_objective"] == "completed":
		objective_label.text = NPC_DATA["list_of_objectives"]["survive_day_1"]
		sfx.stream = StreamAudio.typing
		sfx.play()
		objective_label_anim.play("show_objective")

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		GlobalState.toggle_pause()
