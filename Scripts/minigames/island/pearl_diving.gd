extends Node2D

@onready var game_over_panel = $CanvasLayer/Control
@onready var timer_label = $CanvasLayer/SpawnTimer/TimerLabel
@onready var pearl_label = $CanvasLayer/PearlLabel
@onready var restart_button = $CanvasLayer/Control/RestartButton
@onready var final_score_label = $CanvasLayer/Control/FinalScoreLabel

var initial_time: float = 60.0
var time_left: float = initial_time
var pearl_count: int = 0
var game_active: bool = true

func _ready() -> void:
	game_over_panel.hide()

	_update_ui()

	if restart_button:
		restart_button.connect("pressed", _on_restart_button_pressed)

func _process(delta: float) -> void:
	if game_active:
		time_left -= delta

		if time_left <= 0:
			time_left = 0
			_game_over()

		_update_ui()

func _update_ui() -> void:
	timer_label.text = "Time: %02d" % int(time_left)
	pearl_label.text = "Pearls: %d" % pearl_count

func _on_pearl_collected() -> void:
	if game_active:
		pearl_count += 1
		_update_ui()

func deduct_time() -> void:
	if game_active:
		var deduction = 10.0
		time_left = max(0.0, time_left - deduction)
		_update_ui()

		if time_left == 0.0:
			_game_over()

func _game_over() -> void:
	game_active = false

	get_tree().paused = true

	game_over_panel.show()

	if final_score_label:
		final_score_label.text = "GAME OVER\nCollected Pearls: %d" % pearl_count

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
