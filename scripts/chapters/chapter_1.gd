extends Node2D

@onready var global_state = get_node("/root/GlobalState")
@onready var tutorial = Hud.get_node("Tutorial")
@onready var hunger_bar: ProgressBar = Hud.get_node("StatsPanel/MarginContainer/Panel/HBoxContainer/VBoxContainer/HBoxContainer/HungerBar")
@onready var day_panel = Hud.get_node("DayPanel")
@onready var objective_label_anim : AnimationPlayer = Hud.get_node("ObjectivePanel/MarginContainer/ObjectiveLabel/ObjectiveTextAnimation")
@onready var player: Node = get_node_or_null("/root/Chapter1/Player")

@export var one_time_tutorial : CanvasLayer
@export var guide_label : Label
@export var wasd : Area2D
@export var e: Area2D
@export var i: Area2D

var current_one_time_monitor: String

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

func _on_wasd_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and GlobalData.config.get("user_opened_once") == false:
		guide_label.text = "Move around by pressing [W A S D] keys"
		one_time_tutorial.show()
		current_one_time_monitor = "wasd"
		
func _on_e_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and GlobalData.config.get("user_opened_once") == true:
		guide_label.text = "Pickup items using [E] key on the keyboard"
		one_time_tutorial.show()
		current_one_time_monitor = "e"
		
func _on_i_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and GlobalData.config.get("user_opened_once") == true:
		guide_label.text = "You can check your inventory by pressing [I] key"
		one_time_tutorial.show()
		current_one_time_monitor = "i"
		
func _on_close_one_time_button_pressed() -> void:
	if current_one_time_monitor == "wasd":
		if GlobalData.config.get("user_opened_once") == false:
			GlobalData.update_config_data("user_opened_once", true)
		wasd.monitoring = false
	elif current_one_time_monitor == "e":
		e.monitoring = false
	elif current_one_time_monitor == "i":
		i.monitoring = false
	one_time_tutorial.hide()
