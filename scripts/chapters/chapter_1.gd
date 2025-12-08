extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var tutorial = Hud.get_node("Tutorial")
@onready var hunger_bar: ProgressBar = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar")
@onready var day_panel = Hud.get_node("DayPanel")
@onready var objective_label_anim : AnimationPlayer = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var player: Node = get_node_or_null("/root/Chapter1/Player")

func _ready() -> void:
	day_panel.hide()
	Hud.show()
	hunger_bar.value = GlobalData.player_data.get("hunger")
	player.position = GlobalData.load_player1_position()
	
	if not GlobalData.config.get("user_opened_once"):
		tutorial.show()
	else:
		objective_label_anim.play("show_objective")
		tutorial.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		global_state.toggle_pause()
		
