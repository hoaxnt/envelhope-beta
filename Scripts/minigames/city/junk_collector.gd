extends Node2D

@onready var countdown_label = $CanvasLayer/CountdownLabel 
@onready var instructions_panel = $CanvasLayer/InstructionsPanel 
@onready var player = $Player
@onready var background = $Background
@onready var anim = $CanvasLayer/AnimationPlayer
@onready var player_anim = $PlayerAnimation
@onready var summary_panel = $CanvasLayer/SummaryPanel
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var summary_text = $CanvasLayer/SummaryPanel/HBoxContainer/VBoxContainer/MarginContainer/SummaryText

var game_started: bool = false
var is_pressed: bool = false
var countdown_finished: bool = false
var collected_envelopes: int = 0

func _ready() -> void:
	summary_panel.hide()
	score_label.text = "Envelopes: 0"

func _on_start_button_pressed() -> void:
	if is_pressed:
		return
	is_pressed = true
	
	instructions_panel.hide()
	anim.play("countdown")
	
	await anim.animation_finished
	countdown_label.hide()
	
	game_started = true
	player_anim.play("move")
	player.play("default")
	
	await player_anim.animation_finished
	countdown_finished = true
	game_started = false
	
	summary_text.text = "You've earned %s Envelopes!" % str(collected_envelopes)
	player.stop()
	summary_panel.show()
	
func _unhandled_input(event: InputEvent) -> void:
	if not countdown_finished and game_started and event.is_action_pressed("action"):
		collected_envelopes += 1
		score_label.text = "Envelopes: %s" % str(collected_envelopes)
		
func _on_done_button_pressed() -> void:
	summary_panel.hide()
	await Transition.transition_to_scene("res://scenes/chapters/chapter_2.tscn")
	var earned_envelopes = GlobalData.player_data.get("envelopes") + collected_envelopes
	GlobalData.update_player_data("envelopes", earned_envelopes)
	
