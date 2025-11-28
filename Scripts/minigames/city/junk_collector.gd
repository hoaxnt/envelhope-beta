extends Node2D # Assuming this script is on a main UI node

@onready var countdown_label = $CanvasLayer/CountdownLabel #get_node("CanvasLayer/Instructions/HBoxContainer/VBoxContainer/MarginContainer/Text")
@onready var instructions_panel = $CanvasLayer/InstructionsPanel #get_node("CanvasLayer/Instructions")
@onready var anim = get_node("CanvasLayer/AnimationPlayer")

# --- Game State Variables (Good practice for tracking) ---
var game_started: bool = false
var countdown_finished: bool = false

func _ready() -> void:
	print(countdown_label.name)

func _on_start_button_pressed() -> void:
	if game_started:
		return

	instructions_panel.hide()
	
	# Start the countdown animation
	anim.play("countdown")
	
	# Wait for the animation to complete
	await anim.animation_finished
	print("Countdown finished. Game started!")
	countdown_label.hide()
	
	countdown_finished = true
	game_started = true
	


func _unhandled_input(event: InputEvent) -> void:
	if countdown_finished and event.is_action_pressed("action"):
		print("TAP (action)")
		# You would add your game logic here (e.g., increment score)
		
func _on_tap_tap_button_button_up() -> void:
	if countdown_finished:
		print("TAP (TapTapButton)")
		# You would add your game logic here (e.g., increment score)
