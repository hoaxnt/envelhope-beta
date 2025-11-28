extends Node2D

@onready var anim = $CanvasLayer/AnimationPlayer
@onready var summary_panel = $CanvasLayer/SummaryPanel
@onready var summary_label = $CanvasLayer/SummaryPanel/HBoxContainer/VBoxContainer/SummaryLabel
@onready var countdown_label = $CanvasLayer/Label
@onready var instructions_panel = $CanvasLayer/Instructions
@onready var earnings_label: Label = $CanvasLayer/EarningsLabel
@onready var time_left_timer = $TimeLeft
@onready var timer_label = $CanvasLayer/TimerLabel
@onready var player = get_node("/root/Chapter2/Player")

var sfx = StreamAudio.get_node("Sfx")
var game_started = false

var earnings = 0
var TIME = 60

func _ready():
	instructions_panel.show()
	summary_panel.hide()

func _on_start_button_pressed() -> void:
	instructions_panel.hide()
	countdown_label.show()
	anim.play("countdown")
	
	await anim.animation_finished
	countdown_label.hide()
	game_started = true
	time_left_timer.start()

func _on_done_button_pressed() -> void:
	if player:
		player.position = GlobalData.load_player_position()
	Transition.transition_to_scene("res://scenes/chapters/chapter_2.tscn")

func _on_time_left_timeout() -> void:
	if TIME <= 0:
		time_left_timer.stop()
		TIME = 0
		game_started = false
		summary_label.text = "You've earned %s Envelopes!" % str(earnings)
		summary_panel.show()
		
		var current_envelopes = GlobalData.get_player_data_value("envelopes")
		var new_total_envelopes = current_envelopes + earnings
		GlobalData.update_player_data("envelopes", new_total_envelopes)
		
		return
	TIME -= 1
	timer_label.text = "Time left: %s" % TIME
	
