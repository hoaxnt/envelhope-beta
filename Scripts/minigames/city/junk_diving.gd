extends Node2D

@onready var anim = $CanvasLayer/AnimationPlayer
@onready var summary_panel = $CanvasLayer/SummaryPanel
@onready var summary_label = $CanvasLayer/SummaryPanel/HBoxContainer/VBoxContainer/SummaryLabel
@onready var countdown_label = $CanvasLayer/Label
@onready var instructions_panel = $CanvasLayer/Instructions


@onready var earnings_label: Label = $CanvasLayer/EarningsLabel


var earnings = 0
var sfx = StreamAudio.get_node("Sfx")

var speed: float = 150.0
var direction: int = 1
var is_moving: bool = false


func _ready():
	instructions_panel.show()
	summary_panel.hide()


func _on_start_button_pressed() -> void:
	instructions_panel.hide()
	countdown_label.show()
	anim.play("countdown")
	await anim.animation_finished
	countdown_label.hide()
	#
	#earnings_label.hide()
	#is_moving = false
	#
	#summary_label.text = "You've earned %s Envelopes!" % str(earnings)
	#
	#var current_envelopes = GlobalData.get_player_data_value("envelopes")
	#var new_total_envelopes = current_envelopes + earnings
	#GlobalData.update_player_data("envelopes", new_total_envelopes)
	#summary_panel.show()

func _on_done_button_pressed() -> void:
	#if player:
		#player.position = GlobalData.load_player_position()
	Transition.transition_to_scene("res://scenes/chapters/chapter_2.tscn")
